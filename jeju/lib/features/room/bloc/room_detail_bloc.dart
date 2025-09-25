import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';
import 'package:jeju_host_app/features/room/repository/room_repository.dart';
import 'package:jeju_host_app/main.dart';

import '../../../core/core.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomDetailBloc extends Bloc<CommonEvent, RoomDetailState> with StreamTransform {
  RoomDetailBloc() : super(const RoomDetailState()) {
    on<Initial>(_onInitial);
    on<ChangeCurrentDate>(_onChangeCurrentDate);
    on<ChangeGuest>(_onChangeGuest);
    on<ChangeDateRange>((event, emit){
      int price = 0;
      int? normalDay = 0;
      int specificDay = 0;
      normalDay = event.dateRange?.duration;
      for(DateManagement k in state.plusPriceList ?? []){
        if(event.dateRange != null && state.plusPriceList != []){
          final start = event.dateRange?.start;
          final end = event.dateRange?.end.subtract(Duration(days: 1));
          if(DateRange(start!, end!).contains(k.date!)){
            logger.d(end);
            price += k.amount!;
            specificDay++;
            // logger.d(end.subtract(Duration(days: 1)));
            logger.d(specificDay);
            normalDay = (event.dateRange!.duration - specificDay);
            emit(state.copyWith(dateRange: event.dateRange, plusPrice: price, specificDay:specificDay,normalDay: normalDay));
          }
        }
      }

      emit(state.copyWith(dateRange: event.dateRange, plusPrice: price, normalDay: normalDay ));
    });
    on<ZoomImage>((event, emit) => emit(state.copyWith(zoomImage: event.zoomImage)), transformer: throttleDroppable());
    on<ShowPrice>((event, emit){
      emit(state.copyWith(showPrice: event.showPrice));
    } , transformer: throttleDroppable());
    on<CreateOrder>(_onCreateOrder);
    on<OnReservation>(_onReservation);

    on<Error>(_onError);
    on<ShowReport>(_onShowReport);
  }

  _onInitial(Initial event, Emitter<RoomDetailState> emit) async {
    await RoomRepository.to.getDetailRoomList(event.id).then((value) {
          List<dynamic> list = value['data']['reservationManagementList'] ?? [];
          List<dynamic> list2 = value['data']['dateManagementList'] ?? [];

          List<DateTime> stopHosting = [];
          List<DateRange> reservationRange = [];
          List<DateManagement> plusPrice = [];
          
          if(list2 != null && list2 != []){
            for(Map<String, dynamic> e in list2){
              if(e['isHosting'] == false && e['date'] != null){
                stopHosting.add( DateTime.parse(e['date']));
              }else if(e['isHosting'] == true && e['amount'] != null){
                plusPrice.add(DateManagement.fromJson(e));
              }
            }
          }
          if(list != null && list != []){
            for(Map<String, dynamic> e in list){
              reservationRange.add( DateRange(DateTime.parse(e['startDate']), DateTime.parse(e['endDate'])));
            }
          }
          if(reservationRange != null && reservationRange != []){
            for(var k in reservationRange){
              for (int i = 0; i <= k.end.difference(k.start).inDays - 1; i++) {
                stopHosting.add(k.start.add(Duration(days: i)));
              }
            }
          }
          logger.d(stopHosting);
          emit(state.copyWith(
          status: CommonStatus.success,
          room: Room.fromJson(value['data']),
          calenderDate: DateTime.now(),
          hostProfile: Profile.fromJson(value['data']['host']),
          stopHosting: stopHosting,
          plusPriceList: plusPrice
      ));
          List<String> guestList = [];
          for(int i = 1;i <= state.room.maximumPeople!; i++){
            guestList.add('${i.toString()}명');
          }
          emit(state.copyWith(guestList: guestList));
    }
    ).catchError((e) {
      // add(Error(e))
      logger.d(e);
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    }
    );
    // emit(state.copyWith(calenderDate: DateTime.now(), room: Room(id: int.parse(event.id), name: '보헤미안 1968년 감성의 집', oneDayAmount: 30000)));
  }

  _onChangeCurrentDate(ChangeCurrentDate event, Emitter<RoomDetailState> emit) {
    if (event.date.isBefore(DateTime(DateTime.now().year, DateTime.now().month, 1))) {
      return;
    }
    emit(state.copyWith(calenderDate: event.date));
  }

  _onChangeGuest(ChangeGuest event, Emitter<RoomDetailState> emit){
      emit(state.copyWith(guestCount: event.guestCount));

  }

  _onShowReport(ShowReport event, Emitter<RoomDetailState> emit){
    emit(state.copyWith(report: event.report));
  }

  _onError(Error event, Emitter<RoomDetailState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onCreateOrder(CreateOrder event, Emitter<RoomDetailState> emit) async {
    try{
      emit(state.copyWith(status: CommonStatus.loading));
      await RoomRepository.to.getOrder().then((value) =>
        emit(state.copyWith(
          status: CommonStatus.success,
          order:value['message'].toString(),

      ))

    );
    }catch (e) {
      logger.d(e);
      add(const Error(LogicalException(message: '주문번호 생성 오류가 발생했습니다.')));
      emit(state.copyWith(status: CommonStatus.failure));
    }
  }

  _onReservation(OnReservation event, Emitter<RoomDetailState> emit) async {
    try{
      emit(state.copyWith(status: CommonStatus.loading));
      logger.d(event.request);
      await ReservationRepository.to.postReservation(event.accommodationId, event.request).then((value) =>
          // logger.d(value.toString())
          emit(state.copyWith(
            status: CommonStatus.success,

          ))

      );
    }catch (e) {
      logger.d(e);
      emit(state.copyWith(status: CommonStatus.failure));
    }
  }
}



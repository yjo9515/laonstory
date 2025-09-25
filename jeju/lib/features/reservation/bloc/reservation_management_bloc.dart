import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';
import 'package:jeju_host_app/features/room/repository/room_repository.dart';

import '../../../core/core.dart';

import '../../../core/usecases/room_usecase.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationManagementBloc extends Bloc<CommonEvent, ReservationManagementState> {
  ReservationManagementBloc() : super(const ReservationManagementState()) {
    on<Initial>(_onInitial);
    on<Property>(_onProperty);
    on<ChangeDate>((event, emit) {
      emit(state.copyWith(calendarDate: event.date));
      state.calendarController?.goToDate(event.date);
    });
    on<SwipeDate>((event, emit) async {
      if (event.left) {
        state.calendarController?.swipeToPreviousPage();
        logger.d(state.calendarController?.date);
        logger.d(DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month, 0)));
        logger.d(DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month - 1, 1)));
        if(state.room.id != null){
          await ReservationRepository.to.getHostReservationData(state.room.id,
              DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month, 0))
              ,DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month - 1, 1))
          ).then((value){
            logger.d(value['data']['reservationManagementList']);
            logger.d(value['data']['dateManagementList']);
            Map<String, CalenderEvent> resultMap = {'0': CalenderEvent(
              CalendarEventModel(
                name: '0',
                begin: DateTime(1900, 1, 1),
                end: DateTime(2099, 12, 31),
              ),
            ),};
            try{
              int index = 1;
              for (var map in value['data']['reservationManagementList']) {

                resultMap['$index'] = CalenderEvent(
                    CalendarEventModel(
                      name: '$index',
                      begin: DateTime.parse(map['startDate']),
                      end: DateTime.parse(map['endDate']),
                    ),
                    guestName: map['name'],
                    imageUrl: map['image']['path'] == null ? '$serverUrl/${map['image']['path']}' : 'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                    price: map['totalAmount']);
                index++;

              }
            }catch(e){
              logger.d(e);
            }
            List<dynamic> list = value['data']['reservationManagementList'] ?? [];
            List<dynamic> list2 = value['data']['dateManagementList'] ?? [];
            List<Reservation> reservations = list.map((i) => Reservation.fromJson(i)).toList();
            List<DateManagement> dateManagement = list2.map((i) => DateManagement.fromJson(i)).toList();
            List<DateTime> disableDate = [];
            for(var k in dateManagement){
              if(k.isHosting == false)
              {
                disableDate.add(k.date!);
              }
            }
            emit(state.copyWith(calendarDate: state.calendarController?.date ??DateTime.now() , events: resultMap, reservationList: reservations, dateManagement: dateManagement, disabledDate: disableDate));
            var controller = CrCalendarController(events: state.events.entries.map((e) => e.value.model).toList())..date = state.calendarDate ?? DateTime.now();
            controller.onSwipe = (year, month) {
              add(ChangeDate(DateTime(year, month, 1)));
            };
            emit(state.copyWith(calendarController: controller));
          }).catchError((e) {
            logger.d(e);
            add(Error(e));
          } );
        }
      } else {
        state.calendarController?.swipeToNextMonth();
        if(state.room.id != null){
          await ReservationRepository.to.getHostReservationData(state.room.id,
              DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month + 2, 0))
              ,DateFormat('yyyy-MM-dd').format(DateTime(state.calendarController!.date.year, state.calendarController!.date.month + 1, 1))
          ).then((value){
            logger.d(value['data']['reservationManagementList']);
            logger.d(value['data']['dateManagementList']);
            Map<String, CalenderEvent> resultMap = {'0': CalenderEvent(
              CalendarEventModel(
                name: '0',
                begin: DateTime(1900, 1, 1),
                end: DateTime(2099, 12, 31),
              ),
            ),};
            try{
              int index = 1;
              for (var map in value['data']['reservationManagementList']) {
                resultMap['$index'] = CalenderEvent(
                    CalendarEventModel(
                      name: '$index',
                      begin: DateTime.parse(map['startDate']),
                      end: DateTime.parse(map['endDate']),
                    ),
                    guestName: map['name'],
                    imageUrl: map['image']['path'] != null ? '$imageUrl${map['image']['path']}' : 'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                    price: map['totalAmount']);
                index++;
              }
            }catch(e){
              logger.d(e);
            }
            List<dynamic> list = value['data']['reservationManagementList'] ?? [];
            List<dynamic> list2 = value['data']['dateManagementList'] ?? [];
            List<Reservation> reservations = list.map((i) => Reservation.fromJson(i)).toList();
            List<DateManagement> dateManagement = list2.map((i) => DateManagement.fromJson(i)).toList();
            List<DateTime> disableDate = [];
            for(var k in dateManagement){
              if(k.isHosting == false)
              {
                disableDate.add(k.date!);
              }
            }
            emit(state.copyWith(calendarDate: state.calendarController?.date ??DateTime.now() ,  events: resultMap, reservationList: reservations, dateManagement: dateManagement, disabledDate: disableDate, status: CommonStatus.initial));
            var controller = CrCalendarController(events: state.events.entries.map((e) => e.value.model).toList())..date = state.calendarDate ?? DateTime.now();
            controller.onSwipe = (year, month) {
              add(ChangeDate(DateTime(year, month, 1)));
            };
            emit(state.copyWith(calendarController: controller));
            logger.d(resultMap);
          }).catchError((e) {
            logger.d(e);
            add(Error(e));
          } );
        }
      }
      // if(state.room.id != null){
      //   await ReservationRepository.to.getHostReservationData(state.room.id,
      //       DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0))
      //       ,DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1))
      //   ).then((value){
      //     logger.d(value['data']['reservationManagementList']);
      //     logger.d(value['data']['dateManagementList']);
      //     Map<String, CalenderEvent> resultMap = {'0': CalenderEvent(
      //       CalendarEventModel(
      //         name: '0',
      //         begin: DateTime(1900, 1, 1),
      //         end: DateTime(2099, 12, 31),
      //       ),
      //     ),};
      //     try{
      //       int index = 1;
      //       for (var map in value['data']['reservationManagementList']) {
      //         resultMap['$index'] = CalenderEvent(
      //             CalendarEventModel(
      //               name: '$index',
      //               begin: DateTime.parse(map['startDate']),
      //               end: DateTime.parse(map['endDate']),
      //             ),
      //             guestName: map['name'],
      //             imageUrl: map['image']['path'] == null ? '$serverUrl/${map['image']['path']}' : 'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
      //             price: map['totalAmount']);
      //         index++;
      //       }
      //     }catch(e){
      //       logger.d(e);
      //     }
      //     List<dynamic> list = value['data']['reservationManagementList'] ?? [];
      //     List<dynamic> list2 = value['data']['dateManagementList'] ?? [];
      //     List<Reservation> reservations = list.map((i) => Reservation.fromJson(i)).toList();
      //     List<DateManagement> dateManagement = list2.map((i) => DateManagement.fromJson(i)).toList();
      //     List<DateTime> disableDate = [];
      //     for(var k in dateManagement){
      //       if(k.isHosting == false)
      //       {
      //         disableDate.add(k.date!);
      //       }
      //     }
      //     emit(state.copyWith(calendarDate: DateTime.now(), events: resultMap, reservationList: reservations, dateManagement: dateManagement, disabledDate: disableDate));
      //   });
      // }
    });
    on<ChangePickRoom>(_onChangePickRoom);
    on<PageNate>(_onPageNate);
  }

  _onInitial(Initial event, Emitter<ReservationManagementState> emit) async{
    await RoomUseCase.to.getHostRoomList().then((value) async {
      emit(state.copyWith(rooms: value?.data?.items?? []));
      if (state.rooms.isNotEmpty) {
        emit(state.copyWith(room: value?.data?.items?.first ?? const Room()));
        if(state.room.id != null){
          await ReservationRepository.to.getHostReservationData(state.room.id,
              DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0))
              ,DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1))
          ).then((value){
            Map<String, CalenderEvent> resultMap = {'0': CalenderEvent(
              CalendarEventModel(
                name: '0',
                begin: DateTime(1900, 1, 1),
                end: DateTime(2099, 12, 31),
              ),
            ),};
            try{
              int index = 1;
              for (var map in value['data']['reservationManagementList']) {
                resultMap['$index'] = CalenderEvent(
                    CalendarEventModel(
                      name: '$index',
                      begin: DateTime.parse(map['startDate']),
                      end: DateTime.parse(map['endDate']),
                    ),
                    guestName: map['name'],
                    imageUrl: map['image']['path'] != null ? '$imageUrl${map['image']['path']}' : 'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                    price: map['totalAmount']);
                index++;
              }
            }catch(e){
              logger.d(e);
            }
            List<dynamic> list = value['data']['reservationManagementList'] ?? [];
            List<dynamic> list2 = value['data']['dateManagementList'] ?? [];
            List<Reservation> reservations = list.map((i) => Reservation.fromJson(i)).toList();
            List<DateManagement> dateManagement = list2.map((i) => DateManagement.fromJson(i)).toList();
            List<DateTime> disableDate = [];
            for(var k in dateManagement){
              if(k.isHosting == false)
                {
                  disableDate.add(k.date!);
                }
            }
            emit(state.copyWith(calendarDate: DateTime.now(), events: resultMap, reservationList: reservations, dateManagement: dateManagement, disabledDate: disableDate));
          });
        }
        }
      var controller = CrCalendarController(events: state.events.entries.map((e) => e.value.model).toList())..date = state.calendarDate ?? DateTime.now();
      controller.onSwipe = (year, month) {
        add(ChangeDate(DateTime(year, month, 1)));
      };
      emit(state.copyWith(calendarController: controller));
    }).catchError((e) {
      logger.d(e);
      add(Error(e));
    });


  }

  _onChangePickRoom(ChangePickRoom event, Emitter<ReservationManagementState> emit) async {
    emit(state.copyWith(room: event.room));
    logger.d(state.room.id);
    try{
      if(state.room.id != null){
        await ReservationRepository.to.getHostReservationData(state.room.id,
            DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0))
            ,DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1))
        ).then((value){
          logger.d(value['data']['reservationManagementList']);
          Map<String, CalenderEvent> resultMap = {'0': CalenderEvent(
            CalendarEventModel(
              name: '0',
              begin: DateTime(1900, 1, 1),
              end: DateTime(2099, 12, 31),
            ),
          ),};
          try{
            int index = 1;
            for (var map in value['data']['reservationManagementList']) {
              resultMap['$index'] = CalenderEvent(
                  CalendarEventModel(
                    name: '$index',
                    begin: DateTime.parse(map['startDate']),
                    end: DateTime.parse(map['endDate']),
                  ),
                  guestName: map['name'],
                  imageUrl: map['image']['path'] == null ? '$serverUrl/${map['image']['path']}' : 'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                  price: map['totalAmount']);
              index++;
            }
          }catch(e){
            logger.d(e);
          }
          List<dynamic> list = value['data']['reservationManagementList'] ?? [];
          List<dynamic> list2 = value['data']['dateManagementList'] ?? [];
          List<Reservation> reservations = list.map((i) => Reservation.fromJson(i)).toList();
          List<DateManagement> dateManagement = list2.map((i) => DateManagement.fromJson(i)).toList();
          List<DateTime> disableDate = [];
          for(var k in dateManagement){
            if(k.isHosting == false)
            {
              disableDate.add(k.date!);
            }
          }
          emit(state.copyWith(calendarDate: DateTime.now(), events: resultMap, reservationList: reservations, dateManagement: dateManagement, disabledDate: disableDate));
          logger.d(state.events);
        });
      }
    }catch(e){
      logger.d(e);
    }
    logger.d(state.events);
    var controller = CrCalendarController(events: state.events.entries.map((e) => e.value.model).toList())..date = state.calendarDate ?? DateTime.now();
    controller.onSwipe = (year, month) {
      add(ChangeDate(DateTime(year, month, 1)));
    };
    emit(state.copyWith(calendarController: controller));
  }

  _onPageNate(PageNate event, Emitter<ReservationManagementState> emit) async {
    if (!(state.pageInfo?.isLast ?? false)) {
      emit(state.copyWith(status: CommonStatus.loading));
      await RoomUseCase.to.getHostRoomList(page: (state.pageInfo?.page ?? 1) + 1).then((value) {
        emit(state.copyWith(status: CommonStatus.initial, rooms: List.of(state.rooms)..addAll(value?.data?.items ?? []),));
      }).catchError((e) {
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      });
    }
  }

  _onProperty(Property event, Emitter<ReservationManagementState> emit)async{
    emit(state.copyWith(properties: event.property));
  }
}

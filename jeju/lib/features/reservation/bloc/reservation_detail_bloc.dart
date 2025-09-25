import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_event.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';


import '../../../core/core.dart';
import '../../../main.dart';
import 'reservation_state.dart';

class ReservationDetailBloc extends Bloc<CommonEvent, ReservationDetailState> {
  ReservationDetailBloc() : super(const ReservationDetailState()) {
    on<Initial>(_onInitial);
    on<Agree>(_onAgree);
    on<Cancel>(_onCancel);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<ReservationDetailState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    await ReservationRepository.to.getDetailData(event.id).then((value) {
        emit(state.copyWith(
            status: CommonStatus.success,
            reservation:Reservation.fromJson(value['data']),
            room: Room.fromJson(value['data']['accommodation']),
            dto: Dto.fromJson(value['data']['accommodation']['host'])
        ));
    }
    ).catchError((e) {
      add(Error(LogicalException(message: e.toString())));
    }
    );
  }
  _onAgree(Agree event, Emitter<ReservationDetailState> emit) async {
    emit(state.copyWith(agree: event.agree));
  }

  _onCancel(Cancel event, Emitter<ReservationDetailState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    await ReservationRepository.to.cancelReservation(event.id).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      add(Error(LogicalException(message: e.toString())));
    });
  }

  _onError(Error event, Emitter<ReservationDetailState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }
}

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

class HostReservationDetailBloc extends Bloc<CommonEvent, HostReservationDetailState> {
  HostReservationDetailBloc() : super(const HostReservationDetailState()) {
    on<Initial>(_onInitial);
    on<AddMemo>(_onAddMemo);
    on<ChangeMemo>(_onChangeMemo);
  }

  _onInitial(Initial event, Emitter<HostReservationDetailState> emit) async{

  }

  _onChangeMemo(ChangeMemo event, Emitter<HostReservationDetailState> emit) async {

  }

  _onAddMemo(AddMemo event, Emitter<HostReservationDetailState> emit) async {
    emit(state.copyWith( status: CommonStatus.initial));
    await ReservationRepository.to.postMemo(event.reservationId, event.memo).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) => add(Error(e)));

  }
}

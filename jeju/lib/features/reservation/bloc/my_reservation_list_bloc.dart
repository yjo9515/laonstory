import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_management_bloc.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';


import '../../../core/core.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class MyReservationListBloc extends Bloc<CommonEvent, ReservationListState> {
  MyReservationListBloc() : super(const ReservationListState()) {
    on<Initial>(_onInitial);

  }

  _onInitial(Initial event, Emitter<ReservationListState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    await ReservationRepository.to.getData().then((value) {
        emit(state.copyWith(
            status: CommonStatus.success,
            reservationList: value
        ));
    }
    ).catchError((e) =>
        // add(Error(e))
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()))
    );
  }
}

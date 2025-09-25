import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/core/usecases/room_usecase.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';
import 'package:jeju_host_app/features/room/bloc/room_state.dart';

import '../../../core/core.dart';

class HostRoomListBloc extends Bloc<CommonEvent, HostRoomListState> {
  HostRoomListBloc() : super(const HostRoomListState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<HostRoomListState> emit) async{
    await RoomUseCase.to.getHostRoomList().then((value) {
      emit(state.copyWith(rooms: value?.data?.items ?? [], pageInfo: value?.pageInfo, status: CommonStatus.success));

    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
    await ReservationRepository.to.getMyReservationList().then((value) {
      // logger.d(value);
      emit(state.copyWith(reservations: value?.data?.items ?? [], pageInfo: value?.pageInfo, status: CommonStatus.success));
    }).catchError((e){
      logger.d(e);
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });

  }

  _onError(Error event, Emitter<HostRoomListState> emit) {
    logger.d(event.exception.toString());
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    // emit(state.copyWith(status: CommonStatus.initial, errorMessage: ''));
  }



}

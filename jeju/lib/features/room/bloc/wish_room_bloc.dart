import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/room/bloc/wish_room_state.dart';
import 'package:jeju_host_app/features/room/repository/room_repository.dart';

import '../../../core/core.dart';


class WishRoomListBloc extends Bloc<CommonEvent, WishRoomState> {
  WishRoomListBloc() : super(const WishRoomState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<WishRoomState> emit) async {
    try{
      await RoomRepository.to.getWishRoomList().then((value) {
        emit(state.copyWith(roomList: value.data?.items ?? [], status: CommonStatus.success));
      }).catchError((e){
        add(Error(LogicalException(message: e.message)));
      });
    } on ExceptionModel catch (e){
      add(Error(LogicalException(message: e.message)));
    }
  }



  _onError(Error event, Emitter<WishRoomState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }
  
}

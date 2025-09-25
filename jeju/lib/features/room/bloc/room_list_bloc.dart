import 'package:bloc/bloc.dart';

import '../../../core/core.dart';
import 'room_state.dart';

class RoomListBloc extends Bloc<CommonEvent, RoomListState> {
  RoomListBloc() : super(const RoomListState()) {
    on<Initial>(_onInitial);
    on<Search>(_onSearch);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<RoomListState> emit) {
    add(Search(query: event.data));
  }

  _onSearch(Search event, Emitter<RoomListState> emit) async {
    await HomeUsecase.to.getRoomList(search: event.query).then((value) {
      emit(state.copyWith(rooms: value?.data?.items ?? [], pageInfo: value?.pageInfo, status: CommonStatus.success));
    });
  }

  _onError(Error event, Emitter<RoomListState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial, errorMessage: ''));
  }


}

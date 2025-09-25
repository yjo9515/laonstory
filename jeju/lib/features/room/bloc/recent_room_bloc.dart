import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/reservation/repository/reservation_repository.dart';
import 'package:jeju_host_app/features/room/repository/room_repository.dart';
import 'package:jeju_host_app/main.dart';

import '../../../core/core.dart';
import 'room_event.dart';
import 'room_state.dart';

class RecentRoomBloc extends Bloc<CommonEvent, RecentRoomState> with StreamTransform {
  RecentRoomBloc() : super(const RecentRoomState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<RecentRoomState> emit) async {
    await RoomRepository.to.getViewRoomList().then((value) {
      emit(state.copyWith(roomList: value.data?.items ?? [], status: CommonStatus.success));
    }
    ).catchError((e) {
      // add(Error(e))
      logger.d(e);
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    }
    );
    // emit(state.copyWith(calenderDate: DateTime.now(), room: Room(id: int.parse(event.id), name: '보헤미안 1968년 감성의 집', oneDayAmount: 30000)));
  }

  _onError(Error event, Emitter<RecentRoomState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }


}



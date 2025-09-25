import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/setting/repository/board_repository.dart';


import '../../../core/core.dart';
import 'notice_state.dart';


class NoticeBloc extends Bloc<CommonEvent,NoticeState> {
  NoticeBloc() : super(const NoticeState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);

  }

  _onInitial(Initial event, Emitter<NoticeState> emit) async {
    await BoardRepository.to.getBoard('NOTICE').then((value){
      emit(state.copyWith(status: CommonStatus.success, noticeList: value.data?.items ?? []));
    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
  }

  _onError(Error event, Emitter<NoticeState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }
}

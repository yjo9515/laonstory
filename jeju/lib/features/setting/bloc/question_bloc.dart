import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/setting/bloc/question_event.dart';
import 'package:jeju_host_app/features/setting/bloc/question_state.dart';
import 'package:jeju_host_app/features/setting/repository/board_repository.dart';


import '../../../core/core.dart';
import 'notice_state.dart';


class QuestionBloc extends Bloc<CommonEvent,QuestionState> {
  QuestionBloc() : super(const QuestionState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);

  }

  _onInitial(Initial event, Emitter<QuestionState> emit) async {
    await BoardRepository.to.getBoard('ONETOONE').then((value){
      emit(state.copyWith(status: CommonStatus.success, questionList: value.data?.items ?? []));
    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
  }

  _onError(Error event, Emitter<QuestionState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }


}

class QuestionWriteBloc extends Bloc<CommonEvent,QuestionWriteState> {
  QuestionWriteBloc() : super(const QuestionWriteState()) {

    on<ChangeValue>(_onChangeValue);

  }


  _onChangeValue(ChangeValue event, Emitter<QuestionWriteState> emit) {
    if(event.type == 'title'){
      emit(state.copyWith(title: event.value));
    }else{
      emit(state.copyWith(comment: event.value));
    }
  }


}

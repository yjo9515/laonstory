import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/message/bloc/message_event.dart';

import '../../../core/core.dart';
import '../../../core/usecases/mypage_usecase.dart';
import '../repository/message_repository.dart';
import 'message_state.dart';

class MessageDetailBloc extends Bloc<CommonEvent, MessageDetailState> {
  MessageDetailBloc() : super(const MessageDetailState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<SendMessage>(_onSendMessage);
  }


  _onInitial(Initial event, Emitter<MessageDetailState> emit) async {
    if(event.data['type'] == UserType.host){
      
      await MessageRepository.to.getHostMessageList().then((value) => {emit(state.copyWith(status: CommonStatus.success))}).catchError((e) {
        logger.e('error');
      });
    }else{
      await MypageUsecase.to.getProfile(userType: event.data['type']).then((value) => emit(state.copyWith(profile: value?.data)));
      await MessageRepository.to.getUserMessageDetail(event.data['id'].toString()).then((value) => {logger.d(value),emit(state.copyWith( status: CommonStatus.success))}).catchError((e) {
        logger.e('error');
      });
    }
  }

  _onSendMessage(SendMessage event, Emitter<MessageDetailState> emit) async {

    await MessageRepository.to.sendUserMessage({
      'content' : event.content,
      'accommodationId' : event.accommodationId,
      'userId' : event.userId
    }).then((value) => logger.d(value)).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.message));
    });
  }

  _onError(Error event, Emitter<MessageDetailState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }
}

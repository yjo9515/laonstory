import 'package:bloc/bloc.dart';

import '../../../core/core.dart';
import '../repository/message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageListBloc extends Bloc<CommonEvent, MessageListState> {
  MessageListBloc() : super(const MessageListState()) {
    on<Initial>(_onInitial);
    on<GetList>(_onGetList);
  }

  _onInitial(Initial event, Emitter<MessageState> emit) async {
    if(event.data == UserType.host){
      await MessageRepository.to.getHostMessageList().then((value) => {emit(state.copyWith(messageList: value, status: CommonStatus.success))}).catchError((e) {
        logger.e('error');
      });
    }else{
      await MessageRepository.to.getUserMessageList().then((value) => {emit(state.copyWith(messageList: value, status: CommonStatus.success))}).catchError((e) {
        logger.e('error');
      });
    }

  }

  _onGetList(GetList event, Emitter<MessageListState> emit) {}
}

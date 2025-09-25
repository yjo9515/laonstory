import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';

part 'generated/message_state.g.dart';

abstract class MessageState extends CommonState {
  const MessageState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
  });

  @override
  List<Object?> get props => [...super.props];
}

@CopyWith()
class MessageListState extends MessageState {
  const MessageListState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.messageList = const <Message>[],
  });

  final List<Message> messageList;

  @override
  List<Object?> get props => [...super.props, messageList];
}

@CopyWith()
class MessageDetailState extends MessageState {
  const MessageDetailState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.profile
  });

  final Profile? profile;

  @override
  List<Object?> get props => [...super.props, profile];
}

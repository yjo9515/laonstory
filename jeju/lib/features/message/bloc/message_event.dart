import '../../../core/core.dart';

class MessageEvent extends CommonEvent {
  const MessageEvent();
}

class GetList extends MessageEvent {
  const GetList();
}
class SendMessage extends MessageEvent {
  const SendMessage({required this.accommodationId, required this.content, this.userId});
  final int accommodationId;
  final String content;
  final int? userId;
}

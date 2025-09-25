import '../../../core/core.dart';

class MessageRepository with CommonRepository {
  static MessageRepository get to => MessageRepository();

  Future<List<Message>> getHostMessageList() async {
    try {
      var result = await get(hostMessageListUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel<Message>.fromJson(result.$2).data?.items ?? [];
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<List<Message>> getUserMessageList() async {
    try {
      var result = await get(userMessageListUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel<Message>.fromJson(result.$2).data?.items ?? [];
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String,dynamic>> getUserMessageDetail(String id) async {
    try {
      var result = await get('$userMessageListUrl/$id', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String,dynamic>> sendUserMessage(request) async {
    logger.d(request);
    try {
      var result = await post('$serverUrl/user/message/write', query:'accommodationId=${request['accommodationId']}&content=${request['content']}&userId=${request['userId']}',token: TokenType.authToken, );
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }
}

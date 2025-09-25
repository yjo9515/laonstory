import '../../../core/core.dart';

class ReviewRepository with CommonRepository {
  static ReviewRepository get to => ReviewRepository();

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
}

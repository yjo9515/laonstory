import 'package:jeju_host_app/core/domain/model/board_model.dart';

import '../../../core/core.dart';

class BoardRepository with CommonRepository {
  static BoardRepository get to => BoardRepository();

  Future<ListModel<Board>> getBoard(String type) async {
    try {
      var result = await get('$userBoardUrl/list', query: 'page=1&size=10&type=$type', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel.fromJson(result.$2);
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String,dynamic>> patchSetting(body) async {
    try {
      var result = await patch('$notificationUrl/setting', body: body, token: TokenType.authToken);
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

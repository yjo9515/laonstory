import '../../../core/core.dart';

class HomeRepository with CommonRepository {
  static HomeRepository get to => HomeRepository();

  Future<ListModel<Room>> searchRoom({String? search, int? page = 1}) async {
    return await get('$userRoomListUrl/search', query: 'page=$page&search=$search',token:TokenType.authToken ).then((value) => ListModel<Room>.fromJson(value.$2)).catchError((e) {
      throw e;
    });
  }
}

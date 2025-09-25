import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';
import '../widget/edit_reorderable_list_widget.dart';

class RoomRepository with CommonRepository {
  static RoomRepository get to => RoomRepository();

  Future<GeoLocation> getGeo(String address) async {
    try {
      var result = await get(addressUrl, header: {'Authorization': 'KakaoAK 01211a7a0286a92fab97a25284514e4b'}, query: 'query=$address&analyze_type=similar&page1&size=1');
      switch (result.$1) {
        case StatusCode.success:
          return GeoLocation.fromJson(result.$2);
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<List<Kind>> getTheme() async {
    try {
      var result = await get(themeUrl,token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return Model<FacilityThemeData>.fromJson(result.$2).data?.kind ?? [];
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<void> addRoom(Room room, List<XFile> files) async {
    try {
      var result = await postWithImage(addRoomUrl, body: room.toJson(), token: TokenType.authToken, images: files);

      switch (result.$1) {
        case StatusCode.success:
          return;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<ListModel<Room>?> getMyRoomList({int? page}) async {
    try {
      var result = await get(hostRoomListUrl, query: 'page=$page', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel<Room>.fromJson(result.$2);
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getHostDetailRoomList(String? id) async {
    try {
      var result = await get(hostRoomListUrl, param: id, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
        // return ListModel<Room>.fromJson(result.$2);
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<ListModel<Room>> getNewRoomList() async {
    try {
      var result = await get('$serverUrl/user/accommodation/new', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
        return ListModel<Room>.fromJson(result.$2);
        //   return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<ListModel<Room>> getPickRoomList() async {
    try {
      var result = await get('$serverUrl/user/accommodation/pick', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
        return ListModel<Room>.fromJson(result.$2);
          // return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<ListModel<Room>> getViewRoomList() async {
    try {
      var result = await get('$serverUrl/user/accommodation/views', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel<Room>.fromJson(result.$2);
      // return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<bool> editRoom(Room room, List<FileDTO> files) async {
    logger.d(files.toList());
    files.map((e) => e.xfile).toList();
    return await patchWithImage(addRoomUrl, param: room.id.toString(), body: room.toJson(), token: TokenType.authToken, images:files.where((e) => e.xfile != null).map((e) => e.xfile!).toList(),)
        .then((value) => switch (value.$1) {
              StatusCode.success => true,
              _ => throw value.$2,
            })
        .catchError((e) => throw LogicalException(message: e.message));
  }


  Future<Map<String, dynamic>> getDetailRoomList(String? id) async {
    try {
      var result = await get(userRoomListUrl, param: id, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
        // return ListModel<Room>.fromJson(result.$2);
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }
  Future<Map<String, dynamic>> getOrder() async {
    try {
      var result = await get(reservationOrderUrl,token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSearch(body) async {
    try {
      var result = await get(userRoomListUrl,query: 'accommodationPeople=${body['accommodationPeople']}&addressType=${body['addressType']}&checkIn=${body['checkIn']}&checkOut=${body['checkOut']}&endAmount=${body['endAmount']}&facilityThemeId=${body['facilityThemeId']??0}&floorType=${body['floorType']}&startAmount=${body['startAmount']}' , token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postRoomLike(id) async {
    try {
      var result = await post('$serverUrl/user/accommodation/like',param: id.toString(), token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteRoomLike(id) async {
    try {
      var result = await delete('$serverUrl/user/accommodation/like',param: id.toString(), token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }

  Future<ListModel<Room>> getWishRoomList() async {
    try {
      var result = await get('${serverUrl}/user/accommodation/likes', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return  ListModel<Room>.fromJson(result.$2);
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }
}

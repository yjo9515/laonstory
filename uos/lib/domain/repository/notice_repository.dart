import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/board_model.dart';
import 'package:isus_members/domain/model/model.dart';
import 'package:isus_members/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class NoticeRepository with ApiService {
  static NoticeRepository get to => NoticeRepository();

  Future<Map<String, dynamic>> getNotice() async {
    try{
      var result = await get(noticeUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    }catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDetailNotice(id) async {
    try{
      var result = await get('$noticeUrl/$id', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    }catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteNotice(id) async {
    try{
      var result = await delete('$noticeUrl/$id', token: TokenType.authToken,);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    }catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patchNotice(id,title, comment,) async {
    try{
      var result = await patch('$noticeUrl/$id', token: TokenType.authToken, query: 'content=$comment&title=$title');
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    }catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postNotice(title, comment,) async {
    try{
      var result = await post(noticeUrl, token: TokenType.authToken, query: 'content=$comment&title=$title');
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    }catch (e) {
      rethrow;
    }
  }
}
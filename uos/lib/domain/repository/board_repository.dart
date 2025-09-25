import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/board_model.dart';
import 'package:isus_members/domain/model/model.dart';
import 'package:isus_members/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class BoardRepository with ApiService {
  static BoardRepository get to => BoardRepository();

  Future<Map<String, dynamic>> getBoard() async {
    try{
      var result = await get(boardUrl, token: TokenType.authToken);
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

  Future<Map<String, dynamic>> getDetailBoard(id) async {
    try{
      var result = await get('$boardUrl/$id', token: TokenType.authToken);
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

  Future<Map<String, dynamic>> postBoardComment(id, comment) async {
    try{
      var result = await post('$boardUrl/$id/comment', token: TokenType.authToken, query: 'content=${comment ?? ''}');
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

  Future<Map<String, dynamic>> patchBoardComment(id, comment,commentId) async {
    try{
      var result = await patch('$boardUrl/$id/comment/$commentId', token: TokenType.authToken, query: 'content=$comment');
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

  Future<Map<String, dynamic>> deleteBoardComment(id,commentId) async {
    try{
      var result = await delete('$boardUrl/$id/comment/$commentId', token: TokenType.authToken,);
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

  Future<Map<String, dynamic>> deleteBoard(id) async {
    try{
      var result = await delete('$boardUrl/$id', token: TokenType.authToken,);
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

  Future<Map<String, dynamic>> patchBoard(id,title, comment,) async {
    try{
      var result = await patch('$boardUrl/$id', token: TokenType.authToken, query: 'content=$comment&title=$title');
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

  Future<Map<String, dynamic>> postBoard(title, comment,) async {
    try{
      var result = await post(boardUrl, token: TokenType.authToken, query: 'content=$comment&title=$title');
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

  Future<Map<String, dynamic>> postReport(report, idx,) async {
    try{
      var result = await post('${boardUrl}/comment/report', token: TokenType.authToken, body: {
        'idx' : idx,
        'reason' : report
      });
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

  Future<Map<String, dynamic>> postBoardReport(report, idx,) async {
    try{
      var result = await post('${boardUrl}/report', token: TokenType.authToken, body: {
        'idx' : idx,
        'reason' : report
      });
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
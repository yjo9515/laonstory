import 'dart:developer';
import 'package:isus_members/domain/api/api_service.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class SocialRepository with ApiService {
  static SocialRepository get to => SocialRepository();
  Future<Map<String, dynamic>> getCommunity() async {
    try {
      var result = await get(communityUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCommunityDetail(id) async {
    try {
      var result = await get('${communityUrl}/${id}', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addCommunity(data) async {
    try {
      var result = await post('${communityUrl}', body : data, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> modifyCommunity(idx, data) async {
    try {
      var result = await patch('${communityUrl}/${idx}', body : data, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteCommunity(idx) async {
    try {
      var result = await delete('${communityUrl}/${idx}', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

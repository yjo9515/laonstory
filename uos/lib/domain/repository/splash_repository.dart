import 'dart:developer';
import 'package:isus_members/domain/api/api_service.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class SplashRepository with ApiService {
  static SplashRepository get to => SplashRepository();

  Future<Map<String, dynamic>> versionCheck() async {
    try {
      var result = await get(versionCheckUrl, token: TokenType.authToken);
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

  Future<Map<String, dynamic>> serviceCheck() async {
    try {
      var result = await get(alertCheckUrl, token: TokenType.authToken);
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
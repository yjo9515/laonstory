import 'package:isus_members/domain/api/api_service.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class LoginRepository with ApiService {
  static LoginRepository get to => LoginRepository();

  Future<Map<String, dynamic>> login(String? id, String? password) async {
    try {
      var result = await post(loginUrl, body: {'id': id, 'password': password});
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
}

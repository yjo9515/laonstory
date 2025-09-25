import 'package:isus_members/domain/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_url.dart';

class HomeRepository with ApiService {
  static HomeRepository get to => HomeRepository();
  Future<Map<String, dynamic>> getAddress() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('id');
    String? userToken = pref.getString('token');

    var result = await get(addressListURL, header: {
      'Connection': 'Keep-Alive',
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": "utf-8",
      'x-access-id': userId ?? '',
      'x-access-token': userToken ?? ''
    });
    print(result);
    print(result.$1);
    print(result.$2);
    // switch (result.$1) {
    //   case StatusCode.success:
    //     return true;
    //   case StatusCode.notFound:
    //   case StatusCode.unAuthorized:
    //   case StatusCode.badRequest:
    //   case StatusCode.timeout:
    //   case StatusCode.forbidden:
    //   case StatusCode.error:
    //   case StatusCode.multiple:
    //     return false;
    // }
    return result.$2;
  }
}

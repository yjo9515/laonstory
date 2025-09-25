import 'dart:developer';

import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/model.dart';
import 'package:isus_members/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class AddressRepository with ApiService {
  static AddressRepository get to => AddressRepository();

  Future<Map<String, dynamic>> getAddress() async {
    try{
      var result = await get(addressListURL, token: TokenType.authToken);
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

  Future<Map<String, dynamic>> userPassReset(id) async {
    try{
      try {
        var result = await patch('${userDetailUrl}/reset/${id}', token: TokenType.authToken);
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
    }catch(e){
      rethrow;
    }
  }

}

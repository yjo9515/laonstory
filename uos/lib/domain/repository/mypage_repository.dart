import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:isus_members/domain/api/api_service.dart';

import '../../type/emuns.dart';
import '../api/api_url.dart';

class MyPageRepository with ApiService {
  static MyPageRepository get to => MyPageRepository();

  Future<Map<String, dynamic>> getUserDetail(id) async {
    try {
      var result =
          await get('${userDetailUrl}/${id}', token: TokenType.authToken);
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

  Future<Map<String, dynamic>> passwordModify(password, newPassword) async {
    try {
      var result = await patch('${userDetailUrl}/pw',
          body: {'password': password, 'new_password': newPassword},
          token: TokenType.authToken);
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

  Future<Map<String, dynamic>> userModify(
      nickname,
      email,
      phone,
      affiliation,
      dept,
      position,
      researchField,
      firstSocial,
      firstUrl,
      secondSocial,
      secondUrl,
      thirdSocial,
      thirdUrl,
      fourthSocial,
      fourthUrl,
      fifthSocial,
      fifthUrl,
      file,
      fileExt) async {
    var data = {
      'nickname': nickname,
      'email': email,
      'phone': phone,
      'affiliation': affiliation,
      'dept': dept,
      'position': position,
      'research_field': researchField,
      'first_social': firstSocial,
      'first_url': firstUrl,
      'second_social': secondSocial,
      'second_url': secondUrl,
      'third_social': thirdSocial,
      'third_url': thirdUrl,
      'fourth_social': fourthSocial,
      'fourth_url': thirdUrl,
      'fifth_social': fifthSocial,
      'fifth_url': fifthUrl,
    };
    try {
      var result = await postWithFile('${serverUrl}/user/modify',
          body: data,
          token: TokenType.authToken,
          files: file == null ? null : [file],
          fileExt: fileExt ?? null);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } catch (e) {
      const int chunkSize = 1000; // 한번에 출력할 데이터 길이
      int length = e.toString().length;

      for (int i = 0; i < length; i += chunkSize) {
        int end = (i + chunkSize < length) ? i + chunkSize : length;
        print(e.toString().substring(i, end));
      }

      rethrow;
    }
  }

  Future<Map<String, dynamic>> profileChange(userIdx, image, imageExt) async {
    try {
      var result = await postWithImage('${userDetailUrl}/modifyimage',
          body: {'userIdx': userIdx, 'image': image, 'imageExt': imageExt},
          token: TokenType.authToken);
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

  Future<Map<String, dynamic>> memberOut(id) async {
    try {
      var result = await post('${userDetailUrl}/out',
          body: {'idx': id},
          token: TokenType.authToken);
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

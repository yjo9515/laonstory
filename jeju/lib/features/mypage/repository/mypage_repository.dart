import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';

abstract class MypageRepository {
  factory MypageRepository({required UserType userType}) {
    switch (userType) {
      case UserType.guest:
        return GuestMypageRepository.to;
      case UserType.host:
        return HostMypageRepository.to;
    }
  }

  Future<Model<Profile>?> getProfile();

  Future<bool> updateProfile();

  Future<Map<String, dynamic>> postImage(List<XFile> files);
}

class GuestMypageRepository with CommonRepository implements MypageRepository {
  static GuestMypageRepository get to => GuestMypageRepository();

  @override
  Future<Model<Profile>?> getProfile() async {
    return await get(userMyInfoUrl, token: TokenType.authToken).then((
        value) => Model<Profile>.fromJson(value.$2)).catchError((error) {
      throw error;
    });
  }

  @override
  Future<Map<String, dynamic>> postImage(List<XFile> files) async {
    try {
      var result = await postWithImage( '$serverUrl/user/profile',profile: true ,token: TokenType.authToken, images: files);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  @override
  Future<bool> updateProfile() async {
    return await patch(userMyInfoUrl, token: TokenType.authToken).then((
        value) => true).catchError((error) {
      throw error;
    });
  }
}

class HostMypageRepository with CommonRepository implements MypageRepository {
  static HostMypageRepository get to => HostMypageRepository();

  @override
  Future<Model<Profile>?> getProfile() async {
    return await get(hostInfoUrl, token: TokenType.authToken).then((
        value) => Model<Profile>.fromJson(value.$2)).catchError((error) {
      throw error;
    });
  }

  @override
  Future<Map<String, dynamic>> postImage(List<XFile> files) async {
    try {
      var result = await postWithImage( '$serverUrl/host/profile',profile: true, token: TokenType.authToken, images: files);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
}

@override
Future<bool> updateProfile() async {
  return await patch(hostInfoUrl, token: TokenType.authToken).then((
      value) => true).catchError((error) {
    throw error;
  });
}}

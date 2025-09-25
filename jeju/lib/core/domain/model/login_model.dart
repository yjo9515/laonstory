import 'package:json_annotation/json_annotation.dart';

import 'profile_model.dart';

part 'generated/login_model.g.dart';

@JsonSerializable()
class LoginInfo {
  String? authToken;
  String? refreshToken;
  Profile? profile;

  LoginInfo({this.authToken, this.profile, this.refreshToken});

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
}

@JsonSerializable()
class UserInfo {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? email;
  String? gender;
  String? age;
  bool? isGuest;
  String? guestSerial;

  UserInfo({this.id, this.createdAt, this.updatedAt, this.name, this.email, this.gender, this.age, this.isGuest, this.guestSerial});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}

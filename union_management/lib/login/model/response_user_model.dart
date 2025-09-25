import 'package:json_annotation/json_annotation.dart';

import '../../common/model/base_model.dart';

part 'response_user_model.g.dart';

@JsonSerializable()
class ResponseUserModel extends BaseModel {
  Data? data;

  ResponseUserModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) => _$ResponseUserModelFromJson(json);
}

@JsonSerializable()
class Data {
  String? accessToken;
  String? refreshToken;
  UserInfo? userInfo;

  Data({this.accessToken, this.userInfo, this.refreshToken});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
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

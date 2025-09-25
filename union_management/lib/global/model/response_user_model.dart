
import 'package:json_annotation/json_annotation.dart';

part 'response_user_model.g.dart';

@JsonSerializable()
class ResponseUserModel {
  Data? data;
  int? statusCode;
  String? message;

  ResponseUserModel({this.data, this.statusCode, this.message});

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
  String? phoneNumber;
  String? gender;
  String? age;

  UserInfo({this.id, this.createdAt, this.updatedAt, this.name, this.phoneNumber, this.gender, this.age});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}

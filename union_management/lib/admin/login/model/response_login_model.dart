import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';

part 'response_login_model.g.dart';

@JsonSerializable()
class ResponseLoginModel extends BaseModel {
  Data? data;

  ResponseLoginModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) => _$ResponseLoginModelFromJson(json);
}

@JsonSerializable()
class Data {
  String? accessToken;
  String? refreshToken;

  Data({this.accessToken, this.refreshToken});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

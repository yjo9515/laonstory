import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends BaseModel {
  final UserData? data;

  const UserDataModel({this.data, int? statusCode, String? message})
      : super(statusCode: statusCode, message: message);

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}

@JsonSerializable()
class UserData {
  int? member;
  int? delegate;
  int? out;
  int? total;

  UserData({this.member, this.delegate, this.out, this.total});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

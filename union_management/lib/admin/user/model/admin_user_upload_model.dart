import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';

part 'admin_user_upload_model.g.dart';

@JsonSerializable()
class AdminUserUploadModel extends BaseModel {
  StatusData? data;

  AdminUserUploadModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminUserUploadModel.fromJson(Map<String, dynamic> json) => _$AdminUserUploadModelFromJson(json);
}

@JsonSerializable()
class StatusData {
  List<int>? errorData;
  String? status;

  StatusData({this.errorData, this.status});

  factory StatusData.fromJson(Map<String, dynamic> json) => _$StatusDataFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';

part 'admin_info_model.g.dart';

@JsonSerializable()
class AdminInfoModel extends BaseModel {
  AdminData? data;

  AdminInfoModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminInfoModel.fromJson(Map<String, dynamic> json) => _$AdminInfoModelFromJson(json);
}

@JsonSerializable()
class AdminData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? email;
  String? registration;
  String? ceo;
  String? date;
  String? active;
  String? role;

  AdminData({this.id, this.createdAt, this.updatedAt, this.name, this.email, this.registration, this.ceo, this.date, this.active, this.role});

  factory AdminData.fromJson(Map<String, dynamic> json) => _$AdminDataFromJson(json);
}

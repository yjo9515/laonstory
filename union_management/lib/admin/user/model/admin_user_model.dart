import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:union_management/common/util/static_logic.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';

part 'admin_user_model.g.dart';

@JsonSerializable()
class AdminUserModel extends BaseModel {
  Data? data;

  AdminUserModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminUserModel.fromJson(Map<String, dynamic> json) => _$AdminUserModelFromJson(json);
}

@JsonSerializable()
class Data {
  List<User>? items;
  Meta? meta;

  Data({this.items, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@CopyWith()
@JsonSerializable()
class User {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? gender;
  final String? age;
  final String? phoneNumber;
  final String? serialNumber;
  final String? active;
  final String? position;
  final String? memo;
  final String? registrationNumber;
  final String? address;
  final int? point;
  final int? account;
  final int? price;

  const User({
    this.id,
    this.point,
    this.age,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.name,
    this.phoneNumber,
    this.serialNumber,
    this.account,
    this.address,
    this.price,
    this.registrationNumber,
    this.active,
    this.memo,
    this.position,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var data = _$UserFromJson(json);
    data = data.copyWith(
      phoneNumber: decryptData(data.phoneNumber),
      address: decryptData(data.address),
      registrationNumber: decryptData(data.registrationNumber),
    );
    return data;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

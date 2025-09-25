import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/util/static_logic.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  Profile? data;
  int? statusCode;
  String? message;

  ProfileModel({this.data, this.statusCode, this.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

@CopyWith()
@JsonSerializable()
class Profile {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? email;
  final String? gender;
  final String? age;
  final String? registrationNumber;
  final String? phoneNumber;
  final String? address;
  final String? serialNumber;
  final String? role;
  final int? point;
  final int? price;
  final int? account;
  final String? position;
  final Union? union;

  const Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.name,
    this.email,
    this.gender,
    this.age,
    this.registrationNumber,
    this.role,
    this.serialNumber,
    this.point,
    this.account,
    this.price,
    this.phoneNumber,
    this.union,
    this.position,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    var data = _$ProfileFromJson(json);
    data = data.copyWith(
      phoneNumber: decryptData(data.phoneNumber),
      address: decryptData(data.address),
      registrationNumber: decryptData(data.registrationNumber),
    );
    return data;
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Union {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? address;

  Union({this.id, this.createdAt, this.updatedAt, this.name, this.address});

  factory Union.fromJson(Map<String, dynamic> json) => _$UnionFromJson(json);
}

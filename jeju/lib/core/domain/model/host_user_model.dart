import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part "generated/host_user_model.g.dart";

@CopyWith()
@JsonSerializable()
class HostUser {
  final String? businessLicense;
  final Dto? dto;
  const HostUser({
    this.businessLicense,
    this.dto,
  });

  factory HostUser.fromJson(Map<String, dynamic> json) => _$HostUserFromJson(json);

  Map<String, dynamic> toJson() => _$HostUserToJson(this);
}

@CopyWith()
@JsonSerializable()
class Dto {
  final String? account;
  final String? bank;
  final String? businessClassification;
  final String? calculateClassification;
  final String? email;
  final String? name;
  final String? phone;
  final String? subPhone;
  final int? id;

  const Dto({
    this.account,
    this.bank,
    this.businessClassification,
    this.calculateClassification,
    this.email,
    this.name,
    this.phone,
    this.subPhone,
    this.id
  });

  factory Dto.fromJson(Map<String, dynamic> json) => _$DtoFromJson(json);

  Map<String, dynamic> toJson() => _$DtoToJson(this);
}
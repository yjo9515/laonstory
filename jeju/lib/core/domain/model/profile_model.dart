import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:jeju_host_app/core/domain/model/room_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/profile_model.g.dart';

@CopyWith()
@JsonSerializable()
class Profile {
  final int? id;
  final DateTime? createdAt;
  final String? updatedAt;
  final String? name;
  final String? nickname;
  final String? email;
  final String? profileImage;
  final String? phone;
  final String? telecom;
  final String? status;
  final String? subPhone;
  final String? account;
  final String? bank;
  final int? mileage;
  final int? reviewCount;
  final int? accommodationLikeCount;
  final int? reservationCount;
  final Resource? profile;
  final bool? emailConfirm;
  final bool? phoneConfirm;


  const Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nickname,
    this.name,
    this.email,
    this.profileImage,
    this.phone,
    this.telecom,
    this.status,
    this.subPhone,
    this.account,
    this.bank,
    this.mileage,
    this.reviewCount,
    this.accommodationLikeCount,
    this.reservationCount,
    this.profile,
    this.emailConfirm,
    this.phoneConfirm
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

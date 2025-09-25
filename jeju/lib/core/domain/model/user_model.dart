import 'package:json_annotation/json_annotation.dart';

part 'generated/user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "nickname")
  final String? nickname;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "telecom")
  final String? telecom;
  @JsonKey(name: "national")
  final String? national;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "mileage")
  final int? mileage;
  @JsonKey(name: "reviewCount")
  final int? reviewCount;
  @JsonKey(name: "accommodationLikeCount")
  final int? accommodationLikeCount;
  @JsonKey(name: "reservationCount")
  final int? reservationCount;
  @JsonKey(name: "status")
  final String? status;

  User({
    this.id,
    this.email,
    this.nickname,
    this.name,
    this.gender,
    this.telecom,
    this.national,
    this.phone,
    this.mileage,
    this.reviewCount,
    this.accommodationLikeCount,
    this.reservationCount,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}


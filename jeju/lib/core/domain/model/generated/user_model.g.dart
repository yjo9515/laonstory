// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      telecom: json['telecom'] as String?,
      national: json['national'] as String?,
      phone: json['phone'] as String?,
      mileage: json['mileage'] as int?,
      reviewCount: json['reviewCount'] as int?,
      accommodationLikeCount: json['accommodationLikeCount'] as int?,
      reservationCount: json['reservationCount'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'name': instance.name,
      'gender': instance.gender,
      'telecom': instance.telecom,
      'national': instance.national,
      'phone': instance.phone,
      'mileage': instance.mileage,
      'reviewCount': instance.reviewCount,
      'accommodationLikeCount': instance.accommodationLikeCount,
      'reservationCount': instance.reservationCount,
      'status': instance.status,
    };

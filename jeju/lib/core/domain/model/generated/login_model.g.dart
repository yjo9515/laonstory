// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      authToken: json['authToken'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'profile': instance.profile,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as String?,
      isGuest: json['isGuest'] as bool?,
      guestSerial: json['guestSerial'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'isGuest': instance.isGuest,
      'guestSerial': instance.guestSerial,
    };

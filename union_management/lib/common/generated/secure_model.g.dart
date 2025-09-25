// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/secure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecureModel _$SecureModelFromJson(Map<String, dynamic> json) => SecureModel(
      loginStatus: $enumDecodeNullable(_$GuestStatusEnumMap, json['loginStatus']) ?? LoginStatus.logout,
      tokenData: TokenData.fromJson(json['tokenData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SecureModelToJson(SecureModel instance) => <String, dynamic>{
      'loginStatus': _$GuestStatusEnumMap[instance.loginStatus]!,
      'tokenData': instance.tokenData,
    };

const _$GuestStatusEnumMap = {
  LoginStatus.login: 'login',
  LoginStatus.logout: 'logout',
};

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      accessToken: json['accessToken'] as String? ?? "",
      fcmToken: json['fcmToken'] as String? ?? "",
      refreshToken: json['refreshToken'] as String? ?? "",
      deviceId: json['deviceId'] as String? ?? "",
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'fcmToken': instance.fcmToken,
      'deviceId': instance.deviceId,
      'refreshToken': instance.refreshToken,
    };

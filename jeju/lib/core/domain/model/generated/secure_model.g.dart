// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../secure_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SecureModelCWProxy {
  SecureModel loginStatus(LoginStatus loginStatus);

  SecureModel tokenData(TokenData tokenData);

  SecureModel hostStatus(UserType hostStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecureModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecureModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SecureModel call({
    LoginStatus? loginStatus,
    TokenData? tokenData,
    UserType? hostStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSecureModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSecureModel.copyWith.fieldName(...)`
class _$SecureModelCWProxyImpl implements _$SecureModelCWProxy {
  const _$SecureModelCWProxyImpl(this._value);

  final SecureModel _value;

  @override
  SecureModel loginStatus(LoginStatus loginStatus) =>
      this(loginStatus: loginStatus);

  @override
  SecureModel tokenData(TokenData tokenData) => this(tokenData: tokenData);

  @override
  SecureModel hostStatus(UserType hostStatus) => this(hostStatus: hostStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SecureModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SecureModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SecureModel call({
    Object? loginStatus = const $CopyWithPlaceholder(),
    Object? tokenData = const $CopyWithPlaceholder(),
    Object? hostStatus = const $CopyWithPlaceholder(),
  }) {
    return SecureModel(
      loginStatus:
          loginStatus == const $CopyWithPlaceholder() || loginStatus == null
              ? _value.loginStatus
              // ignore: cast_nullable_to_non_nullable
              : loginStatus as LoginStatus,
      tokenData: tokenData == const $CopyWithPlaceholder() || tokenData == null
          ? _value.tokenData
          // ignore: cast_nullable_to_non_nullable
          : tokenData as TokenData,
      hostStatus:
          hostStatus == const $CopyWithPlaceholder() || hostStatus == null
              ? _value.hostStatus
              // ignore: cast_nullable_to_non_nullable
              : hostStatus as UserType,
    );
  }
}

extension $SecureModelCopyWith on SecureModel {
  /// Returns a callable class that can be used as follows: `instanceOfSecureModel.copyWith(...)` or like so:`instanceOfSecureModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SecureModelCWProxy get copyWith => _$SecureModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecureModel _$SecureModelFromJson(Map<String, dynamic> json) => SecureModel(
      loginStatus:
          $enumDecodeNullable(_$LoginStatusEnumMap, json['loginStatus']) ??
              LoginStatus.logout,
      tokenData: TokenData.fromJson(json['tokenData'] as Map<String, dynamic>),
      hostStatus: $enumDecodeNullable(_$UserTypeEnumMap, json['hostStatus']) ??
          UserType.guest,
    );

Map<String, dynamic> _$SecureModelToJson(SecureModel instance) =>
    <String, dynamic>{
      'loginStatus': _$LoginStatusEnumMap[instance.loginStatus]!,
      'tokenData': instance.tokenData,
      'hostStatus': _$UserTypeEnumMap[instance.hostStatus]!,
    };

const _$LoginStatusEnumMap = {
  LoginStatus.login: 'login',
  LoginStatus.logout: 'logout',
};

const _$UserTypeEnumMap = {
  UserType.guest: 'guest',
  UserType.host: 'host',
};

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      authToken: json['authToken'] as String? ?? "",
      fcmToken: json['fcmToken'] as String? ?? "",
      refreshToken: json['refreshToken'] as String? ?? "",
      deviceId: json['deviceId'] as String? ?? "",
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'fcmToken': instance.fcmToken,
      'deviceId': instance.deviceId,
      'refreshToken': instance.refreshToken,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../host_user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostUserCWProxy {
  HostUser businessLicense(String? businessLicense);

  HostUser dto(Dto? dto);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostUser(...).copyWith(id: 12, name: "My name")
  /// ````
  HostUser call({
    String? businessLicense,
    Dto? dto,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostUser.copyWith.fieldName(...)`
class _$HostUserCWProxyImpl implements _$HostUserCWProxy {
  const _$HostUserCWProxyImpl(this._value);

  final HostUser _value;

  @override
  HostUser businessLicense(String? businessLicense) =>
      this(businessLicense: businessLicense);

  @override
  HostUser dto(Dto? dto) => this(dto: dto);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostUser(...).copyWith(id: 12, name: "My name")
  /// ````
  HostUser call({
    Object? businessLicense = const $CopyWithPlaceholder(),
    Object? dto = const $CopyWithPlaceholder(),
  }) {
    return HostUser(
      businessLicense: businessLicense == const $CopyWithPlaceholder()
          ? _value.businessLicense
          // ignore: cast_nullable_to_non_nullable
          : businessLicense as String?,
      dto: dto == const $CopyWithPlaceholder()
          ? _value.dto
          // ignore: cast_nullable_to_non_nullable
          : dto as Dto?,
    );
  }
}

extension $HostUserCopyWith on HostUser {
  /// Returns a callable class that can be used as follows: `instanceOfHostUser.copyWith(...)` or like so:`instanceOfHostUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostUserCWProxy get copyWith => _$HostUserCWProxyImpl(this);
}

abstract class _$DtoCWProxy {
  Dto account(String? account);

  Dto bank(String? bank);

  Dto businessClassification(String? businessClassification);

  Dto calculateClassification(String? calculateClassification);

  Dto email(String? email);

  Dto name(String? name);

  Dto phone(String? phone);

  Dto subPhone(String? subPhone);

  Dto id(int? id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Dto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Dto(...).copyWith(id: 12, name: "My name")
  /// ````
  Dto call({
    String? account,
    String? bank,
    String? businessClassification,
    String? calculateClassification,
    String? email,
    String? name,
    String? phone,
    String? subPhone,
    int? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDto.copyWith.fieldName(...)`
class _$DtoCWProxyImpl implements _$DtoCWProxy {
  const _$DtoCWProxyImpl(this._value);

  final Dto _value;

  @override
  Dto account(String? account) => this(account: account);

  @override
  Dto bank(String? bank) => this(bank: bank);

  @override
  Dto businessClassification(String? businessClassification) =>
      this(businessClassification: businessClassification);

  @override
  Dto calculateClassification(String? calculateClassification) =>
      this(calculateClassification: calculateClassification);

  @override
  Dto email(String? email) => this(email: email);

  @override
  Dto name(String? name) => this(name: name);

  @override
  Dto phone(String? phone) => this(phone: phone);

  @override
  Dto subPhone(String? subPhone) => this(subPhone: subPhone);

  @override
  Dto id(int? id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Dto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Dto(...).copyWith(id: 12, name: "My name")
  /// ````
  Dto call({
    Object? account = const $CopyWithPlaceholder(),
    Object? bank = const $CopyWithPlaceholder(),
    Object? businessClassification = const $CopyWithPlaceholder(),
    Object? calculateClassification = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? subPhone = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return Dto(
      account: account == const $CopyWithPlaceholder()
          ? _value.account
          // ignore: cast_nullable_to_non_nullable
          : account as String?,
      bank: bank == const $CopyWithPlaceholder()
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as String?,
      businessClassification:
          businessClassification == const $CopyWithPlaceholder()
              ? _value.businessClassification
              // ignore: cast_nullable_to_non_nullable
              : businessClassification as String?,
      calculateClassification:
          calculateClassification == const $CopyWithPlaceholder()
              ? _value.calculateClassification
              // ignore: cast_nullable_to_non_nullable
              : calculateClassification as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      subPhone: subPhone == const $CopyWithPlaceholder()
          ? _value.subPhone
          // ignore: cast_nullable_to_non_nullable
          : subPhone as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
    );
  }
}

extension $DtoCopyWith on Dto {
  /// Returns a callable class that can be used as follows: `instanceOfDto.copyWith(...)` or like so:`instanceOfDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DtoCWProxy get copyWith => _$DtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostUser _$HostUserFromJson(Map<String, dynamic> json) => HostUser(
      businessLicense: json['businessLicense'] as String?,
      dto: json['dto'] == null
          ? null
          : Dto.fromJson(json['dto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HostUserToJson(HostUser instance) => <String, dynamic>{
      'businessLicense': instance.businessLicense,
      'dto': instance.dto,
    };

Dto _$DtoFromJson(Map<String, dynamic> json) => Dto(
      account: json['account'] as String?,
      bank: json['bank'] as String?,
      businessClassification: json['businessClassification'] as String?,
      calculateClassification: json['calculateClassification'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      subPhone: json['subPhone'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DtoToJson(Dto instance) => <String, dynamic>{
      'account': instance.account,
      'bank': instance.bank,
      'businessClassification': instance.businessClassification,
      'calculateClassification': instance.calculateClassification,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'subPhone': instance.subPhone,
      'id': instance.id,
    };

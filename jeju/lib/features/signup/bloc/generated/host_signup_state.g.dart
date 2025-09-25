// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../host_signup_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostSignUpStateCWProxy {
  HostSignUpState status(CommonStatus status);

  HostSignUpState errorMessage(String? errorMessage);

  HostSignUpState filterType(FilterType filterType);

  HostSignUpState orderType(OrderType orderType);

  HostSignUpState page(int page);

  HostSignUpState query(String? query);

  HostSignUpState fileName(List<String> fileName);

  HostSignUpState businessLicense(List<File>? businessLicense);

  HostSignUpState hostuser(HostUser hostuser);

  HostSignUpState dto(Dto dto);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostSignUpState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostSignUpState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostSignUpState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    OrderType? orderType,
    int? page,
    String? query,
    List<String>? fileName,
    List<File>? businessLicense,
    HostUser? hostuser,
    Dto? dto,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostSignUpState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostSignUpState.copyWith.fieldName(...)`
class _$HostSignUpStateCWProxyImpl implements _$HostSignUpStateCWProxy {
  const _$HostSignUpStateCWProxyImpl(this._value);

  final HostSignUpState _value;

  @override
  HostSignUpState status(CommonStatus status) => this(status: status);

  @override
  HostSignUpState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HostSignUpState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  HostSignUpState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  HostSignUpState page(int page) => this(page: page);

  @override
  HostSignUpState query(String? query) => this(query: query);

  @override
  HostSignUpState fileName(List<String> fileName) => this(fileName: fileName);

  @override
  HostSignUpState businessLicense(List<File>? businessLicense) =>
      this(businessLicense: businessLicense);

  @override
  HostSignUpState hostuser(HostUser hostuser) => this(hostuser: hostuser);

  @override
  HostSignUpState dto(Dto dto) => this(dto: dto);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostSignUpState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostSignUpState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostSignUpState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? businessLicense = const $CopyWithPlaceholder(),
    Object? hostuser = const $CopyWithPlaceholder(),
    Object? dto = const $CopyWithPlaceholder(),
  }) {
    return HostSignUpState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      fileName: fileName == const $CopyWithPlaceholder() || fileName == null
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as List<String>,
      businessLicense: businessLicense == const $CopyWithPlaceholder()
          ? _value.businessLicense
          // ignore: cast_nullable_to_non_nullable
          : businessLicense as List<File>?,
      hostuser: hostuser == const $CopyWithPlaceholder() || hostuser == null
          ? _value.hostuser
          // ignore: cast_nullable_to_non_nullable
          : hostuser as HostUser,
      dto: dto == const $CopyWithPlaceholder() || dto == null
          ? _value.dto
          // ignore: cast_nullable_to_non_nullable
          : dto as Dto,
    );
  }
}

extension $HostSignUpStateCopyWith on HostSignUpState {
  /// Returns a callable class that can be used as follows: `instanceOfHostSignUpState.copyWith(...)` or like so:`instanceOfHostSignUpState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostSignUpStateCWProxy get copyWith => _$HostSignUpStateCWProxyImpl(this);
}

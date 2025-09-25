// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../host_info_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostInfoStateCWProxy {
  HostInfoState status(CommonStatus status);

  HostInfoState errorMessage(String? errorMessage);

  HostInfoState filterType(FilterType filterType);

  HostInfoState hasReachedMax(bool hasReachedMax);

  HostInfoState orderType(OrderType orderType);

  HostInfoState page(int page);

  HostInfoState query(String? query);

  HostInfoState fileName(List<String> fileName);

  HostInfoState businessLicense(List<File>? businessLicense);

  HostInfoState hostuser(HostUser hostuser);

  HostInfoState dto(Dto dto);

  HostInfoState licenseData(Map<dynamic, dynamic> licenseData);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostInfoState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostInfoState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostInfoState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<String>? fileName,
    List<File>? businessLicense,
    HostUser? hostuser,
    Dto? dto,
    Map<dynamic, dynamic>? licenseData,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostInfoState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostInfoState.copyWith.fieldName(...)`
class _$HostInfoStateCWProxyImpl implements _$HostInfoStateCWProxy {
  const _$HostInfoStateCWProxyImpl(this._value);

  final HostInfoState _value;

  @override
  HostInfoState status(CommonStatus status) => this(status: status);

  @override
  HostInfoState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HostInfoState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  HostInfoState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  HostInfoState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  HostInfoState page(int page) => this(page: page);

  @override
  HostInfoState query(String? query) => this(query: query);

  @override
  HostInfoState fileName(List<String> fileName) => this(fileName: fileName);

  @override
  HostInfoState businessLicense(List<File>? businessLicense) =>
      this(businessLicense: businessLicense);

  @override
  HostInfoState hostuser(HostUser hostuser) => this(hostuser: hostuser);

  @override
  HostInfoState dto(Dto dto) => this(dto: dto);

  @override
  HostInfoState licenseData(Map<dynamic, dynamic> licenseData) =>
      this(licenseData: licenseData);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostInfoState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostInfoState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostInfoState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? businessLicense = const $CopyWithPlaceholder(),
    Object? hostuser = const $CopyWithPlaceholder(),
    Object? dto = const $CopyWithPlaceholder(),
    Object? licenseData = const $CopyWithPlaceholder(),
  }) {
    return HostInfoState(
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
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
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
      licenseData:
          licenseData == const $CopyWithPlaceholder() || licenseData == null
              ? _value.licenseData
              // ignore: cast_nullable_to_non_nullable
              : licenseData as Map<dynamic, dynamic>,
    );
  }
}

extension $HostInfoStateCopyWith on HostInfoState {
  /// Returns a callable class that can be used as follows: `instanceOfHostInfoState.copyWith(...)` or like so:`instanceOfHostInfoState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostInfoStateCWProxy get copyWith => _$HostInfoStateCWProxyImpl(this);
}

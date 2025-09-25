// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../alert_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AlertStateCWProxy {
  AlertState status(CommonStatus status);

  AlertState errorMessage(String? errorMessage);

  AlertState filterType(FilterType filterType);

  AlertState hasReachedMax(bool hasReachedMax);

  AlertState orderType(OrderType orderType);

  AlertState page(int page);

  AlertState query(String? query);

  AlertState isAll(bool isAll);

  AlertState isOneToOneInquiry(bool isOneToOneInquiry);

  AlertState isReservation(bool isReservation);

  AlertState isMessage(bool isMessage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlertState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlertState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlertState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    bool? isAll,
    bool? isOneToOneInquiry,
    bool? isReservation,
    bool? isMessage,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAlertState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAlertState.copyWith.fieldName(...)`
class _$AlertStateCWProxyImpl implements _$AlertStateCWProxy {
  const _$AlertStateCWProxyImpl(this._value);

  final AlertState _value;

  @override
  AlertState status(CommonStatus status) => this(status: status);

  @override
  AlertState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  AlertState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  AlertState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  AlertState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  AlertState page(int page) => this(page: page);

  @override
  AlertState query(String? query) => this(query: query);

  @override
  AlertState isAll(bool isAll) => this(isAll: isAll);

  @override
  AlertState isOneToOneInquiry(bool isOneToOneInquiry) =>
      this(isOneToOneInquiry: isOneToOneInquiry);

  @override
  AlertState isReservation(bool isReservation) =>
      this(isReservation: isReservation);

  @override
  AlertState isMessage(bool isMessage) => this(isMessage: isMessage);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlertState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlertState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlertState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? isAll = const $CopyWithPlaceholder(),
    Object? isOneToOneInquiry = const $CopyWithPlaceholder(),
    Object? isReservation = const $CopyWithPlaceholder(),
    Object? isMessage = const $CopyWithPlaceholder(),
  }) {
    return AlertState(
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
      isAll: isAll == const $CopyWithPlaceholder() || isAll == null
          ? _value.isAll
          // ignore: cast_nullable_to_non_nullable
          : isAll as bool,
      isOneToOneInquiry: isOneToOneInquiry == const $CopyWithPlaceholder() ||
              isOneToOneInquiry == null
          ? _value.isOneToOneInquiry
          // ignore: cast_nullable_to_non_nullable
          : isOneToOneInquiry as bool,
      isReservation:
          isReservation == const $CopyWithPlaceholder() || isReservation == null
              ? _value.isReservation
              // ignore: cast_nullable_to_non_nullable
              : isReservation as bool,
      isMessage: isMessage == const $CopyWithPlaceholder() || isMessage == null
          ? _value.isMessage
          // ignore: cast_nullable_to_non_nullable
          : isMessage as bool,
    );
  }
}

extension $AlertStateCopyWith on AlertState {
  /// Returns a callable class that can be used as follows: `instanceOfAlertState.copyWith(...)` or like so:`instanceOfAlertState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AlertStateCWProxy get copyWith => _$AlertStateCWProxyImpl(this);
}

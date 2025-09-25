// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profit_management_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfitManagementStateCWProxy {
  ProfitManagementState status(CommonStatus status);

  ProfitManagementState errorMessage(String? errorMessage);

  ProfitManagementState filterType(FilterType filterType);

  ProfitManagementState hasReachedMax(bool hasReachedMax);

  ProfitManagementState orderType(OrderType orderType);

  ProfitManagementState page(int page);

  ProfitManagementState query(String? query);

  ProfitManagementState profit(Profit profit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfitManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfitManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfitManagementState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Profit? profit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfitManagementState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfitManagementState.copyWith.fieldName(...)`
class _$ProfitManagementStateCWProxyImpl
    implements _$ProfitManagementStateCWProxy {
  const _$ProfitManagementStateCWProxyImpl(this._value);

  final ProfitManagementState _value;

  @override
  ProfitManagementState status(CommonStatus status) => this(status: status);

  @override
  ProfitManagementState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ProfitManagementState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  ProfitManagementState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ProfitManagementState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  ProfitManagementState page(int page) => this(page: page);

  @override
  ProfitManagementState query(String? query) => this(query: query);

  @override
  ProfitManagementState profit(Profit profit) => this(profit: profit);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfitManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfitManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfitManagementState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? profit = const $CopyWithPlaceholder(),
  }) {
    return ProfitManagementState(
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
      profit: profit == const $CopyWithPlaceholder() || profit == null
          ? _value.profit
          // ignore: cast_nullable_to_non_nullable
          : profit as Profit,
    );
  }
}

extension $ProfitManagementStateCopyWith on ProfitManagementState {
  /// Returns a callable class that can be used as follows: `instanceOfProfitManagementState.copyWith(...)` or like so:`instanceOfProfitManagementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfitManagementStateCWProxy get copyWith =>
      _$ProfitManagementStateCWProxyImpl(this);
}

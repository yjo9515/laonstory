// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../splash_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SplashStateCWProxy {
  SplashState status(CommonStatus status);

  SplashState errorMessage(String? errorMessage);

  SplashState filterType(FilterType filterType);

  SplashState hasReachedMax(bool hasReachedMax);

  SplashState orderType(OrderType orderType);

  SplashState page(int page);

  SplashState query(String? query);

  SplashState done(bool done);

  SplashState tokenStatus(TokenStatus tokenStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SplashState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ````
  SplashState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    bool? done,
    TokenStatus? tokenStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSplashState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSplashState.copyWith.fieldName(...)`
class _$SplashStateCWProxyImpl implements _$SplashStateCWProxy {
  const _$SplashStateCWProxyImpl(this._value);

  final SplashState _value;

  @override
  SplashState status(CommonStatus status) => this(status: status);

  @override
  SplashState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  SplashState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  SplashState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  SplashState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  SplashState page(int page) => this(page: page);

  @override
  SplashState query(String? query) => this(query: query);

  @override
  SplashState done(bool done) => this(done: done);

  @override
  SplashState tokenStatus(TokenStatus tokenStatus) =>
      this(tokenStatus: tokenStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SplashState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ````
  SplashState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? done = const $CopyWithPlaceholder(),
    Object? tokenStatus = const $CopyWithPlaceholder(),
  }) {
    return SplashState(
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
      done: done == const $CopyWithPlaceholder() || done == null
          ? _value.done
          // ignore: cast_nullable_to_non_nullable
          : done as bool,
      tokenStatus:
          tokenStatus == const $CopyWithPlaceholder() || tokenStatus == null
              ? _value.tokenStatus
              // ignore: cast_nullable_to_non_nullable
              : tokenStatus as TokenStatus,
    );
  }
}

extension $SplashStateCopyWith on SplashState {
  /// Returns a callable class that can be used as follows: `instanceOfSplashState.copyWith(...)` or like so:`instanceOfSplashState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SplashStateCWProxy get copyWith => _$SplashStateCWProxyImpl(this);
}

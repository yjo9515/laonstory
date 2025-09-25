// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../guide_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GuideStateCWProxy {
  GuideState status(CommonStatus status);

  GuideState errorMessage(String? errorMessage);

  GuideState filterType(FilterType filterType);

  GuideState hasReachedMax(bool hasReachedMax);

  GuideState orderType(OrderType orderType);

  GuideState page(int page);

  GuideState query(String? query);

  GuideState agree(bool agree);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GuideState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GuideState(...).copyWith(id: 12, name: "My name")
  /// ````
  GuideState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    bool? agree,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGuideState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGuideState.copyWith.fieldName(...)`
class _$GuideStateCWProxyImpl implements _$GuideStateCWProxy {
  const _$GuideStateCWProxyImpl(this._value);

  final GuideState _value;

  @override
  GuideState status(CommonStatus status) => this(status: status);

  @override
  GuideState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  GuideState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  GuideState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  GuideState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  GuideState page(int page) => this(page: page);

  @override
  GuideState query(String? query) => this(query: query);

  @override
  GuideState agree(bool agree) => this(agree: agree);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GuideState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GuideState(...).copyWith(id: 12, name: "My name")
  /// ````
  GuideState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? agree = const $CopyWithPlaceholder(),
  }) {
    return GuideState(
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
      agree: agree == const $CopyWithPlaceholder() || agree == null
          ? _value.agree
          // ignore: cast_nullable_to_non_nullable
          : agree as bool,
    );
  }
}

extension $GuideStateCopyWith on GuideState {
  /// Returns a callable class that can be used as follows: `instanceOfGuideState.copyWith(...)` or like so:`instanceOfGuideState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GuideStateCWProxy get copyWith => _$GuideStateCWProxyImpl(this);
}

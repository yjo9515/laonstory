// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommonStateCWProxy {
  CommonState status(CommonStatus status);

  CommonState message(String message);

  CommonState page(int page);

  CommonState query(String? query);

  CommonState meta(Meta? meta);

  CommonState filterType(FilterType filterType);

  CommonState orderType(OrderType orderType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommonState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommonState(...).copyWith(id: 12, name: "My name")
  /// ````
  CommonState call({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommonState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommonState.copyWith.fieldName(...)`
class _$CommonStateCWProxyImpl implements _$CommonStateCWProxy {
  const _$CommonStateCWProxyImpl(this._value);

  final CommonState _value;

  @override
  CommonState status(CommonStatus status) => this(status: status);

  @override
  CommonState message(String message) => this(message: message);

  @override
  CommonState page(int page) => this(page: page);

  @override
  CommonState query(String? query) => this(query: query);

  @override
  CommonState meta(Meta? meta) => this(meta: meta);

  @override
  CommonState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  CommonState orderType(OrderType orderType) => this(orderType: orderType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommonState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommonState(...).copyWith(id: 12, name: "My name")
  /// ````
  CommonState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
  }) {
    return CommonState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Meta?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
    );
  }
}

extension $CommonStateCopyWith on CommonState {
  /// Returns a callable class that can be used as follows: `instanceOfCommonState.copyWith(...)` or like so:`instanceOfCommonState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommonStateCWProxy get copyWith => _$CommonStateCWProxyImpl(this);
}

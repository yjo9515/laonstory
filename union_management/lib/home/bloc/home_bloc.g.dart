// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState status(CommonStatus status);

  HomeState message(String message);

  HomeState page(int page);

  HomeState query(String? query);

  HomeState meta(Meta? meta);

  HomeState filterType(FilterType filterType);

  HomeState orderType(OrderType orderType);

  HomeState events(List<Event> events);

  HomeState notices(List<Notice> notices);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
    List<Event>? events,
    List<Notice>? notices,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState status(CommonStatus status) => this(status: status);

  @override
  HomeState message(String message) => this(message: message);

  @override
  HomeState page(int page) => this(page: page);

  @override
  HomeState query(String? query) => this(query: query);

  @override
  HomeState meta(Meta? meta) => this(meta: meta);

  @override
  HomeState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  HomeState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  HomeState events(List<Event> events) => this(events: events);

  @override
  HomeState notices(List<Notice> notices) => this(notices: notices);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
    Object? notices = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
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
      events: events == const $CopyWithPlaceholder() || events == null
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as List<Event>,
      notices: notices == const $CopyWithPlaceholder() || notices == null
          ? _value.notices
          // ignore: cast_nullable_to_non_nullable
          : notices as List<Notice>,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}

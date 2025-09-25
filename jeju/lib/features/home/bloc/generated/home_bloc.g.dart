// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../home_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState status(CommonStatus status);

  HomeState errorMessage(String? errorMessage);

  HomeState filterType(FilterType filterType);

  HomeState hasReachedMax(bool hasReachedMax);

  HomeState orderType(OrderType orderType);

  HomeState page(int page);

  HomeState query(String? query);

  HomeState route(String? route);

  HomeState pageInfo(PageInfo? pageInfo);

  HomeState facilities(Map<String?, List<Facility>?> facilities);

  HomeState themes(Map<String?, List<Facility>?> themes);

  HomeState rooms(List<Room> rooms);

  HomeState pickRooms(List<Room> pickRooms);

  HomeState newRooms(List<Room> newRooms);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    String? route,
    PageInfo? pageInfo,
    Map<String?, List<Facility>?>? facilities,
    Map<String?, List<Facility>?>? themes,
    List<Room>? rooms,
    List<Room>? pickRooms,
    List<Room>? newRooms,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState status(CommonStatus status) => this(status: status);

  @override
  HomeState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HomeState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  HomeState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  HomeState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  HomeState page(int page) => this(page: page);

  @override
  HomeState query(String? query) => this(query: query);

  @override
  HomeState route(String? route) => this(route: route);

  @override
  HomeState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  HomeState facilities(Map<String?, List<Facility>?> facilities) =>
      this(facilities: facilities);

  @override
  HomeState themes(Map<String?, List<Facility>?> themes) =>
      this(themes: themes);

  @override
  HomeState rooms(List<Room> rooms) => this(rooms: rooms);

  @override
  HomeState pickRooms(List<Room> pickRooms) => this(pickRooms: pickRooms);

  @override
  HomeState newRooms(List<Room> newRooms) => this(newRooms: newRooms);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? route = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? facilities = const $CopyWithPlaceholder(),
    Object? themes = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
    Object? pickRooms = const $CopyWithPlaceholder(),
    Object? newRooms = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
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
      route: route == const $CopyWithPlaceholder()
          ? _value.route
          // ignore: cast_nullable_to_non_nullable
          : route as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      facilities:
          facilities == const $CopyWithPlaceholder() || facilities == null
              ? _value.facilities
              // ignore: cast_nullable_to_non_nullable
              : facilities as Map<String?, List<Facility>?>,
      themes: themes == const $CopyWithPlaceholder() || themes == null
          ? _value.themes
          // ignore: cast_nullable_to_non_nullable
          : themes as Map<String?, List<Facility>?>,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
      pickRooms: pickRooms == const $CopyWithPlaceholder() || pickRooms == null
          ? _value.pickRooms
          // ignore: cast_nullable_to_non_nullable
          : pickRooms as List<Room>,
      newRooms: newRooms == const $CopyWithPlaceholder() || newRooms == null
          ? _value.newRooms
          // ignore: cast_nullable_to_non_nullable
          : newRooms as List<Room>,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}

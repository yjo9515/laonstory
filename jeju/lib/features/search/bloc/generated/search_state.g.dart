// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchStateCWProxy {
  SearchState status(CommonStatus status);

  SearchState errorMessage(String? errorMessage);

  SearchState filterType(FilterType filterType);

  SearchState hasReachedMax(bool hasReachedMax);

  SearchState orderType(OrderType orderType);

  SearchState page(int page);

  SearchState query(String? query);

  SearchState route(String? route);

  SearchState priceRange(RangeValues priceRange);

  SearchState themes(Map<String?, List<Facility>?> themes);

  SearchState select(List<Facility> select);

  SearchState room(Room room);

  SearchState range(String? range);

  SearchState address(String? address);

  SearchState floor(String? floor);

  SearchState people(int people);

  SearchState checkIn(DateTime? checkIn);

  SearchState checkOut(DateTime? checkOut);

  SearchState selectTheme(Facility? selectTheme);

  SearchState searchList(List<Room> searchList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    String? route,
    RangeValues? priceRange,
    Map<String?, List<Facility>?>? themes,
    List<Facility>? select,
    Room? room,
    String? range,
    String? address,
    String? floor,
    int? people,
    DateTime? checkIn,
    DateTime? checkOut,
    Facility? selectTheme,
    List<Room>? searchList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchState.copyWith.fieldName(...)`
class _$SearchStateCWProxyImpl implements _$SearchStateCWProxy {
  const _$SearchStateCWProxyImpl(this._value);

  final SearchState _value;

  @override
  SearchState status(CommonStatus status) => this(status: status);

  @override
  SearchState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  SearchState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  SearchState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  SearchState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  SearchState page(int page) => this(page: page);

  @override
  SearchState query(String? query) => this(query: query);

  @override
  SearchState route(String? route) => this(route: route);

  @override
  SearchState priceRange(RangeValues priceRange) =>
      this(priceRange: priceRange);

  @override
  SearchState themes(Map<String?, List<Facility>?> themes) =>
      this(themes: themes);

  @override
  SearchState select(List<Facility> select) => this(select: select);

  @override
  SearchState room(Room room) => this(room: room);

  @override
  SearchState range(String? range) => this(range: range);

  @override
  SearchState address(String? address) => this(address: address);

  @override
  SearchState floor(String? floor) => this(floor: floor);

  @override
  SearchState people(int people) => this(people: people);

  @override
  SearchState checkIn(DateTime? checkIn) => this(checkIn: checkIn);

  @override
  SearchState checkOut(DateTime? checkOut) => this(checkOut: checkOut);

  @override
  SearchState selectTheme(Facility? selectTheme) =>
      this(selectTheme: selectTheme);

  @override
  SearchState searchList(List<Room> searchList) => this(searchList: searchList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? route = const $CopyWithPlaceholder(),
    Object? priceRange = const $CopyWithPlaceholder(),
    Object? themes = const $CopyWithPlaceholder(),
    Object? select = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? range = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? people = const $CopyWithPlaceholder(),
    Object? checkIn = const $CopyWithPlaceholder(),
    Object? checkOut = const $CopyWithPlaceholder(),
    Object? selectTheme = const $CopyWithPlaceholder(),
    Object? searchList = const $CopyWithPlaceholder(),
  }) {
    return SearchState(
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
      priceRange:
          priceRange == const $CopyWithPlaceholder() || priceRange == null
              ? _value.priceRange
              // ignore: cast_nullable_to_non_nullable
              : priceRange as RangeValues,
      themes: themes == const $CopyWithPlaceholder() || themes == null
          ? _value.themes
          // ignore: cast_nullable_to_non_nullable
          : themes as Map<String?, List<Facility>?>,
      select: select == const $CopyWithPlaceholder() || select == null
          ? _value.select
          // ignore: cast_nullable_to_non_nullable
          : select as List<Facility>,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      range: range == const $CopyWithPlaceholder()
          ? _value.range
          // ignore: cast_nullable_to_non_nullable
          : range as String?,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      floor: floor == const $CopyWithPlaceholder()
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as String?,
      people: people == const $CopyWithPlaceholder() || people == null
          ? _value.people
          // ignore: cast_nullable_to_non_nullable
          : people as int,
      checkIn: checkIn == const $CopyWithPlaceholder()
          ? _value.checkIn
          // ignore: cast_nullable_to_non_nullable
          : checkIn as DateTime?,
      checkOut: checkOut == const $CopyWithPlaceholder()
          ? _value.checkOut
          // ignore: cast_nullable_to_non_nullable
          : checkOut as DateTime?,
      selectTheme: selectTheme == const $CopyWithPlaceholder()
          ? _value.selectTheme
          // ignore: cast_nullable_to_non_nullable
          : selectTheme as Facility?,
      searchList:
          searchList == const $CopyWithPlaceholder() || searchList == null
              ? _value.searchList
              // ignore: cast_nullable_to_non_nullable
              : searchList as List<Room>,
    );
  }
}

extension $SearchStateCopyWith on SearchState {
  /// Returns a callable class that can be used as follows: `instanceOfSearchState.copyWith(...)` or like so:`instanceOfSearchState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SearchStateCWProxy get copyWith => _$SearchStateCWProxyImpl(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../wish_room_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WishRoomStateCWProxy {
  WishRoomState status(CommonStatus status);

  WishRoomState errorMessage(String? errorMessage);

  WishRoomState filterType(FilterType filterType);

  WishRoomState hasReachedMax(bool hasReachedMax);

  WishRoomState orderType(OrderType orderType);

  WishRoomState page(int page);

  WishRoomState query(String? query);

  WishRoomState roomList(List<Room> roomList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WishRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WishRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  WishRoomState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<Room>? roomList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWishRoomState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWishRoomState.copyWith.fieldName(...)`
class _$WishRoomStateCWProxyImpl implements _$WishRoomStateCWProxy {
  const _$WishRoomStateCWProxyImpl(this._value);

  final WishRoomState _value;

  @override
  WishRoomState status(CommonStatus status) => this(status: status);

  @override
  WishRoomState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  WishRoomState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  WishRoomState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  WishRoomState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  WishRoomState page(int page) => this(page: page);

  @override
  WishRoomState query(String? query) => this(query: query);

  @override
  WishRoomState roomList(List<Room> roomList) => this(roomList: roomList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WishRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WishRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  WishRoomState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? roomList = const $CopyWithPlaceholder(),
  }) {
    return WishRoomState(
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
      roomList: roomList == const $CopyWithPlaceholder() || roomList == null
          ? _value.roomList
          // ignore: cast_nullable_to_non_nullable
          : roomList as List<Room>,
    );
  }
}

extension $WishRoomStateCopyWith on WishRoomState {
  /// Returns a callable class that can be used as follows: `instanceOfWishRoomState.copyWith(...)` or like so:`instanceOfWishRoomState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WishRoomStateCWProxy get copyWith => _$WishRoomStateCWProxyImpl(this);
}

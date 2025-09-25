// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mypage_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MypageStateCWProxy {
  MypageState status(CommonStatus status);

  MypageState errorMessage(String? errorMessage);

  MypageState filterType(FilterType filterType);

  MypageState hasReachedMax(bool hasReachedMax);

  MypageState orderType(OrderType orderType);

  MypageState page(int page);

  MypageState query(String? query);

  MypageState pageInfo(PageInfo? pageInfo);

  MypageState rooms(List<Room> rooms);

  MypageState images(List<XFile>? images);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MypageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MypageState(...).copyWith(id: 12, name: "My name")
  /// ````
  MypageState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    List<Room>? rooms,
    List<XFile>? images,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMypageState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMypageState.copyWith.fieldName(...)`
class _$MypageStateCWProxyImpl implements _$MypageStateCWProxy {
  const _$MypageStateCWProxyImpl(this._value);

  final MypageState _value;

  @override
  MypageState status(CommonStatus status) => this(status: status);

  @override
  MypageState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  MypageState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  MypageState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  MypageState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  MypageState page(int page) => this(page: page);

  @override
  MypageState query(String? query) => this(query: query);

  @override
  MypageState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  MypageState rooms(List<Room> rooms) => this(rooms: rooms);

  @override
  MypageState images(List<XFile>? images) => this(images: images);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MypageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MypageState(...).copyWith(id: 12, name: "My name")
  /// ````
  MypageState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
    Object? images = const $CopyWithPlaceholder(),
  }) {
    return MypageState(
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
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
      images: images == const $CopyWithPlaceholder()
          ? _value.images
          // ignore: cast_nullable_to_non_nullable
          : images as List<XFile>?,
    );
  }
}

extension $MypageStateCopyWith on MypageState {
  /// Returns a callable class that can be used as follows: `instanceOfMypageState.copyWith(...)` or like so:`instanceOfMypageState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MypageStateCWProxy get copyWith => _$MypageStateCWProxyImpl(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notice_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoticeStateCWProxy {
  NoticeState status(CommonStatus status);

  NoticeState errorMessage(String? errorMessage);

  NoticeState filterType(FilterType filterType);

  NoticeState hasReachedMax(bool hasReachedMax);

  NoticeState orderType(OrderType orderType);

  NoticeState page(int page);

  NoticeState query(String? query);

  NoticeState noticeList(List<Board> noticeList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoticeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoticeState(...).copyWith(id: 12, name: "My name")
  /// ````
  NoticeState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<Board>? noticeList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNoticeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNoticeState.copyWith.fieldName(...)`
class _$NoticeStateCWProxyImpl implements _$NoticeStateCWProxy {
  const _$NoticeStateCWProxyImpl(this._value);

  final NoticeState _value;

  @override
  NoticeState status(CommonStatus status) => this(status: status);

  @override
  NoticeState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  NoticeState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  NoticeState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  NoticeState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  NoticeState page(int page) => this(page: page);

  @override
  NoticeState query(String? query) => this(query: query);

  @override
  NoticeState noticeList(List<Board> noticeList) =>
      this(noticeList: noticeList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoticeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoticeState(...).copyWith(id: 12, name: "My name")
  /// ````
  NoticeState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? noticeList = const $CopyWithPlaceholder(),
  }) {
    return NoticeState(
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
      noticeList:
          noticeList == const $CopyWithPlaceholder() || noticeList == null
              ? _value.noticeList
              // ignore: cast_nullable_to_non_nullable
              : noticeList as List<Board>,
    );
  }
}

extension $NoticeStateCopyWith on NoticeState {
  /// Returns a callable class that can be used as follows: `instanceOfNoticeState.copyWith(...)` or like so:`instanceOfNoticeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoticeStateCWProxy get copyWith => _$NoticeStateCWProxyImpl(this);
}

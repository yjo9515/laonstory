// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../message_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MessageListStateCWProxy {
  MessageListState status(CommonStatus status);

  MessageListState errorMessage(String? errorMessage);

  MessageListState filterType(FilterType filterType);

  MessageListState hasReachedMax(bool hasReachedMax);

  MessageListState orderType(OrderType orderType);

  MessageListState page(int page);

  MessageListState query(String? query);

  MessageListState messageList(List<Message> messageList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageListState(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageListState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<Message>? messageList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMessageListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMessageListState.copyWith.fieldName(...)`
class _$MessageListStateCWProxyImpl implements _$MessageListStateCWProxy {
  const _$MessageListStateCWProxyImpl(this._value);

  final MessageListState _value;

  @override
  MessageListState status(CommonStatus status) => this(status: status);

  @override
  MessageListState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  MessageListState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  MessageListState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  MessageListState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  MessageListState page(int page) => this(page: page);

  @override
  MessageListState query(String? query) => this(query: query);

  @override
  MessageListState messageList(List<Message> messageList) =>
      this(messageList: messageList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageListState(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageListState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? messageList = const $CopyWithPlaceholder(),
  }) {
    return MessageListState(
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
      messageList:
          messageList == const $CopyWithPlaceholder() || messageList == null
              ? _value.messageList
              // ignore: cast_nullable_to_non_nullable
              : messageList as List<Message>,
    );
  }
}

extension $MessageListStateCopyWith on MessageListState {
  /// Returns a callable class that can be used as follows: `instanceOfMessageListState.copyWith(...)` or like so:`instanceOfMessageListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MessageListStateCWProxy get copyWith => _$MessageListStateCWProxyImpl(this);
}

abstract class _$MessageDetailStateCWProxy {
  MessageDetailState status(CommonStatus status);

  MessageDetailState errorMessage(String? errorMessage);

  MessageDetailState filterType(FilterType filterType);

  MessageDetailState hasReachedMax(bool hasReachedMax);

  MessageDetailState orderType(OrderType orderType);

  MessageDetailState page(int page);

  MessageDetailState query(String? query);

  MessageDetailState profile(Profile? profile);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageDetailState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Profile? profile,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMessageDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMessageDetailState.copyWith.fieldName(...)`
class _$MessageDetailStateCWProxyImpl implements _$MessageDetailStateCWProxy {
  const _$MessageDetailStateCWProxyImpl(this._value);

  final MessageDetailState _value;

  @override
  MessageDetailState status(CommonStatus status) => this(status: status);

  @override
  MessageDetailState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  MessageDetailState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  MessageDetailState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  MessageDetailState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  MessageDetailState page(int page) => this(page: page);

  @override
  MessageDetailState query(String? query) => this(query: query);

  @override
  MessageDetailState profile(Profile? profile) => this(profile: profile);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageDetailState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? profile = const $CopyWithPlaceholder(),
  }) {
    return MessageDetailState(
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
      profile: profile == const $CopyWithPlaceholder()
          ? _value.profile
          // ignore: cast_nullable_to_non_nullable
          : profile as Profile?,
    );
  }
}

extension $MessageDetailStateCopyWith on MessageDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfMessageDetailState.copyWith(...)` or like so:`instanceOfMessageDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MessageDetailStateCWProxy get copyWith =>
      _$MessageDetailStateCWProxyImpl(this);
}

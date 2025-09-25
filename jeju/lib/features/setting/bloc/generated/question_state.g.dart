// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../question_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuestionStateCWProxy {
  QuestionState status(CommonStatus status);

  QuestionState errorMessage(String? errorMessage);

  QuestionState filterType(FilterType filterType);

  QuestionState hasReachedMax(bool hasReachedMax);

  QuestionState orderType(OrderType orderType);

  QuestionState page(int page);

  QuestionState query(String? query);

  QuestionState questionList(List<Board> questionList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuestionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuestionState(...).copyWith(id: 12, name: "My name")
  /// ````
  QuestionState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<Board>? questionList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfQuestionState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfQuestionState.copyWith.fieldName(...)`
class _$QuestionStateCWProxyImpl implements _$QuestionStateCWProxy {
  const _$QuestionStateCWProxyImpl(this._value);

  final QuestionState _value;

  @override
  QuestionState status(CommonStatus status) => this(status: status);

  @override
  QuestionState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  QuestionState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  QuestionState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  QuestionState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  QuestionState page(int page) => this(page: page);

  @override
  QuestionState query(String? query) => this(query: query);

  @override
  QuestionState questionList(List<Board> questionList) =>
      this(questionList: questionList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuestionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuestionState(...).copyWith(id: 12, name: "My name")
  /// ````
  QuestionState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? questionList = const $CopyWithPlaceholder(),
  }) {
    return QuestionState(
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
      questionList:
          questionList == const $CopyWithPlaceholder() || questionList == null
              ? _value.questionList
              // ignore: cast_nullable_to_non_nullable
              : questionList as List<Board>,
    );
  }
}

extension $QuestionStateCopyWith on QuestionState {
  /// Returns a callable class that can be used as follows: `instanceOfQuestionState.copyWith(...)` or like so:`instanceOfQuestionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuestionStateCWProxy get copyWith => _$QuestionStateCWProxyImpl(this);
}

abstract class _$QuestionWriteStateCWProxy {
  QuestionWriteState status(CommonStatus status);

  QuestionWriteState errorMessage(String? errorMessage);

  QuestionWriteState filterType(FilterType filterType);

  QuestionWriteState hasReachedMax(bool hasReachedMax);

  QuestionWriteState orderType(OrderType orderType);

  QuestionWriteState page(int page);

  QuestionWriteState query(String? query);

  QuestionWriteState title(String? title);

  QuestionWriteState comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuestionWriteState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuestionWriteState(...).copyWith(id: 12, name: "My name")
  /// ````
  QuestionWriteState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    String? title,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfQuestionWriteState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfQuestionWriteState.copyWith.fieldName(...)`
class _$QuestionWriteStateCWProxyImpl implements _$QuestionWriteStateCWProxy {
  const _$QuestionWriteStateCWProxyImpl(this._value);

  final QuestionWriteState _value;

  @override
  QuestionWriteState status(CommonStatus status) => this(status: status);

  @override
  QuestionWriteState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  QuestionWriteState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  QuestionWriteState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  QuestionWriteState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  QuestionWriteState page(int page) => this(page: page);

  @override
  QuestionWriteState query(String? query) => this(query: query);

  @override
  QuestionWriteState title(String? title) => this(title: title);

  @override
  QuestionWriteState comment(String? comment) => this(comment: comment);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuestionWriteState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuestionWriteState(...).copyWith(id: 12, name: "My name")
  /// ````
  QuestionWriteState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return QuestionWriteState(
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
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $QuestionWriteStateCopyWith on QuestionWriteState {
  /// Returns a callable class that can be used as follows: `instanceOfQuestionWriteState.copyWith(...)` or like so:`instanceOfQuestionWriteState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuestionWriteStateCWProxy get copyWith =>
      _$QuestionWriteStateCWProxyImpl(this);
}

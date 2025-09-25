// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../review_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewStateCWProxy {
  ReviewState status(CommonStatus status);

  ReviewState errorMessage(String? errorMessage);

  ReviewState filterType(FilterType filterType);

  ReviewState hasReachedMax(bool hasReachedMax);

  ReviewState orderType(OrderType orderType);

  ReviewState page(int page);

  ReviewState query(String? query);

  ReviewState cleanScore(int cleanScore);

  ReviewState explainScore(int explainScore);

  ReviewState kindnessScore(int kindnessScore);

  ReviewState content(String? content);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    int? cleanScore,
    int? explainScore,
    int? kindnessScore,
    String? content,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewState.copyWith.fieldName(...)`
class _$ReviewStateCWProxyImpl implements _$ReviewStateCWProxy {
  const _$ReviewStateCWProxyImpl(this._value);

  final ReviewState _value;

  @override
  ReviewState status(CommonStatus status) => this(status: status);

  @override
  ReviewState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ReviewState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  ReviewState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ReviewState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  ReviewState page(int page) => this(page: page);

  @override
  ReviewState query(String? query) => this(query: query);

  @override
  ReviewState cleanScore(int cleanScore) => this(cleanScore: cleanScore);

  @override
  ReviewState explainScore(int explainScore) =>
      this(explainScore: explainScore);

  @override
  ReviewState kindnessScore(int kindnessScore) =>
      this(kindnessScore: kindnessScore);

  @override
  ReviewState content(String? content) => this(content: content);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? cleanScore = const $CopyWithPlaceholder(),
    Object? explainScore = const $CopyWithPlaceholder(),
    Object? kindnessScore = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
  }) {
    return ReviewState(
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
      cleanScore:
          cleanScore == const $CopyWithPlaceholder() || cleanScore == null
              ? _value.cleanScore
              // ignore: cast_nullable_to_non_nullable
              : cleanScore as int,
      explainScore:
          explainScore == const $CopyWithPlaceholder() || explainScore == null
              ? _value.explainScore
              // ignore: cast_nullable_to_non_nullable
              : explainScore as int,
      kindnessScore:
          kindnessScore == const $CopyWithPlaceholder() || kindnessScore == null
              ? _value.kindnessScore
              // ignore: cast_nullable_to_non_nullable
              : kindnessScore as int,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
    );
  }
}

extension $ReviewStateCopyWith on ReviewState {
  /// Returns a callable class that can be used as follows: `instanceOfReviewState.copyWith(...)` or like so:`instanceOfReviewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewStateCWProxy get copyWith => _$ReviewStateCWProxyImpl(this);
}

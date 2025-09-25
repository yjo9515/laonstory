// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../edit_info_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EditInfoStateCWProxy {
  EditInfoState status(CommonStatus status);

  EditInfoState errorMessage(String? errorMessage);

  EditInfoState filterType(FilterType filterType);

  EditInfoState hasReachedMax(bool hasReachedMax);

  EditInfoState orderType(OrderType orderType);

  EditInfoState page(int page);

  EditInfoState query(String? query);

  EditInfoState profile(Profile profile);

  EditInfoState sendEmail(bool sendEmail);

  EditInfoState emailConfirm(bool emailConfirm);

  EditInfoState phoneConfirm(bool phoneConfirm);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditInfoState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditInfoState(...).copyWith(id: 12, name: "My name")
  /// ````
  EditInfoState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Profile? profile,
    bool? sendEmail,
    bool? emailConfirm,
    bool? phoneConfirm,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEditInfoState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEditInfoState.copyWith.fieldName(...)`
class _$EditInfoStateCWProxyImpl implements _$EditInfoStateCWProxy {
  const _$EditInfoStateCWProxyImpl(this._value);

  final EditInfoState _value;

  @override
  EditInfoState status(CommonStatus status) => this(status: status);

  @override
  EditInfoState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  EditInfoState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  EditInfoState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  EditInfoState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  EditInfoState page(int page) => this(page: page);

  @override
  EditInfoState query(String? query) => this(query: query);

  @override
  EditInfoState profile(Profile profile) => this(profile: profile);

  @override
  EditInfoState sendEmail(bool sendEmail) => this(sendEmail: sendEmail);

  @override
  EditInfoState emailConfirm(bool emailConfirm) =>
      this(emailConfirm: emailConfirm);

  @override
  EditInfoState phoneConfirm(bool phoneConfirm) =>
      this(phoneConfirm: phoneConfirm);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditInfoState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditInfoState(...).copyWith(id: 12, name: "My name")
  /// ````
  EditInfoState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? profile = const $CopyWithPlaceholder(),
    Object? sendEmail = const $CopyWithPlaceholder(),
    Object? emailConfirm = const $CopyWithPlaceholder(),
    Object? phoneConfirm = const $CopyWithPlaceholder(),
  }) {
    return EditInfoState(
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
      profile: profile == const $CopyWithPlaceholder() || profile == null
          ? _value.profile
          // ignore: cast_nullable_to_non_nullable
          : profile as Profile,
      sendEmail: sendEmail == const $CopyWithPlaceholder() || sendEmail == null
          ? _value.sendEmail
          // ignore: cast_nullable_to_non_nullable
          : sendEmail as bool,
      emailConfirm:
          emailConfirm == const $CopyWithPlaceholder() || emailConfirm == null
              ? _value.emailConfirm
              // ignore: cast_nullable_to_non_nullable
              : emailConfirm as bool,
      phoneConfirm:
          phoneConfirm == const $CopyWithPlaceholder() || phoneConfirm == null
              ? _value.phoneConfirm
              // ignore: cast_nullable_to_non_nullable
              : phoneConfirm as bool,
    );
  }
}

extension $EditInfoStateCopyWith on EditInfoState {
  /// Returns a callable class that can be used as follows: `instanceOfEditInfoState.copyWith(...)` or like so:`instanceOfEditInfoState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EditInfoStateCWProxy get copyWith => _$EditInfoStateCWProxyImpl(this);
}

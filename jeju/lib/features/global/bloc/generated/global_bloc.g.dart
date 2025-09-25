// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../global_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GlobalStateCWProxy {
  GlobalState tokenStatus(TokenStatus? tokenStatus);

  GlobalState appData(AppData? appData);

  GlobalState secureModel(SecureModel secureModel);

  GlobalState profile(Profile? profile);

  GlobalState status(CommonStatus status);

  GlobalState errorMessage(String? errorMessage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GlobalState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GlobalState(...).copyWith(id: 12, name: "My name")
  /// ````
  GlobalState call({
    TokenStatus? tokenStatus,
    AppData? appData,
    SecureModel? secureModel,
    Profile? profile,
    CommonStatus? status,
    String? errorMessage,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGlobalState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGlobalState.copyWith.fieldName(...)`
class _$GlobalStateCWProxyImpl implements _$GlobalStateCWProxy {
  const _$GlobalStateCWProxyImpl(this._value);

  final GlobalState _value;

  @override
  GlobalState tokenStatus(TokenStatus? tokenStatus) =>
      this(tokenStatus: tokenStatus);

  @override
  GlobalState appData(AppData? appData) => this(appData: appData);

  @override
  GlobalState secureModel(SecureModel secureModel) =>
      this(secureModel: secureModel);

  @override
  GlobalState profile(Profile? profile) => this(profile: profile);

  @override
  GlobalState status(CommonStatus status) => this(status: status);

  @override
  GlobalState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GlobalState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GlobalState(...).copyWith(id: 12, name: "My name")
  /// ````
  GlobalState call({
    Object? tokenStatus = const $CopyWithPlaceholder(),
    Object? appData = const $CopyWithPlaceholder(),
    Object? secureModel = const $CopyWithPlaceholder(),
    Object? profile = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
  }) {
    return GlobalState(
      tokenStatus: tokenStatus == const $CopyWithPlaceholder()
          ? _value.tokenStatus
          // ignore: cast_nullable_to_non_nullable
          : tokenStatus as TokenStatus?,
      appData: appData == const $CopyWithPlaceholder()
          ? _value.appData
          // ignore: cast_nullable_to_non_nullable
          : appData as AppData?,
      secureModel:
          secureModel == const $CopyWithPlaceholder() || secureModel == null
              ? _value.secureModel
              // ignore: cast_nullable_to_non_nullable
              : secureModel as SecureModel,
      profile: profile == const $CopyWithPlaceholder()
          ? _value.profile
          // ignore: cast_nullable_to_non_nullable
          : profile as Profile?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
    );
  }
}

extension $GlobalStateCopyWith on GlobalState {
  /// Returns a callable class that can be used as follows: `instanceOfGlobalState.copyWith(...)` or like so:`instanceOfGlobalState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GlobalStateCWProxy get copyWith => _$GlobalStateCWProxyImpl(this);
}

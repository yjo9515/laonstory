// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profit_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfitCWProxy {
  Profit bank(String? bank);

  Profit account(String? account);

  Profit possibleAmount(int? possibleAmount);

  Profit anticipateAmount(int? anticipateAmount);

  Profit successAmount(int? successAmount);

  Profit reservationList(List<ReservationList> reservationList);

  Profit hostCalculateList(List<HostCalculateList> hostCalculateList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profit(...).copyWith(id: 12, name: "My name")
  /// ````
  Profit call({
    String? bank,
    String? account,
    int? possibleAmount,
    int? anticipateAmount,
    int? successAmount,
    List<ReservationList>? reservationList,
    List<HostCalculateList>? hostCalculateList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfit.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfit.copyWith.fieldName(...)`
class _$ProfitCWProxyImpl implements _$ProfitCWProxy {
  const _$ProfitCWProxyImpl(this._value);

  final Profit _value;

  @override
  Profit bank(String? bank) => this(bank: bank);

  @override
  Profit account(String? account) => this(account: account);

  @override
  Profit possibleAmount(int? possibleAmount) =>
      this(possibleAmount: possibleAmount);

  @override
  Profit anticipateAmount(int? anticipateAmount) =>
      this(anticipateAmount: anticipateAmount);

  @override
  Profit successAmount(int? successAmount) =>
      this(successAmount: successAmount);

  @override
  Profit reservationList(List<ReservationList> reservationList) =>
      this(reservationList: reservationList);

  @override
  Profit hostCalculateList(List<HostCalculateList> hostCalculateList) =>
      this(hostCalculateList: hostCalculateList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profit(...).copyWith(id: 12, name: "My name")
  /// ````
  Profit call({
    Object? bank = const $CopyWithPlaceholder(),
    Object? account = const $CopyWithPlaceholder(),
    Object? possibleAmount = const $CopyWithPlaceholder(),
    Object? anticipateAmount = const $CopyWithPlaceholder(),
    Object? successAmount = const $CopyWithPlaceholder(),
    Object? reservationList = const $CopyWithPlaceholder(),
    Object? hostCalculateList = const $CopyWithPlaceholder(),
  }) {
    return Profit(
      bank: bank == const $CopyWithPlaceholder()
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as String?,
      account: account == const $CopyWithPlaceholder()
          ? _value.account
          // ignore: cast_nullable_to_non_nullable
          : account as String?,
      possibleAmount: possibleAmount == const $CopyWithPlaceholder()
          ? _value.possibleAmount
          // ignore: cast_nullable_to_non_nullable
          : possibleAmount as int?,
      anticipateAmount: anticipateAmount == const $CopyWithPlaceholder()
          ? _value.anticipateAmount
          // ignore: cast_nullable_to_non_nullable
          : anticipateAmount as int?,
      successAmount: successAmount == const $CopyWithPlaceholder()
          ? _value.successAmount
          // ignore: cast_nullable_to_non_nullable
          : successAmount as int?,
      reservationList: reservationList == const $CopyWithPlaceholder() ||
              reservationList == null
          ? _value.reservationList
          // ignore: cast_nullable_to_non_nullable
          : reservationList as List<ReservationList>,
      hostCalculateList: hostCalculateList == const $CopyWithPlaceholder() ||
              hostCalculateList == null
          ? _value.hostCalculateList
          // ignore: cast_nullable_to_non_nullable
          : hostCalculateList as List<HostCalculateList>,
    );
  }
}

extension $ProfitCopyWith on Profit {
  /// Returns a callable class that can be used as follows: `instanceOfProfit.copyWith(...)` or like so:`instanceOfProfit.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfitCWProxy get copyWith => _$ProfitCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profit _$ProfitFromJson(Map<String, dynamic> json) => Profit(
      bank: json['bank'] as String?,
      account: json['account'] as String?,
      possibleAmount: json['possibleAmount'] as int?,
      anticipateAmount: json['anticipateAmount'] as int?,
      successAmount: json['successAmount'] as int?,
      reservationList: (json['reservationList'] as List<dynamic>?)
              ?.map((e) => ReservationList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hostCalculateList: (json['hostCalculateList'] as List<dynamic>?)
              ?.map(
                  (e) => HostCalculateList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProfitToJson(Profit instance) => <String, dynamic>{
      'bank': instance.bank,
      'account': instance.account,
      'possibleAmount': instance.possibleAmount,
      'anticipateAmount': instance.anticipateAmount,
      'successAmount': instance.successAmount,
      'reservationList': instance.reservationList,
      'hostCalculateList': instance.hostCalculateList,
    };

HostCalculateList _$HostCalculateListFromJson(Map<String, dynamic> json) =>
    HostCalculateList(
      completeAmount: json['completeAmount'] as int?,
      completeDate: json['completeDate'] as String?,
      createdAt: json['createdAt'] as String?,
      id: json['id'] as int?,
      requestAmount: json['requestAmount'] as int?,
      status: json['status'] as String?,
      statusName: json['statusName'] as String?,
    );

Map<String, dynamic> _$HostCalculateListToJson(HostCalculateList instance) =>
    <String, dynamic>{
      'completeAmount': instance.completeAmount,
      'completeDate': instance.completeDate,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'requestAmount': instance.requestAmount,
      'status': instance.status,
      'statusName': instance.statusName,
    };

ReservationList _$ReservationListFromJson(Map<String, dynamic> json) =>
    ReservationList(
      id: json['id'] as int?,
      orderNumber: json['orderNumber'] as String?,
      totalAmount: json['totalAmount'] as int?,
      createdAt: json['createdAt'] as String?,
      calculateStatus: json['calculateStatus'] as String?,
      beforeAmount: json['beforeAmount'] as int?,
    );

Map<String, dynamic> _$ReservationListToJson(ReservationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'totalAmount': instance.totalAmount,
      'createdAt': instance.createdAt,
      'calculateStatus': instance.calculateStatus,
      'beforeAmount': instance.beforeAmount,
    };

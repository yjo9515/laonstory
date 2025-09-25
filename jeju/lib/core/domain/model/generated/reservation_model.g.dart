// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservation_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationCWProxy {
  Reservation createdAt(DateTime? createdAt);

  Reservation days(int? days);

  Reservation endDate(DateTime? endDate);

  Reservation id(int? id);

  Reservation name(String? name);

  Reservation orderNumber(String? orderNumber);

  Reservation people(int? people);

  Reservation startDate(DateTime? startDate);

  Reservation status(String? status);

  Reservation totalAmount(int? totalAmount);

  Reservation image(ReservationImage? image);

  Reservation memo(String? memo);

  Reservation room(Room? room);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Reservation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reservation(...).copyWith(id: 12, name: "My name")
  /// ````
  Reservation call({
    DateTime? createdAt,
    int? days,
    DateTime? endDate,
    int? id,
    String? name,
    String? orderNumber,
    int? people,
    DateTime? startDate,
    String? status,
    int? totalAmount,
    ReservationImage? image,
    String? memo,
    Room? room,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservation.copyWith.fieldName(...)`
class _$ReservationCWProxyImpl implements _$ReservationCWProxy {
  const _$ReservationCWProxyImpl(this._value);

  final Reservation _value;

  @override
  Reservation createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  Reservation days(int? days) => this(days: days);

  @override
  Reservation endDate(DateTime? endDate) => this(endDate: endDate);

  @override
  Reservation id(int? id) => this(id: id);

  @override
  Reservation name(String? name) => this(name: name);

  @override
  Reservation orderNumber(String? orderNumber) =>
      this(orderNumber: orderNumber);

  @override
  Reservation people(int? people) => this(people: people);

  @override
  Reservation startDate(DateTime? startDate) => this(startDate: startDate);

  @override
  Reservation status(String? status) => this(status: status);

  @override
  Reservation totalAmount(int? totalAmount) => this(totalAmount: totalAmount);

  @override
  Reservation image(ReservationImage? image) => this(image: image);

  @override
  Reservation memo(String? memo) => this(memo: memo);

  @override
  Reservation room(Room? room) => this(room: room);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Reservation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reservation(...).copyWith(id: 12, name: "My name")
  /// ````
  Reservation call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orderNumber = const $CopyWithPlaceholder(),
    Object? people = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? memo = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
  }) {
    return Reservation(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      days: days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as int?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      orderNumber: orderNumber == const $CopyWithPlaceholder()
          ? _value.orderNumber
          // ignore: cast_nullable_to_non_nullable
          : orderNumber as String?,
      people: people == const $CopyWithPlaceholder()
          ? _value.people
          // ignore: cast_nullable_to_non_nullable
          : people as int?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as ReservationImage?,
      memo: memo == const $CopyWithPlaceholder()
          ? _value.memo
          // ignore: cast_nullable_to_non_nullable
          : memo as String?,
      room: room == const $CopyWithPlaceholder()
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room?,
    );
  }
}

extension $ReservationCopyWith on Reservation {
  /// Returns a callable class that can be used as follows: `instanceOfReservation.copyWith(...)` or like so:`instanceOfReservation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationCWProxy get copyWith => _$ReservationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      days: json['days'] as int?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      id: json['id'] as int?,
      name: json['name'] as String?,
      orderNumber: json['orderNumber'] as String?,
      people: json['people'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      status: json['status'] as String?,
      totalAmount: json['totalAmount'] as int?,
      image: json['image'] == null
          ? null
          : ReservationImage.fromJson(json['image'] as Map<String, dynamic>),
      memo: json['memo'] as String?,
      room: json['room'] == null
          ? null
          : Room.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'days': instance.days,
      'endDate': instance.endDate?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'orderNumber': instance.orderNumber,
      'people': instance.people,
      'startDate': instance.startDate?.toIso8601String(),
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'memo': instance.memo,
      'image': instance.image,
      'room': instance.room,
    };

ReservationImage _$ReservationImageFromJson(Map<String, dynamic> json) =>
    ReservationImage(
      id: json['id'] as int?,
      path: json['path'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
      originalFileName: json['originalFileName'] as String?,
    );

Map<String, dynamic> _$ReservationImageToJson(ReservationImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'size': instance.size,
      'type': instance.type,
      'originalFileName': instance.originalFileName,
    };

ReservationRequest _$ReservationRequestFromJson(Map<String, dynamic> json) =>
    ReservationRequest(
      beforeAmount: json['beforeAmount'] as int?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      orderNumber: json['orderNumber'] as String?,
      people: json['people'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
    );

Map<String, dynamic> _$ReservationRequestToJson(ReservationRequest instance) =>
    <String, dynamic>{
      'beforeAmount': instance.beforeAmount,
      'endDate': instance.endDate?.toIso8601String(),
      'orderNumber': instance.orderNumber,
      'people': instance.people,
      'startDate': instance.startDate?.toIso8601String(),
    };

DateManagement _$DateManagementFromJson(Map<String, dynamic> json) =>
    DateManagement(
      amount: json['amount'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      id: json['id'] as int?,
      isHosting: json['isHosting'] as bool?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$DateManagementToJson(DateManagement instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'id': instance.id,
      'isHosting': instance.isHosting,
      'memo': instance.memo,
    };

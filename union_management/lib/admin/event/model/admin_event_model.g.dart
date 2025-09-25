// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_event_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EventCWProxy {
  Event id(String? id);

  Event createdAt(String? createdAt);

  Event updatedAt(String? updatedAt);

  Event content(String? content);

  Event title(String? title);

  Event eventTime(String? eventTime);

  Event point(int? point);

  Event address(String? address);

  Event eventStatus(String? eventStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Event(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ````
  Event call({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? content,
    String? title,
    String? eventTime,
    int? point,
    String? address,
    String? eventStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEvent.copyWith.fieldName(...)`
class _$EventCWProxyImpl implements _$EventCWProxy {
  const _$EventCWProxyImpl(this._value);

  final Event _value;

  @override
  Event id(String? id) => this(id: id);

  @override
  Event createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Event updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Event content(String? content) => this(content: content);

  @override
  Event title(String? title) => this(title: title);

  @override
  Event eventTime(String? eventTime) => this(eventTime: eventTime);

  @override
  Event point(int? point) => this(point: point);

  @override
  Event address(String? address) => this(address: address);

  @override
  Event eventStatus(String? eventStatus) => this(eventStatus: eventStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Event(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ````
  Event call({
    Object? id = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? eventTime = const $CopyWithPlaceholder(),
    Object? point = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? eventStatus = const $CopyWithPlaceholder(),
  }) {
    return Event(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      eventTime: eventTime == const $CopyWithPlaceholder()
          ? _value.eventTime
          // ignore: cast_nullable_to_non_nullable
          : eventTime as String?,
      point: point == const $CopyWithPlaceholder()
          ? _value.point
          // ignore: cast_nullable_to_non_nullable
          : point as int?,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      eventStatus: eventStatus == const $CopyWithPlaceholder()
          ? _value.eventStatus
          // ignore: cast_nullable_to_non_nullable
          : eventStatus as String?,
    );
  }
}

extension $EventCopyWith on Event {
  /// Returns a callable class that can be used as follows: `instanceOfEvent.copyWith(...)` or like so:`instanceOfEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EventCWProxy get copyWith => _$EventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminEventModel _$AdminEventModelFromJson(Map<String, dynamic> json) =>
    AdminEventModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminEventModelToJson(AdminEventModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

EventDetailModel _$EventDetailModelFromJson(Map<String, dynamic> json) =>
    EventDetailModel(
      data: json['data'] == null
          ? null
          : EventDetail.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$EventDetailModelToJson(EventDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      request: json['request'] as bool?,
    );

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'event': instance.event,
      'request': instance.request,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      content: json['content'] as String?,
      title: json['title'] as String?,
      eventTime: json['eventTime'] as String?,
      point: json['point'] as int?,
      address: json['address'] as String?,
      eventStatus: json['eventStatus'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'title': instance.title,
      'eventTime': instance.eventTime,
      'content': instance.content,
      'address': instance.address,
      'point': instance.point,
      'eventStatus': instance.eventStatus,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notification_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationCWProxy {
  Notification title(String? title);

  Notification body(String? body);

  Notification id(String? id);

  Notification type(String? type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWith(id: 12, name: "My name")
  /// ````
  Notification call({
    String? title,
    String? body,
    String? id,
    String? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotification.copyWith.fieldName(...)`
class _$NotificationCWProxyImpl implements _$NotificationCWProxy {
  const _$NotificationCWProxyImpl(this._value);

  final Notification _value;

  @override
  Notification title(String? title) => this(title: title);

  @override
  Notification body(String? body) => this(body: body);

  @override
  Notification id(String? id) => this(id: id);

  @override
  Notification type(String? type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWith(id: 12, name: "My name")
  /// ````
  Notification call({
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return Notification(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      body: body == const $CopyWithPlaceholder()
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
    );
  }
}

extension $NotificationCopyWith on Notification {
  /// Returns a callable class that can be used as follows: `instanceOfNotification.copyWith(...)` or like so:`instanceOfNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationCWProxy get copyWith => _$NotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      title: json['title'] as String?,
      body: json['body'] as String?,
      id: json['id'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'id': instance.id,
      'type': instance.type,
    };

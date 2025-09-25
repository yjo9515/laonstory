// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EventStateCWProxy {
  EventState status(CommonStatus status);

  EventState message(String message);

  EventState page(int page);

  EventState query(String? query);

  EventState meta(Meta? meta);

  EventState filterType(FilterType filterType);

  EventState orderType(OrderType orderType);

  EventState hasReachedMax(bool hasReachedMax);

  EventState events(List<Event> events);

  EventState detailEvent(EventDetail detailEvent);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventState(...).copyWith(id: 12, name: "My name")
  /// ````
  EventState call({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
    bool? hasReachedMax,
    List<Event>? events,
    EventDetail? detailEvent,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEventState.copyWith.fieldName(...)`
class _$EventStateCWProxyImpl implements _$EventStateCWProxy {
  const _$EventStateCWProxyImpl(this._value);

  final EventState _value;

  @override
  EventState status(CommonStatus status) => this(status: status);

  @override
  EventState message(String message) => this(message: message);

  @override
  EventState page(int page) => this(page: page);

  @override
  EventState query(String? query) => this(query: query);

  @override
  EventState meta(Meta? meta) => this(meta: meta);

  @override
  EventState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  EventState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  EventState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  EventState events(List<Event> events) => this(events: events);

  @override
  EventState detailEvent(EventDetail detailEvent) =>
      this(detailEvent: detailEvent);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventState(...).copyWith(id: 12, name: "My name")
  /// ````
  EventState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
    Object? detailEvent = const $CopyWithPlaceholder(),
  }) {
    return EventState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Meta?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      events: events == const $CopyWithPlaceholder() || events == null
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as List<Event>,
      detailEvent:
          detailEvent == const $CopyWithPlaceholder() || detailEvent == null
              ? _value.detailEvent
              // ignore: cast_nullable_to_non_nullable
              : detailEvent as EventDetail,
    );
  }
}

extension $EventStateCopyWith on EventState {
  /// Returns a callable class that can be used as follows: `instanceOfEventState.copyWith(...)` or like so:`instanceOfEventState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EventStateCWProxy get copyWith => _$EventStateCWProxyImpl(this);
}

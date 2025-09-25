// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservation_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationStateCWProxy {
  ReservationState status(CommonStatus status);

  ReservationState errorMessage(String? errorMessage);

  ReservationState filterType(FilterType filterType);

  ReservationState hasReachedMax(bool hasReachedMax);

  ReservationState orderType(OrderType orderType);

  ReservationState page(int page);

  ReservationState query(String? query);

  ReservationState reservation(Reservation reservation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Reservation? reservation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationState.copyWith.fieldName(...)`
class _$ReservationStateCWProxyImpl implements _$ReservationStateCWProxy {
  const _$ReservationStateCWProxyImpl(this._value);

  final ReservationState _value;

  @override
  ReservationState status(CommonStatus status) => this(status: status);

  @override
  ReservationState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ReservationState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  ReservationState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ReservationState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  ReservationState page(int page) => this(page: page);

  @override
  ReservationState query(String? query) => this(query: query);

  @override
  ReservationState reservation(Reservation reservation) =>
      this(reservation: reservation);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? reservation = const $CopyWithPlaceholder(),
  }) {
    return ReservationState(
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
      reservation:
          reservation == const $CopyWithPlaceholder() || reservation == null
              ? _value.reservation
              // ignore: cast_nullable_to_non_nullable
              : reservation as Reservation,
    );
  }
}

extension $ReservationStateCopyWith on ReservationState {
  /// Returns a callable class that can be used as follows: `instanceOfReservationState.copyWith(...)` or like so:`instanceOfReservationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationStateCWProxy get copyWith => _$ReservationStateCWProxyImpl(this);
}

abstract class _$ReservationListStateCWProxy {
  ReservationListState status(CommonStatus status);

  ReservationListState errorMessage(String? errorMessage);

  ReservationListState filterType(FilterType filterType);

  ReservationListState hasReachedMax(bool hasReachedMax);

  ReservationListState orderType(OrderType orderType);

  ReservationListState page(int page);

  ReservationListState query(String? query);

  ReservationListState reservationList(List<Reservation> reservationList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationListState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationListState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    List<Reservation>? reservationList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationListState.copyWith.fieldName(...)`
class _$ReservationListStateCWProxyImpl
    implements _$ReservationListStateCWProxy {
  const _$ReservationListStateCWProxyImpl(this._value);

  final ReservationListState _value;

  @override
  ReservationListState status(CommonStatus status) => this(status: status);

  @override
  ReservationListState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ReservationListState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  ReservationListState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ReservationListState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  ReservationListState page(int page) => this(page: page);

  @override
  ReservationListState query(String? query) => this(query: query);

  @override
  ReservationListState reservationList(List<Reservation> reservationList) =>
      this(reservationList: reservationList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationListState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationListState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? reservationList = const $CopyWithPlaceholder(),
  }) {
    return ReservationListState(
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
      reservationList: reservationList == const $CopyWithPlaceholder() ||
              reservationList == null
          ? _value.reservationList
          // ignore: cast_nullable_to_non_nullable
          : reservationList as List<Reservation>,
    );
  }
}

extension $ReservationListStateCopyWith on ReservationListState {
  /// Returns a callable class that can be used as follows: `instanceOfReservationListState.copyWith(...)` or like so:`instanceOfReservationListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationListStateCWProxy get copyWith =>
      _$ReservationListStateCWProxyImpl(this);
}

abstract class _$ReservationDetailStateCWProxy {
  ReservationDetailState status(CommonStatus status);

  ReservationDetailState errorMessage(String? errorMessage);

  ReservationDetailState filterType(FilterType filterType);

  ReservationDetailState hasReachedMax(bool hasReachedMax);

  ReservationDetailState orderType(OrderType orderType);

  ReservationDetailState page(int page);

  ReservationDetailState query(String? query);

  ReservationDetailState reservation(Reservation reservation);

  ReservationDetailState room(Room room);

  ReservationDetailState message(String? message);

  ReservationDetailState dto(Dto dto);

  ReservationDetailState agree(bool agree);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationDetailState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Reservation? reservation,
    Room? room,
    String? message,
    Dto? dto,
    bool? agree,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationDetailState.copyWith.fieldName(...)`
class _$ReservationDetailStateCWProxyImpl
    implements _$ReservationDetailStateCWProxy {
  const _$ReservationDetailStateCWProxyImpl(this._value);

  final ReservationDetailState _value;

  @override
  ReservationDetailState status(CommonStatus status) => this(status: status);

  @override
  ReservationDetailState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ReservationDetailState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  ReservationDetailState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ReservationDetailState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  ReservationDetailState page(int page) => this(page: page);

  @override
  ReservationDetailState query(String? query) => this(query: query);

  @override
  ReservationDetailState reservation(Reservation reservation) =>
      this(reservation: reservation);

  @override
  ReservationDetailState room(Room room) => this(room: room);

  @override
  ReservationDetailState message(String? message) => this(message: message);

  @override
  ReservationDetailState dto(Dto dto) => this(dto: dto);

  @override
  ReservationDetailState agree(bool agree) => this(agree: agree);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationDetailState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? reservation = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? dto = const $CopyWithPlaceholder(),
    Object? agree = const $CopyWithPlaceholder(),
  }) {
    return ReservationDetailState(
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
      reservation:
          reservation == const $CopyWithPlaceholder() || reservation == null
              ? _value.reservation
              // ignore: cast_nullable_to_non_nullable
              : reservation as Reservation,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      dto: dto == const $CopyWithPlaceholder() || dto == null
          ? _value.dto
          // ignore: cast_nullable_to_non_nullable
          : dto as Dto,
      agree: agree == const $CopyWithPlaceholder() || agree == null
          ? _value.agree
          // ignore: cast_nullable_to_non_nullable
          : agree as bool,
    );
  }
}

extension $ReservationDetailStateCopyWith on ReservationDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfReservationDetailState.copyWith(...)` or like so:`instanceOfReservationDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationDetailStateCWProxy get copyWith =>
      _$ReservationDetailStateCWProxyImpl(this);
}

abstract class _$ReservationManagementStateCWProxy {
  ReservationManagementState status(CommonStatus status);

  ReservationManagementState errorMessage(String? errorMessage);

  ReservationManagementState filterType(FilterType filterType);

  ReservationManagementState hasReachedMax(bool hasReachedMax);

  ReservationManagementState orderType(OrderType orderType);

  ReservationManagementState page(int page);

  ReservationManagementState query(String? query);

  ReservationManagementState events(Map<String, CalenderEvent> events);

  ReservationManagementState calendarDate(DateTime? calendarDate);

  ReservationManagementState calendarController(
      CrCalendarController? calendarController);

  ReservationManagementState room(Room room);

  ReservationManagementState rooms(List<Room> rooms);

  ReservationManagementState reservationList(List<Reservation> reservationList);

  ReservationManagementState dateManagement(
      List<DateManagement> dateManagement);

  ReservationManagementState disabledDate(List<DateTime> disabledDate);

  ReservationManagementState properties(DayItemProperties? properties);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationManagementState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Map<String, CalenderEvent>? events,
    DateTime? calendarDate,
    CrCalendarController? calendarController,
    Room? room,
    List<Room>? rooms,
    List<Reservation>? reservationList,
    List<DateManagement>? dateManagement,
    List<DateTime>? disabledDate,
    DayItemProperties? properties,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationManagementState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationManagementState.copyWith.fieldName(...)`
class _$ReservationManagementStateCWProxyImpl
    implements _$ReservationManagementStateCWProxy {
  const _$ReservationManagementStateCWProxyImpl(this._value);

  final ReservationManagementState _value;

  @override
  ReservationManagementState status(CommonStatus status) =>
      this(status: status);

  @override
  ReservationManagementState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  ReservationManagementState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  ReservationManagementState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  ReservationManagementState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  ReservationManagementState page(int page) => this(page: page);

  @override
  ReservationManagementState query(String? query) => this(query: query);

  @override
  ReservationManagementState events(Map<String, CalenderEvent> events) =>
      this(events: events);

  @override
  ReservationManagementState calendarDate(DateTime? calendarDate) =>
      this(calendarDate: calendarDate);

  @override
  ReservationManagementState calendarController(
          CrCalendarController? calendarController) =>
      this(calendarController: calendarController);

  @override
  ReservationManagementState room(Room room) => this(room: room);

  @override
  ReservationManagementState rooms(List<Room> rooms) => this(rooms: rooms);

  @override
  ReservationManagementState reservationList(
          List<Reservation> reservationList) =>
      this(reservationList: reservationList);

  @override
  ReservationManagementState dateManagement(
          List<DateManagement> dateManagement) =>
      this(dateManagement: dateManagement);

  @override
  ReservationManagementState disabledDate(List<DateTime> disabledDate) =>
      this(disabledDate: disabledDate);

  @override
  ReservationManagementState properties(DayItemProperties? properties) =>
      this(properties: properties);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationManagementState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
    Object? calendarDate = const $CopyWithPlaceholder(),
    Object? calendarController = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
    Object? reservationList = const $CopyWithPlaceholder(),
    Object? dateManagement = const $CopyWithPlaceholder(),
    Object? disabledDate = const $CopyWithPlaceholder(),
    Object? properties = const $CopyWithPlaceholder(),
  }) {
    return ReservationManagementState(
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
      events: events == const $CopyWithPlaceholder() || events == null
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as Map<String, CalenderEvent>,
      calendarDate: calendarDate == const $CopyWithPlaceholder()
          ? _value.calendarDate
          // ignore: cast_nullable_to_non_nullable
          : calendarDate as DateTime?,
      calendarController: calendarController == const $CopyWithPlaceholder()
          ? _value.calendarController
          // ignore: cast_nullable_to_non_nullable
          : calendarController as CrCalendarController?,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
      reservationList: reservationList == const $CopyWithPlaceholder() ||
              reservationList == null
          ? _value.reservationList
          // ignore: cast_nullable_to_non_nullable
          : reservationList as List<Reservation>,
      dateManagement: dateManagement == const $CopyWithPlaceholder() ||
              dateManagement == null
          ? _value.dateManagement
          // ignore: cast_nullable_to_non_nullable
          : dateManagement as List<DateManagement>,
      disabledDate:
          disabledDate == const $CopyWithPlaceholder() || disabledDate == null
              ? _value.disabledDate
              // ignore: cast_nullable_to_non_nullable
              : disabledDate as List<DateTime>,
      properties: properties == const $CopyWithPlaceholder()
          ? _value.properties
          // ignore: cast_nullable_to_non_nullable
          : properties as DayItemProperties?,
    );
  }
}

extension $ReservationManagementStateCopyWith on ReservationManagementState {
  /// Returns a callable class that can be used as follows: `instanceOfReservationManagementState.copyWith(...)` or like so:`instanceOfReservationManagementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationManagementStateCWProxy get copyWith =>
      _$ReservationManagementStateCWProxyImpl(this);
}

abstract class _$HostManagementStateCWProxy {
  HostManagementState status(CommonStatus status);

  HostManagementState errorMessage(String? errorMessage);

  HostManagementState filterType(FilterType filterType);

  HostManagementState hasReachedMax(bool hasReachedMax);

  HostManagementState orderType(OrderType orderType);

  HostManagementState page(int page);

  HostManagementState query(String? query);

  HostManagementState amount(int? amount);

  HostManagementState enable(bool enable);

  HostManagementState isHosting(bool? isHosting);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostManagementState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    int? amount,
    bool? enable,
    bool? isHosting,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostManagementState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostManagementState.copyWith.fieldName(...)`
class _$HostManagementStateCWProxyImpl implements _$HostManagementStateCWProxy {
  const _$HostManagementStateCWProxyImpl(this._value);

  final HostManagementState _value;

  @override
  HostManagementState status(CommonStatus status) => this(status: status);

  @override
  HostManagementState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HostManagementState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  HostManagementState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  HostManagementState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  HostManagementState page(int page) => this(page: page);

  @override
  HostManagementState query(String? query) => this(query: query);

  @override
  HostManagementState amount(int? amount) => this(amount: amount);

  @override
  HostManagementState enable(bool enable) => this(enable: enable);

  @override
  HostManagementState isHosting(bool? isHosting) => this(isHosting: isHosting);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostManagementState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? enable = const $CopyWithPlaceholder(),
    Object? isHosting = const $CopyWithPlaceholder(),
  }) {
    return HostManagementState(
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
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int?,
      enable: enable == const $CopyWithPlaceholder() || enable == null
          ? _value.enable
          // ignore: cast_nullable_to_non_nullable
          : enable as bool,
      isHosting: isHosting == const $CopyWithPlaceholder()
          ? _value.isHosting
          // ignore: cast_nullable_to_non_nullable
          : isHosting as bool?,
    );
  }
}

extension $HostManagementStateCopyWith on HostManagementState {
  /// Returns a callable class that can be used as follows: `instanceOfHostManagementState.copyWith(...)` or like so:`instanceOfHostManagementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostManagementStateCWProxy get copyWith =>
      _$HostManagementStateCWProxyImpl(this);
}

abstract class _$HostReservationDetailStateCWProxy {
  HostReservationDetailState status(CommonStatus status);

  HostReservationDetailState errorMessage(String? errorMessage);

  HostReservationDetailState filterType(FilterType filterType);

  HostReservationDetailState hasReachedMax(bool hasReachedMax);

  HostReservationDetailState orderType(OrderType orderType);

  HostReservationDetailState page(int page);

  HostReservationDetailState query(String? query);

  HostReservationDetailState reservation(Reservation reservation);

  HostReservationDetailState memo(String? memo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostReservationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostReservationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostReservationDetailState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    Reservation? reservation,
    String? memo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostReservationDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostReservationDetailState.copyWith.fieldName(...)`
class _$HostReservationDetailStateCWProxyImpl
    implements _$HostReservationDetailStateCWProxy {
  const _$HostReservationDetailStateCWProxyImpl(this._value);

  final HostReservationDetailState _value;

  @override
  HostReservationDetailState status(CommonStatus status) =>
      this(status: status);

  @override
  HostReservationDetailState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HostReservationDetailState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  HostReservationDetailState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  HostReservationDetailState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  HostReservationDetailState page(int page) => this(page: page);

  @override
  HostReservationDetailState query(String? query) => this(query: query);

  @override
  HostReservationDetailState reservation(Reservation reservation) =>
      this(reservation: reservation);

  @override
  HostReservationDetailState memo(String? memo) => this(memo: memo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostReservationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostReservationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostReservationDetailState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? reservation = const $CopyWithPlaceholder(),
    Object? memo = const $CopyWithPlaceholder(),
  }) {
    return HostReservationDetailState(
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
      reservation:
          reservation == const $CopyWithPlaceholder() || reservation == null
              ? _value.reservation
              // ignore: cast_nullable_to_non_nullable
              : reservation as Reservation,
      memo: memo == const $CopyWithPlaceholder()
          ? _value.memo
          // ignore: cast_nullable_to_non_nullable
          : memo as String?,
    );
  }
}

extension $HostReservationDetailStateCopyWith on HostReservationDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfHostReservationDetailState.copyWith(...)` or like so:`instanceOfHostReservationDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostReservationDetailStateCWProxy get copyWith =>
      _$HostReservationDetailStateCWProxyImpl(this);
}

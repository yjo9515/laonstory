import 'package:cr_calendar/cr_calendar.dart';

import '../../../core/core.dart';
import 'package:copy_with_extension/copy_with_extension.dart';


part 'generated/reservation_state.g.dart';

@CopyWith()
class ReservationState extends CommonState {
  const ReservationState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.reservation = const Reservation(),
  });


  final Reservation reservation;
  
  @override
  List<Object?> get props => [...super.props, reservation];
}

@CopyWith()
class ReservationListState extends ReservationState {
  const ReservationListState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.reservationList = const <Reservation>[],
  });

  final List<Reservation> reservationList;

  @override
  List<Object?> get props => [...super.props, reservationList];
}

@CopyWith()
class ReservationDetailState extends ReservationState {
  const ReservationDetailState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.reservation,
    this.room = const Room(),
    this.message,
    this.dto = const Dto(),
    this.agree = false,
  });

  final Room room;
  final String? message;
  final Dto dto;
  final bool agree;

  @override
  List<Object?> get props => [...super.props, room, message,dto,agree];
}

@CopyWith()
class ReservationManagementState extends ReservationState {
  const ReservationManagementState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.events = const {},
    this.calendarDate,
    this.calendarController,
    this.room = const Room(),
    this.rooms = const [],
    this.reservationList = const <Reservation>[],
    this.dateManagement = const <DateManagement>[],
    this.disabledDate = const <DateTime>[],
    this.properties



  });
  final DateTime? calendarDate;
  final CrCalendarController? calendarController;
  final Room room;
  final List<Room> rooms;
  final Map<String, CalenderEvent> events;
  final List<Reservation> reservationList;
  final List<DateManagement> dateManagement;
  final List<DateTime> disabledDate;
  final DayItemProperties? properties;

  @override
  List<Object?> get props => [...super.props, events, calendarDate,calendarController, room, rooms, reservationList, dateManagement,disabledDate,properties];
}

@CopyWith()
class HostManagementState extends ReservationState {
  const HostManagementState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.amount,
    this.enable = false,
    this.isHosting,


  });
  final int? amount;
  final bool enable;
  final bool? isHosting;

  @override
  List<Object?> get props => [...super.props, amount, enable, isHosting];
}


class CalenderEvent {
  CalenderEvent(this.model, {this.guestName, this.imageUrl, this.price});

  final CalendarEventModel model;
  final String? imageUrl;
  final int? price;
  final String? guestName;
}
@CopyWith()
class HostReservationDetailState extends ReservationState {
  const HostReservationDetailState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.reservation,
    this.memo,
  });

  final String? memo;

  @override
  List<Object?> get props => [...super.props, memo];
}

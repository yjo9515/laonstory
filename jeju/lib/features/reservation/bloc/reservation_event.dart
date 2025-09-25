import 'package:cr_calendar/cr_calendar.dart';

import '../../../core/core.dart';

class ReservationEvent extends CommonEvent {
  const ReservationEvent();
}

class ChangeDate extends ReservationEvent {
  const ChangeDate(this.date);

  final DateTime date;
}

class SwipeDate extends ReservationEvent {
  const SwipeDate(this.left);

  final bool left;
}

class Agree extends ReservationEvent {
  const Agree({required this.agree});

  final bool agree;
}

class Cancel extends ReservationEvent {
  const Cancel({required this.id});

  final String id;
}


//management

class ChangePickRoom extends ReservationEvent {
  const ChangePickRoom({required this.room});

  final Room room;
}

class AddMemo extends ReservationEvent {
  const AddMemo({required this.memo, required this.reservationId});

  final String memo;
  final int reservationId;
}

class ChangeMemo extends ReservationEvent {
  const ChangeMemo({required this.memo});

  final String memo;
}

class SetAmount extends ReservationEvent {
  const SetAmount({required this.amount});

  final int amount;
}

class ChangeAmount extends ReservationEvent {
  const ChangeAmount({required this.menu});

  final String menu;
}

class SwitchToggle extends ReservationEvent {
  const SwitchToggle({required this.toggle});

  final bool toggle;
}

class Host extends ReservationEvent {
  const Host({required this.id,required this.date});

  final int id;
  final DateTime date;
}

class Property extends ReservationEvent {
  const Property({required this.property,});

  final DayItemProperties property;

}
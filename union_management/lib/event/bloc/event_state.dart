part of 'event_bloc.dart';

@CopyWith()
class EventState extends CommonState {
  final List<Event> events;
  final EventDetail detailEvent;
  final bool hasReachedMax;

  const EventState({
    super.status,
    super.message,
    super.page,
    super.query,
    super.meta,
    super.filterType,
    super.orderType,
    this.hasReachedMax = false,
    this.events = const [],
    this.detailEvent = const EventDetail(),
  });

  @override
  List<Object?> get props => [events, detailEvent, hasReachedMax, message];
}

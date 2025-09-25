part of 'home_bloc.dart';

@CopyWith()
class HomeState extends CommonState {
  final List<Event> events;
  final List<Notice> notices;

  const HomeState({
    super.status,
    super.message,
    super.page,
    super.query,
    super.meta,
    super.filterType,
    super.orderType,
    this.events = const [],
    this.notices = const [],
  });

  @override
  List<Object?> get props => [events, notices];
}

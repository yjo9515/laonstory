part of 'home_bloc.dart';

@CopyWith()
class HomeState extends CommonState {
  const HomeState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.route,
    super.pageInfo,
    this.facilities = const {},
    this.themes = const {},
    this.rooms = const [],
    this.pickRooms = const [],
    this.newRooms = const []
  });

  final Map<String?, List<Facility>?> facilities;
  final Map<String?, List<Facility>?> themes;
  final List<Room> rooms;
  final List<Room> newRooms;
  final List<Room> pickRooms;

  @override
  List<Object?> get props => [...super.props, facilities, themes, rooms, newRooms, pickRooms];
}

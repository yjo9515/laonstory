part of 'admin_event_bloc.dart';

class AdminEventState extends Equatable {
  const AdminEventState({
    required this.status,
    this.searchText,
    this.items,
    this.event,
    this.meta,
    this.userMeta,
    this.message = '오류가 발생하였습니다.',
    this.chartData,
    this.userSearchText,
    this.users = const <User>[],
  });

  final List<Event>? items;
  final Event? event;
  final List<User> users;
  final Meta? meta;
  final Meta? userMeta;
  final CommonStatus status;
  final String? message;
  final String? searchText;
  final String? userSearchText;
  final ChartDataModel? chartData;

  AdminEventState copyWith({
    List<Event>? items,
    CommonStatus? status,
    Meta? meta,
    Meta? userMeta,
    Event? event,
    String? message,
    String? searchText,
    String? userSearchText,
    int? year,
    ChartDataModel? chartData,
    List<User>? users,
  }) {
    return AdminEventState(
        items: items ?? this.items,
        status: status ?? this.status,
        event: event ?? this.event,
        meta: meta ?? this.meta,
        userMeta: userMeta ?? this.userMeta,
        message: message ?? this.message,
        searchText: searchText ?? this.searchText,
        userSearchText: userSearchText ?? this.userSearchText,
        chartData: chartData ?? this.chartData,
        users: users ?? this.users);
  }

  @override
  List<Object?> get props => [items, status, event, meta, userSearchText, userMeta, message, searchText, chartData, users];
}

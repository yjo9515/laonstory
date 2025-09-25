part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  const AdminDashboardState({
    required this.status,
    this.searchText,
    this.notices = const <Notice>[],
    this.events = const <Event>[],
    this.userYear,
    this.pointYear,
    this.message = '오류가 발생하였습니다.',
    this.userChartData = const <ChartData>[],
    this.pays = const <Pay>[],
    this.pointChartData = const <ChartData>[],
  });

  final List<Notice> notices;
  final List<Event> events;
  final List<Pay> pays;
  final CommonStatus status;
  final String? message;
  final String? searchText;
  final int? userYear;
  final int? pointYear;
  final List<ChartData> userChartData;
  final List<ChartData> pointChartData;

  AdminDashboardState copyWith({
    List<Notice>? notices,
    List<Event>? events,
    List<Pay>? pays,
    CommonStatus? status,
    String? message,
    String? searchText,
    int? userYear,
    int? pointYear,
    List<ChartData>? userChartData,
    List<ChartData>? pointChartData,
  }) {
    return AdminDashboardState(
        notices: notices ?? this.notices,
        events: events ?? this.events,
        status: status ?? this.status,
        userYear: userYear ?? this.userYear,
        pointYear: pointYear ?? this.pointYear,
        message: message ?? this.message,
        searchText: searchText ?? this.searchText,
        userChartData: userChartData ?? this.userChartData,
        pays: pays ?? this.pays,
        pointChartData: pointChartData ?? this.pointChartData
    );
  }

  @override
  List<Object?> get props => [notices, events, status, message, searchText, userYear, pointYear, userChartData, pays, pointChartData];
}

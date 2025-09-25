part of 'admin_user_bloc.dart';

class AdminUserState extends CommonState {
  const AdminUserState({
    required super.status,
    super.message,
    super.page,
    super.query,
    super.meta,
    super.filterType,
    super.orderType,
    this.chartData,
    this.year,
    this.searchText,
    this.items,
  });

  final List<User>? items;
  final String? searchText;
  final int? year;
  final UserDataModel? chartData;

  AdminUserState copyWith({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
    List<User>? items,
    String? searchText,
    int? year,
    UserDataModel? chartData,
  }) {
    return AdminUserState(
      status: status ?? this.status,
      message: message ?? this.message,
      page: page ?? this.page,
      query: query ?? this.query,
      meta: meta ?? this.meta,
      filterType: filterType ?? this.filterType,
      orderType: orderType ?? this.orderType,
      chartData: chartData ?? this.chartData,
      year: year ?? this.year,
      searchText: searchText ?? this.searchText,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [items, searchText, year, chartData];
}

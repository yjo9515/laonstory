part of 'admin_pay_bloc.dart';

class AdminPayState extends Equatable {
  const AdminPayState({
    required this.status,
    this.searchText,
    this.items,
    this.meta,
    this.year,
    this.message = '오류가 발생하였습니다.',
    this.chartData,
  });

  final List<Pay>? items;
  final Meta? meta;
  final CommonStatus status;
  final String? message;
  final String? searchText;
  final ChartDataModel? chartData;
  final int? year;

  AdminPayState copyWith({
    List<Pay>? items,
    CommonStatus? status,
    Meta? meta,
    String? message,
    String? searchText,
    int? year,
    ChartDataModel? chartData,
  }) {
    return AdminPayState(
        items: items ?? this.items,
        status: status ?? this.status,
        meta: meta ?? this.meta,
        message: message ?? this.message,
        searchText: searchText ?? this.searchText,
        year: year ?? this.year,
        chartData: chartData ?? this.chartData);
  }

  @override
  List<Object?> get props => [year, items, status, meta, message, searchText, chartData];
}

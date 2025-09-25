part of 'admin_setting_bloc.dart';

class AdminSettingState extends Equatable {
  const AdminSettingState({
    required this.status,
    this.searchText,
    this.items,
    this.meta,
    this.message = '오류가 발생하였습니다.',
    this.chartData,
    this.uploadStatus = UploadStatus.initial,
    this.managers = const [],
    this.managerMeta,
    this.managerSearchText,
  });

  final List<Notice>? items;
  final Meta? meta;
  final CommonStatus status;
  final String? message;
  final String? searchText;
  final ChartDataModel? chartData;
  final UploadStatus uploadStatus;
  final List<Manager> managers;
  final Meta? managerMeta;
  final String? managerSearchText;

  AdminSettingState copyWith({
    List<Notice>? items,
    CommonStatus? status,
    Meta? meta,
    String? message,
    String? searchText,
    int? year,
    ChartDataModel? chartData,
    UploadStatus? uploadStatus,
    List<Manager>? managers,
    Meta? managerMeta,
    String? managerSearchText,
  }) {
    return AdminSettingState(
      items: items ?? this.items,
      status: status ?? this.status,
      meta: meta ?? this.meta,
      message: message ?? this.message,
      searchText: searchText ?? this.searchText,
      chartData: chartData ?? this.chartData,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      managers: managers ?? this.managers,
      managerMeta: managerMeta ?? this.managerMeta,
      managerSearchText: managerSearchText ?? this.managerSearchText,
    );
  }

  @override
  List<Object?> get props => [
        items,
        status,
        meta,
        message,
        searchText,
        chartData,
        uploadStatus,
        managerMeta,
        managerSearchText,
      ];
}

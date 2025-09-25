part of 'detail_bloc.dart';

class DetailState extends CommonState {
  final List<Pay> pays;
  final List<Point> points;
  final String paySearchText;
  final String eventSearchText;
  final String pointSearchText;
  final Meta? pointMeta;
  final Meta? payMeta;
  final UploadStatus uploadStatus;

  const DetailState({
    super.status,
    super.message,
    super.page,
    super.query,
    super.meta,
    super.filterType,
    super.orderType,
    this.pays = const [],
    this.points = const [],
    this.paySearchText = "",
    this.pointSearchText = "",
    this.eventSearchText = "",
    this.pointMeta,
    this.payMeta,
    this.uploadStatus = UploadStatus.initial,
  });

  DetailState copyWith({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
    List<Pay>? pays,
    List<Point>? points,
    String? paySearchText,
    String? pointSearchText,
    String? eventSearchText,
    Meta? pointMeta,
    Meta? payMeta,
    UploadStatus? uploadStatus,
  }) {
    return DetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      filterType: filterType ?? this.filterType,
      orderType: orderType ?? this.orderType,
      page: page ?? this.page,
      query: query ?? this.query,
      meta: meta ?? this.meta,
      pays: pays ?? this.pays,
      points: points ?? this.points,
      paySearchText: paySearchText ?? this.paySearchText,
      pointSearchText: pointSearchText ?? this.pointSearchText,
      eventSearchText: eventSearchText ?? this.eventSearchText,
      pointMeta: pointMeta ?? this.pointMeta,
      payMeta: payMeta ?? this.payMeta,
      uploadStatus: uploadStatus ?? this.uploadStatus,
    );
  }

  @override
  List<Object?> get props => [pays, points, paySearchText, eventSearchText, pointSearchText, pointMeta, payMeta, uploadStatus, ...super.props];
}

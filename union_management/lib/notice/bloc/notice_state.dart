part of 'notice_bloc.dart';

class NoticeState extends CommonState {
  final List<Notice> notices;
  final Notice detailNotice;
  final bool hasReachedMax;

  const NoticeState({
    super.status,
    super.message,
    super.page,
    super.query,
    super.meta,
    super.filterType,
    super.orderType,
    this.hasReachedMax = false,
    this.notices = const [],
    this.detailNotice = const Notice(),
  });

  NoticeState copyWith({
    CommonStatus? status,
    String? message,
    int? page,
    String? query,
    Meta? meta,
    FilterType? filterType,
    OrderType? orderType,
    bool? hasReachedMax,
    List<Notice>? notices,
    Notice? detailNotice,
  }) {
    return NoticeState(
      status: status ?? this.status,
      message: message ?? this.message,
      page: page ?? this.page,
      query: query ?? this.query,
      meta: meta ?? this.meta,
      filterType: filterType ?? this.filterType,
      orderType: orderType ?? this.orderType,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      notices: notices ?? this.notices,
      detailNotice: detailNotice ?? this.detailNotice,
    );
  }

  @override
  List<Object?> get props => [notices, detailNotice, hasReachedMax];
}

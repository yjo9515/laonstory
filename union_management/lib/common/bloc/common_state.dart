import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../enum/enums.dart';
import '../model/meta_model.dart';

part 'common_state.g.dart';

@CopyWith()
class CommonState extends Equatable {
  const CommonState({
    this.status = CommonStatus.initial,
    this.message = '',
    this.page = 1,
    this.query,
    this.meta,
    this.filterType = FilterType.createdAt,
    this.orderType = OrderType.asc,
  });

  final CommonStatus status;
  final String message;
  final int page;
  final String? query;
  final Meta? meta;
  final FilterType filterType;
  final OrderType orderType;

  @override
  List<Object?> get props => [status, message, page, query, meta, filterType, orderType];
}

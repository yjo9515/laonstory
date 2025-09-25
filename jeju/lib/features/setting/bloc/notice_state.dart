import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
import '../../../core/domain/model/board_model.dart';
part 'generated/notice_state.g.dart';

@CopyWith()
class NoticeState extends CommonState {
  const NoticeState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.noticeList = const [],

  });

  final List<Board> noticeList;


  @override
  List<Object?> get props => [...super.props, noticeList];
}
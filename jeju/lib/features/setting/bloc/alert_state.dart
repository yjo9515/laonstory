import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
part 'generated/alert_state.g.dart';

@CopyWith()
class AlertState extends CommonState {
  const AlertState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.isAll = false,
    this.isOneToOneInquiry = false,
    this.isReservation = false,
    this.isMessage = false,
  });

  final bool isAll;
  final bool isOneToOneInquiry;
  final bool isReservation;
  final bool isMessage;


  @override
  List<Object?> get props => [...super.props, isAll, isOneToOneInquiry, isReservation, isMessage];
}
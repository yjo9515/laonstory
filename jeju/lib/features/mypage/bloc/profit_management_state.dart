import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';

part 'generated/profit_management_state.g.dart';

@CopyWith()
class ProfitManagementState extends CommonState {
  const ProfitManagementState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.profit = const Profit(),
  });


  final Profit profit;


  @override
  List<Object?> get props => [...super.props,profit];
}
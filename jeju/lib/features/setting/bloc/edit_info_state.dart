import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';

part 'generated/edit_info_state.g.dart';

@CopyWith()
class EditInfoState extends CommonState {
  const EditInfoState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.profile = const Profile(),
    this.sendEmail = false,
    this.emailConfirm = false,
    this.phoneConfirm = false,


  });

  final Profile profile;
  final bool emailConfirm;
  final bool sendEmail;
  final bool phoneConfirm;

  @override
  List<Object?> get props => [...super.props, profile, phoneConfirm, emailConfirm, sendEmail];
}


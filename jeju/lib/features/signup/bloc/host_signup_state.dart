import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';

part 'generated/host_signup_state.g.dart';

@CopyWith()
class HostSignUpState extends CommonState {
  const HostSignUpState(
     {
    super.status,
    super.errorMessage,
    super.filterType,
    super.orderType,
    super.page,
    super.query,
    this.fileName = const [],
    this.businessLicense = const [],
    this.hostuser =  const HostUser(),
    this.dto = const Dto()
  });

  final Dto dto;
  final HostUser hostuser;
  final List<File>? businessLicense ;
  final List<String> fileName;


  @override
  List<Object?> get props => [...super.props, hostuser, businessLicense, dto];
}



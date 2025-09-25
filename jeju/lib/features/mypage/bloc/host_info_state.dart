import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';

part 'generated/host_info_state.g.dart';

@CopyWith()
class HostInfoState extends CommonState {
  const HostInfoState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.fileName = const [],
    this.businessLicense = const [],
    this.hostuser =  const HostUser(),
    this.dto = const Dto(),
    this.licenseData = const {}
  });


  final Dto dto;
  final HostUser hostuser;
  final List<File>? businessLicense ;
  final List<String> fileName;
  final Map licenseData;


  @override
  List<Object?> get props => [...super.props,hostuser, businessLicense, dto, licenseData];
}
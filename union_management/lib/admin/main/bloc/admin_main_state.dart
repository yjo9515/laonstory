part of 'admin_main_bloc.dart';

class AdminMainState extends Equatable {
  const AdminMainState({required this.tokenStatus, this.message, this.adminInfo});

  final String? message;
  final CommonStatus tokenStatus;
  final AdminData? adminInfo;

  AdminMainState copyWith({
    String? message,
    CommonStatus? tokenStatus,
    AdminData? adminInfo,
  }) {
    return AdminMainState(message: message ?? this.message, tokenStatus: tokenStatus ?? this.tokenStatus, adminInfo: adminInfo ?? this.adminInfo);
  }

  @override
  List<Object?> get props => [message, tokenStatus, adminInfo];
}

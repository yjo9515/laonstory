part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.status,
    this.message,
    this.file,
    this.page,
    this.isEmailDone,
  });

  final SignUpStatus status;
  final String? message;
  final PlatformFile? file;
  final int? page;
  final bool? isEmailDone;

  SignUpState copyWith({
    SignUpStatus? status,
    String? message,
    PlatformFile? file,
    int? page,
    bool? isEmailDone,
  }) {
    return SignUpState(
      status: status ?? this.status,
      message: message ?? this.message,
      file: file ?? this.file,
      page: page ?? this.page,
      isEmailDone: isEmailDone ?? this.isEmailDone,
    );
  }

  @override
  List<Object?> get props => [status, message, file, page, isEmailDone];
}

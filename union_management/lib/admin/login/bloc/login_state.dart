part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({required this.status, this.message});

  final String? message;
  final CommonStatus status;

  LoginState copyWith({
    String? message,
    CommonStatus? status,
  }) {
    return LoginState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [message, status];
}

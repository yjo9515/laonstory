part of 'login_cubit.dart';

class LoginState extends CommonState {
  const LoginState({this.secureModel, super.status, super.message});

  final SecureModel? secureModel;

  LoginState loginWith({
    CommonStatus? status,
    String? message,
    SecureModel? secureModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      secureModel: secureModel ?? this.secureModel,
    );
  }

  @override
  List<Object?> get props => [status, message, page, query, meta, secureModel];
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Initial extends LoginEvent {
  const Initial();
}

class Login extends LoginEvent {
  const Login(this.id, this.pw);

  final String id;
  final String pw;
}

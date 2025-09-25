part of 'login_bloc.dart';

class LoginEvent extends CommonEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  const Login(this.method);

  final LoginMethod method;
}
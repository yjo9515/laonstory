part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class Initial extends SignUpEvent {
  const Initial();
}

class Oauth extends SignUpEvent {
  const Oauth({this.email = "", this.resend = false});

  final String email;
  final bool? resend;
}

class CheckEmail extends SignUpEvent {
  const CheckEmail(this.email, this.code);

  final String email;
  final String code;
}

class Upload extends SignUpEvent {
  const Upload(this.file);

  final Future<PlatformFile?> file;
}

class SignUp extends SignUpEvent {
  const SignUp(this.createAdminModel);

  final CreateAdminModel createAdminModel;
}

class Pick extends SignUpEvent {
  const Pick(this.index);

  final int index;
}

class GetBrand extends SignUpEvent {
  const GetBrand(this.query, this.page);

  final String query;
  final int page;
}

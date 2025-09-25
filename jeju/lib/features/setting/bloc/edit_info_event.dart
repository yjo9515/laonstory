part of 'edit_info_bloc.dart';

class EditInfoEvent extends CommonEvent {
  const EditInfoEvent();
}

class ChangeInfo extends CommonEvent {
   const ChangeInfo({required this.profile});
   final Profile profile;
}

class GetCode extends CommonEvent {
  const GetCode({required this.profile});
  final Profile profile;
}

class SendEmail extends CommonEvent {
  const SendEmail({required this.email});
  final String email;
}

class ConfirmEmail extends CommonEvent {
  const ConfirmEmail({required this.code});
  final String code;
}

class ConfirmPhone extends CommonEvent {
  const ConfirmPhone();
}
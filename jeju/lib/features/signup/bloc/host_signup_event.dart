part of 'host_signup_bloc.dart';

class HostSignUpEvent extends CommonEvent {
  const HostSignUpEvent();
}

class ChangeHostSignUp extends CommonEvent {
  const ChangeHostSignUp({required this.dto});

  // final HostUser hostuser;
  final Dto dto;
}

class SecondHostSignUp extends CommonEvent {
  const SecondHostSignUp();
  // final File? businessLicense;
  // final Dto dto;
}

class SearchFile extends CommonEvent {
  // const SearchFile({required this.businessLicense});
  // final List<File> businessLicense;

}

class Auth extends CommonEvent {
  const Auth({required this.impUid});
  final String impUid;
}

class Remove extends CommonEvent {
  const Remove({required this.files,required this.fileName});

  final List<File> files;
  final List<String> fileName;
}


/// 코드 커스텀시 이후 내용 추가
/// `CommonEvent`에서 상속받아 사용
/// 만약 커스텀할 필요가 없다면 `CommonEvent`만 사용
/// class 명에 on은 붙이지 않음
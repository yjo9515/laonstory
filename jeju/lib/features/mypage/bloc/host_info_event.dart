part of 'host_info_bloc.dart';

class HostInfoEvent extends CommonEvent {
  const HostInfoEvent();
}

class ChangeHostSignUp extends CommonEvent {
  const ChangeHostSignUp({required this.dto});

  // final HostUser hostuser;
  final Dto dto;
}

class SecondHostSignUp extends CommonEvent {
  // const SecondHostSignUp({required this.dto,required this.businessLicense});
  const SecondHostSignUp();
  // final File? businessLicense;
  // final Dto dto;
}

class SearchFile extends CommonEvent {
  // const SearchFile({required this.businessLicense});
  // final List<File> businessLicense;

}

class Remove extends CommonEvent {
  const Remove({required this.files,required this.fileName});

  final List<File> files;
  final List<String> fileName;
}

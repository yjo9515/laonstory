part of 'global_bloc.dart';

class AppData {
  final String? version;

  AppData({this.version});
}

@CopyWith()
class GlobalState extends Equatable {
  const GlobalState({this.tokenStatus = TokenStatus.initial, this.appData, required this.secureModel, this.profile,this.status = CommonStatus.initial,this.errorMessage = '오류가 발생하였습니다.',});

  final TokenStatus? tokenStatus;
  final AppData? appData;
  final SecureModel secureModel;
  final Profile? profile;
  final CommonStatus status;
  final String? errorMessage;
  @override
  List<Object?> get props => [tokenStatus, appData, secureModel, profile, status, errorMessage];
}

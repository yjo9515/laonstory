part of 'global_bloc.dart';

enum TokenStatus {
  initial,
  hasToken,
  noToken,
  guestToken,
}

class AppConfig {
  final String? version;

  AppConfig({this.version});
}

class GlobalState extends Equatable {
  const GlobalState({this.tokenStatus = TokenStatus.initial, this.appConfig, this.profileModel, required this.secureModel});

  final TokenStatus tokenStatus;
  final ProfileModel? profileModel;
  final AppConfig? appConfig;
  final SecureModel secureModel;

  GlobalState copyWith({TokenStatus? tokenStatus, AppConfig? appConfig, ProfileModel? profileModel, SecureModel? secureModel}) {
    return GlobalState(
      tokenStatus: tokenStatus ?? this.tokenStatus,
      appConfig: appConfig ?? this.appConfig,
      profileModel: profileModel ?? this.profileModel,
      secureModel: secureModel ?? this.secureModel,
    );
  }

  @override
  List<Object?> get props => [tokenStatus, appConfig, profileModel, secureModel];
}

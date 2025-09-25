part of 'splash_bloc.dart';

@CopyWith()
class SplashState extends CommonState {
  const SplashState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.done = false,
    this.tokenStatus = TokenStatus.initial,
  });

  final bool done;
  final TokenStatus tokenStatus;
  
  @override
  List<Object?> get props => [...super.props, done, tokenStatus];
}


part of 'guide_bloc.dart';

@CopyWith()
class GuideState extends CommonState {
  const GuideState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.agree = false,
  });

  final bool agree;

  @override
  List<Object?> get props => [...super.props, agree];
}

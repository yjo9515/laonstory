part of 'mypage_bloc.dart';

@CopyWith()
class MypageState extends CommonState {
  const MypageState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.rooms = const [],
    this.images = const []
  });

  final List<Room> rooms;
  final List<XFile>? images;

  @override
  List<Object?> get props => [...super.props,rooms,images];
}

import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
part 'generated/wish_room_state.g.dart';

@CopyWith()
class WishRoomState extends CommonState {
  const WishRoomState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.roomList = const []
  });

  final List<Room> roomList;
  @override
  List<Object?> get props => [...super.props,roomList];
}
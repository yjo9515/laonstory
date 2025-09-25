import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features.dart';
import '../bloc/room_management_bloc.dart';
import '../bloc/room_state.dart';

class RoomReviewWidget extends StatelessWidget {
  const RoomReviewWidget({Key? key, required this.bloc}) : super(key: key);

  final RoomManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomManagementBloc, RoomManagementState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children:
                    (state.room.reviewList ?? []).map((e) => Container(margin: const EdgeInsets.symmetric(vertical: 8), child: ReviewTile(stretched: true, review: e, room: state.room))).toList(),
              ),
            ),
          );
        });
  }
}

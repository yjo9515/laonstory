import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/room/bloc/wish_room_state.dart';

import '../bloc/wish_room_bloc.dart';

class WishRoomPage extends StatelessWidget {
  const WishRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishRoomListBloc()..add(Initial()),
      child: BlocConsumer<WishRoomListBloc, WishRoomState>(
          listener: (context, state) {
            if(state.status == CommonStatus.failure){
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text(
                        '알림',
                      ),
                      content: Text(
                        state.errorMessage ?? '오류가 발생했습니다. 다시 시도해주세요.',
                      ),
                      actions: <Widget>[
                        adaptiveAction(
                          context: context,
                          onPressed: () => Navigator.pop(context, '확인'),
                          child: const Text('확인'),
                        ),
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: CustomAppBar(backButton: true, textTitle: '내 관심 숙소'),
              body: state.roomList.isEmpty
                  ? SafeArea(
                      child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('최근 본 숙소가 없습니다.',
                                style: context.textTheme.krPoint1
                                    .copyWith(color: white)),
                            const SizedBox(height: 64),
                          ],
                        ),
                      ),
                    ))
                  : SingleChildScrollView(
                      child: Column(
                          children: state.roomList
                              .map(
                                (e) => RoomListWidget(
                                  large: true,
                                  room: e,
                                ),
                              )
                              .toList()),
                    ),
            );
          }),
    );
  }
}

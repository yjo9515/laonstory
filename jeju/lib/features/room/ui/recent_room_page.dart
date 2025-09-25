import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeju_host_app/features/room/bloc/room_state.dart';

import '../../../core/core.dart';
import '../bloc/recent_room_bloc.dart';

class RecentRoomPage extends StatelessWidget {
  const RecentRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RecentRoomBloc()..add(Initial()),
        child: Scaffold(
          appBar: CustomAppBar(backButton: true, textTitle: '최근 본 숙소'),
          body: BlocBuilder<RecentRoomBloc, RecentRoomState>(
              builder: (context, state) {
                if (state.roomList.isEmpty) {
                  return SafeArea(
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
                      ));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                        children: state.roomList
                            .map((e) => RoomListWidget(
                            room: Room(
                                id: e.id,
                                name: e.name,
                                amount: e.amount,
                                oneDayAmount: e.oneDayAmount,
                                days: e.days,
                                imageList: e.imageList,
                                resource: e.resource,
                                minCheckDay: e.minCheckDay,
                                reviewCount: e.reviewCount),
                            large: true))
                            .toList()) ,
                  );
                }
              })
        ));
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/room/repository/room_repository.dart';

import '../../features/room/bloc/wish_room_bloc.dart';
import '../../features/room/bloc/wish_room_state.dart';
import '../core.dart';

class RoomListWidget extends StatelessWidget {
  const RoomListWidget({
    super.key,
    this.room,
    this.large = false,
    this.host = false,
  });

  final Room? room;
  final bool large;
  final bool host;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WishRoomListBloc()..add(Initial()),
        child: BlocConsumer<WishRoomListBloc, WishRoomState>(
            listener: (context, state) {
          if (state.status == CommonStatus.failure) {
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
        }, builder: (context, state) {
          return !host
              ? InkWell(
                  onTap: () {
                    context.pushNamed('room',
                        pathParameters: {'path': 'detail'},
                        queryParameters: {'id': room?.id.toString()});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: large
                        ? Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 240,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: black,
                                      image: room?.imageList != null &&
                                              room!.imageList!.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  '$imageUrl${room?.imageList.first?.path}'),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 16,
                                      right: 16,
                                      child:
                                      // state.roomList.map((e){if(e.id == room?.id){
                                      //   return true;
                                      // }})
                                    state.roomList.any((element) => element.id == room?.id)
                                          ?
                                      InkWell(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Stack(
                                            children: [
                                              Icon(Icons.favorite,
                                                  color: Color.fromARGB(
                                                      255, 230, 76, 206)),
                                              Icon(Icons.favorite_border,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          RoomRepository.to
                                              .deleteRoomLike(room?.id).then((value){
                                                context.read<WishRoomListBloc>().add(Initial());
                                          })
                                              .catchError((e) {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog.adaptive(
                                                    title: const Text(
                                                      '알림',
                                                    ),
                                                    content: Text(
                                                      e.message ??
                                                          '오류가 발생했습니다. 다시 시도해주세요.',
                                                    ),
                                                    actions: <Widget>[
                                                      adaptiveAction(
                                                        context: context,
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, '확인'),
                                                        child: const Text('확인'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          });
                                        },
                                      ):
                                      InkWell(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Stack(
                                            children: [
                                              Icon(Icons.favorite,
                                                  color:gray0.withOpacity(0.5)),
                                              Icon(Icons.favorite_border,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          RoomRepository.to
                                              .postRoomLike(room?.id).then((value){
                                            context.read<WishRoomListBloc>().add(Initial());
                                          })
                                              .catchError((e) {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog.adaptive(
                                                    title: const Text(
                                                      '알림',
                                                    ),
                                                    content: Text(
                                                      e.message ??
                                                          '오류가 발생했습니다. 다시 시도해주세요.',
                                                    ),
                                                    actions: <Widget>[
                                                      adaptiveAction(
                                                        context: context,
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, '확인'),
                                                        child: const Text('확인'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          });
                                        },
                                      )
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${room?.name}',
                                      style: context.textTheme.krSubtitle1),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(numberFormatter((room?.amount ?? 0)),
                                          style: context.textTheme.krSubtitle1),
                                      const SizedBox(width: 8),
                                      Text('${(room?.days ?? 0)} 박',
                                          style: context.textTheme.krBody1
                                              .copyWith(color: black3)),
                                      const Spacer(),
                                      const Icon(Icons.star,
                                          color: pointJeJuYellow, size: 16),
                                      const SizedBox(width: 8),
                                      Text('${(room?.score ?? 0)}',
                                          style: context.textTheme.krBody2
                                              .copyWith(color: black3)),
                                      const SizedBox(width: 8),
                                      Text('(${(room?.reviewCount ?? 0)})',
                                          style: context.textTheme.krBody2
                                              .copyWith(color: black3)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 104,
                                height: 104,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: black,
                                    image: room?.imageList != null &&
                                            room!.imageList!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                '$imageUrl${room?.imageList.first?.path}'),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: NetworkImage(
                                                'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'),
                                            fit: BoxFit.cover,
                                          )),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('#${room?.id}',
                                      style: context.textTheme.krBody1
                                          .copyWith(color: black3)),
                                  const SizedBox(height: 8),
                                  Text('${room?.name}',
                                      style: context.textTheme.krSubtitle1),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                          numberFormatter(
                                              (room?.oneDayAmount ?? 0) *
                                                  (room?.minCheckDay ?? 0)),
                                          style: context.textTheme.krSubtitle1),
                                      const SizedBox(width: 8),
                                      Text('${(room?.minCheckDay ?? 0)} 박',
                                          style: context.textTheme.krBody1
                                              .copyWith(color: black3)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: large
                      ? Column(
                          children: [
                            Container(
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: black,
                                image: room?.imageList != null &&
                                        room!.imageList!.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            '$imageUrl${room?.imageList.first?.path}'),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                            'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${room?.name}',
                                    style: context.textTheme.krSubtitle1),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                        numberFormatter((room?.amount ?? 0) *
                                            (room?.minCheckDay ?? 0)),
                                        style: context.textTheme.krSubtitle1),
                                    const SizedBox(width: 8),
                                    Text('${(room?.minCheckDay ?? 0)} 박',
                                        style: context.textTheme.krBody1
                                            .copyWith(color: black3)),
                                    const Spacer(),
                                    const Icon(Icons.star,
                                        color: pointJeJuYellow, size: 16),
                                    const SizedBox(width: 8),
                                    Text('${(room?.score ?? 0)}',
                                        style: context.textTheme.krBody2
                                            .copyWith(color: black3)),
                                    const SizedBox(width: 8),
                                    Text('(${(room?.reviewCount ?? 0)})',
                                        style: context.textTheme.krBody2
                                            .copyWith(color: black3)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: black,
                                  image: room?.imageList != null &&
                                          room!.imageList!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              '$imageUrl${room?.imageList.first?.path}'),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                              'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'),
                                          fit: BoxFit.cover,
                                        )),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('#${room?.id}',
                                    style: context.textTheme.krBody1
                                        .copyWith(color: black3)),
                                const SizedBox(height: 8),
                                Text('${room?.name}',
                                    style: context.textTheme.krSubtitle1),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                        numberFormatter(
                                            (room?.oneDayAmount ?? 0) *
                                                (room?.minCheckDay ?? 0)),
                                        style: context.textTheme.krSubtitle1),
                                    const SizedBox(width: 8),
                                    Text('${(room?.minCheckDay ?? 0)} 박',
                                        style: context.textTheme.krBody1
                                            .copyWith(color: black3)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                );
        }));
  }
}

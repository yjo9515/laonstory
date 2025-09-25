import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeju_host_app/features/message/bloc/message_detail_bloc.dart';
import 'package:jeju_host_app/features/message/bloc/message_event.dart';
import 'package:jeju_host_app/features/message/bloc/message_state.dart';

import '../../../core/core.dart';

import '../widget/message_tile.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage(
      {Key? key, required this.profile, required this.room, required this.type})
      : super(key: key);

  final Profile profile;
  final Room room;
  final UserType type;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToBottom(scrollController));

    return BlocProvider(
        create: (context) => MessageDetailBloc()
          ..add(Initial(data: {'id': room.id, 'type': type})),
        child: BlocConsumer<MessageDetailBloc, MessageDetailState>(
            listener: (BuildContext context, MessageDetailState state) {
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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(
              textTitle: '메시지',
              backButton: true,
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: profile.profile?.path != null
                                  ? NetworkImage(
                                      '$imageUrl${profile?.profile?.path ?? ''}')
                                  : NetworkImage(
                                      'https://picsum.photos/${Random().nextInt(100) + 200}/${Random().nextInt(100) + 200}'),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${profile.name}',
                                    style: context.textTheme.krBody5,
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${room.name}',
                                      style: context.textTheme.krBody1
                                          .copyWith(color: black3)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                // todo : 숙소보기
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.arrow_forward,
                                      color: black3),
                                  const SizedBox(height: 4),
                                  Text('숙소보기',
                                      style: context.textTheme.krSubtext1
                                          .copyWith(color: black3)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                child: const SafeArea(
                  child: Column(
                    children: [
                      MessageTile(),
                      MessageTile(own: false),
                      MessageTile(),
                      MessageTile(own: false),
                      MessageTile(),
                      MessageTile(own: false),
                      MessageTile(),
                      MessageTile(own: false),
                      MessageTile(),
                      MessageTile(own: false),
                      MessageTile(),
                      MessageTile(own: false),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 210, 215, 221)),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  height: 64,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: '메세지를 입력해주세요...',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 210, 215, 221))),
                        ),
                      ),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined)),
                      IconButton(
                          onPressed: () {
                            context.read<MessageDetailBloc>().add(SendMessage(
                                  accommodationId: room.id!,
                                  content: 'test',
                                  userId: state.profile?.id
                                ));
                          },
                          icon: Icon(Icons.arrow_circle_right_outlined))
                    ],
                  ),
                )),
          );
        }));
  }

  void _scrollToBottom(ScrollController scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeOutCubic);
    } else {
      Timer(const Duration(milliseconds: 400),
          () => _scrollToBottom(scrollController));
    }
  }
}

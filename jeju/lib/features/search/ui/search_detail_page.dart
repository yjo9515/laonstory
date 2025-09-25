import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/room/bloc/room_state.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_state.dart';

class SearchDetailPage extends StatelessWidget {
  const SearchDetailPage({Key? key, this.state}) : super(key: key);

  final List<Room>? state;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://picsum.photos/500/500'), fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          child: AppBar(
                            elevation: 0,
                            leadingWidth: 64,
                            leading: Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: IconButton(
                                    splashRadius: 24,
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      context.pop();
                                    },
                                    icon: const SvgImage('assets/icons/ic_arrow_back.svg'))),
                            centerTitle: true,
                            actions: [Container(margin: const EdgeInsets.only(right: 8), child: IconButton(splashRadius: 24, onPressed: () {}, icon: const SvgImage('assets/icons/ic_share.svg')))],
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 264),
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(color: context.colorScheme.foregroundText.withOpacity(0.8), borderRadius: BorderRadius.circular(13)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text("이리 저리 찾는 중", style: context.textTheme.krButton1),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text("탐색 완료!", style: context.textTheme.krButton1),
                              const SizedBox(height: 20),
                              Text("내가 찾은 숙소중에 고민된다면\n하트 버튼을 눌러 찜하고\n마이페이지에서 비교해보세요!", textAlign: TextAlign.center, style: context.textTheme.krBody1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: TitleText(title: '탐색 결과')),
                        Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text("${state?.length}개 숙소", style: context.textTheme.krBody3.copyWith(color: black3))),
                      ],
                    ),
                    for (final room in state ?? []) RoomListWidget(large: true, room: room),
                    if (state!.isEmpty) Text("검색된 숙소가 없습니다.", textAlign: TextAlign.center, style: context.textTheme.krBody1),
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}

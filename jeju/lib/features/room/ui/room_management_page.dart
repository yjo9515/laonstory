import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';
import '../bloc/room_event.dart';
import '../bloc/room_management_bloc.dart';
import '../bloc/room_state.dart';
import '../widget/room_widget.dart';

class RoomManagementPage extends StatelessWidget {
  const RoomManagementPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        textTitle: '숙소관리',
      ),
      body: RoomManagementPageBody(index: index),
    );
  }
}

class RoomManagementPageBody extends StatelessWidget {
  const RoomManagementPageBody({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final horizontalController = ScrollController();

    final tabs = ['숙소정보', '편의시설', '테마', '리뷰'];
    final tabController =
        TabController(length: tabs.length, vsync: Scaffold.of(context));

    final Map<String, TextEditingController> controllers = {
      'name': TextEditingController(),
      'description': TextEditingController(),
      'additionalPeopleCost': TextEditingController(),
      'price': TextEditingController(),
      'minPrice': TextEditingController(),
      'minDay': TextEditingController(),
      'maxDay': TextEditingController(),
      'square': TextEditingController(),
      'meter': TextEditingController(),
    };

    if (index != 2) {
      return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: white, width: 3),
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                                ),
                              ))),
                      Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                                ),
                              ))),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ],
          ));
    }

    return DefaultTabController(
      length: tabs.length,
      child: BlocProvider(
        create: (context) => RoomManagementBloc()..add(const Initial()),
        child:
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              BlocConsumer<RoomManagementBloc, RoomManagementState>(
                listenWhen: (previous, current) =>
                    previous.room != current.room ||
                    previous.status != current.status,
                listener: (context, state) {
                  switch (state.status) {
                    case CommonStatus.initial:
                      controllers['name']!.text = state.room.name ?? '';
                      controllers['description']!.text =
                          state.room.description ?? '';
                      controllers['additionalPeopleCost']!.text =
                          state.room.additionalPeopleCost?.toString() ?? '';
                      controllers['price']!.text =
                          state.room.oneDayAmount?.toString() ?? '';
                      controllers['minPrice']!.text =
                          ((state.room.oneDayAmount ?? 0) *
                                  (state.room.minCheckDay ?? 0))
                              .toString();
                      controllers['square']!.text =
                          state.room.squareFeet?.toString() ?? '';
                      controllers['meter']!.text =
                          ((state.room.squareFeet ?? 0) * 3.305785).toString();
                      controllers['minDay']!.text =
                          state.room.minCheckDay?.toString() ?? '';
                      controllers['maxDay']!.text =
                          state.room.maxCheckDay?.toString() ?? '';
                      break;
                    case CommonStatus.success:
                      showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: const Text(
                                '알림',
                              ),
                              content: const Text(
                                '저장되었습니다.',
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
                      break;
                    case CommonStatus.failure:
                      showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: const Text(
                                '알림',
                              ),
                              content: Text(
                                state.errorMessage ?? '',
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
                      break;
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  if (state.rooms.isEmpty) {
                    return SliverToBoxAdapter();
                  } else {
                    return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: horizontalController
                              ..addListener(() => onScroll(
                                  controller: horizontalController,
                                  edge: true,
                                  onDone: () {
                                    context
                                        .read<RoomManagementBloc>()
                                        .add(const PageNate());
                                  })),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: state.rooms
                                    .asMap()
                                    .entries
                                    .map((e) => InkWell(
                                        onTap: () {
                                          context
                                              .read<RoomManagementBloc>()
                                              .add(ChangePickRoom(
                                                  room: e.value));
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${e.value.imageList.isNotEmpty ? e.value.imageList.first.path : ''}",
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: 80,
                                            height: 80,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                if (e.value == state.room)
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                              ],
                                              border: Border.all(
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: white,
                                                  width: e.value == state.room
                                                      ? 5
                                                      : 0),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                                                ),
                                              ),
                                            ),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 80,
                                            height: 80,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                if (e.value == state.room)
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                              ],
                                              border: Border.all(
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: white,
                                                  width: e.value == state.room
                                                      ? 5
                                                      : 0),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image:
                                                  e.value.imageList.isNotEmpty
                                                      ? DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                                                          ),
                                                        ),
                                            ),
                                          ),
                                        )))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        TitleText(title: state.room.name ?? ''),
                      ],
                    ),
                  );}
                },
              ),
            ];
          },
          body: BlocBuilder<RoomManagementBloc, RoomManagementState>(
            builder: (context, state) {
              if (state.rooms.isEmpty) {
                return SafeArea(child: Container(
                  decoration: BoxDecoration(
                    image:
                    DecorationImage(image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'), fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('등록된 숙소가 없습니다.', style: context.textTheme.krPoint1.copyWith(color: white)),
                        const SizedBox(height: 64),
                        Text('숙소를 먼저 등록해주세요.', style: context.textTheme.krBody4.copyWith(color: white)),
                      ],
                    ),
                  ),
                ));
              }else{
                return SafeArea(
                  child: Column(
                    children: [
                      TabBar(
                          onTap: (value) {
                            context.read<RoomManagementBloc>().add(ChangeTab());
                          },
                          controller: tabController,
                          indicator: const UnderlineTabIndicator(
                              borderSide:
                              BorderSide(width: 2.0, color: mainJeJuBlue),
                              insets: EdgeInsets.symmetric(horizontal: 0.0)),
                          tabs: tabs
                              .map((e) => Tab(
                              height: 56,
                              child: Center(
                                child:
                                Text(e, style: context.textTheme.krBody3),
                              )))
                              .toList()),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            RoomInfoWidget(
                              bloc: context.read<RoomManagementBloc>(),
                              controllers: controllers,
                            ),
                            RoomFacilitiesWidget(bloc: context.read<RoomManagementBloc>()),
                            RoomThemesWidget(
                                bloc: context.read<RoomManagementBloc>()),
                            RoomReviewWidget(
                                bloc: context.read<RoomManagementBloc>()),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

            },
          ),
        ),
      ),
    );
  }
}

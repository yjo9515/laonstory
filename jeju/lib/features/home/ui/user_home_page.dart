import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/home_bloc.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return BlocProvider(
      create: (context) => HomeBloc()..add(Initial()),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined))],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case CommonStatus.route:
                context.pushNamed(state.route?.split('/')[1] ?? '', pathParameters: {'path': state.route?.split('/')[2] ?? ''}, queryParameters: {'query': state.query});
                break;
              case CommonStatus.failure :
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
              default:
                break;
            }
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => previous.query != current.query,
                    builder: (context, state) {
                      return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputWidget(
                          controller: _controller,
                          hint: '원하는 공간을 찾아볼까요?',
                          onFieldSubmitted: (value) => context.read<HomeBloc>().add(Search(query: _controller.text)),
                          hintStyle: context.textTheme.krBody4.copyWith(color: black4),
                          suffixWidget: IconButton(onPressed: () => context.read<HomeBloc>().add(Search(query: _controller.text)), icon: const Icon(Icons.search)),
                        ),
                      );
                    },
                  ),
                  Image.asset('assets/images/example.png'),
                  // const TitleText(title: '나와 비슷한 유저들이 예약했어요'),
                  // SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       children: List.generate(
                  //         10,
                  //         (index) => const RoomMinimalWidget(
                  //           room: Room(name: '[서귀포] Premier In', oneDayAmount: 8000000, disCountPercent: 30),
                  //         ),
                  //       )
                  //         ..insert(0, const SizedBox(width: 16))
                  //         ..add(const SizedBox(width: 16)),
                  //     )),
                  const TitleText(title: '테마 선택', go: true),
                  BlocBuilder<HomeBloc, HomeState>(

                    builder: (context, state){
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        height: 400,
                        width: double.infinity,
                        child: CarouselSlider(
                            items: List.generate(
                              state.themes['테마']?.length ?? 0,
                                  (index) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff01021A).withOpacity(0.21),
                                      blurRadius: 11,
                                      offset: const Offset(2, 3),
                                    ),
                                  ],
                                  image: DecorationImage(image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'), fit: BoxFit.cover),
                                ),
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(color: black.withOpacity(0.6), borderRadius: BorderRadius.circular(16)),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          child: Text(
                                            '32 방',
                                            style: context.textTheme.krBody4.copyWith(color: white),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Text('채광이 다했다🌞\n모두 모여 햇빛 빔', style: context.textTheme.krPoint1.copyWith(color: white)),
                                        Text('${state.themes['테마']?[index].name}', style: context.textTheme.krPoint1.copyWith(color: white)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            options: CarouselOptions(
                              aspectRatio: 248 / 372,
                              viewportFraction: 0.6,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            )),
                      );
                    },
                  ),

                  BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state){
                    return Column(
                      children: [
                        state.newRooms.isNotEmpty && state.newRooms != []?
                        TitleText(title: '이 달의 신규 숙소 🎉', go: true) : Container(),
                        Column(
                            children: state.newRooms.map((e) =>
                                RoomListWidget(room: Room(id: e.id, name: e.name, amount: e.amount, oneDayAmount: e.oneDayAmount,resource: e.resource, minCheckDay: e.minCheckDay, reviewCount: e.reviewCount, imageList: e.imageList, days: e.days), large: true)
                            ).toList()
                        )
                      ],
                    );
                  }),
                  const SizedBox(height: 24),
                  LargeButton(text: '나도 호스트되기  >', onTap: () => context.push('/guide/host'),),
                  const SizedBox(height: 24),
                  BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state){
                        return Column(
                          children: [
                            state.pickRooms.isNotEmpty && state.pickRooms != [] ?
                            TitleText(title: '제주살이가 Pick! 추천 숙소', go: true) : Container(),
                            Column(
                                children: state.pickRooms.map((e) =>
                                    RoomListWidget(room: Room(id: e.id, name: e.name, oneDayAmount: e.oneDayAmount,resource: e.resource, minCheckDay: e.minCheckDay, reviewCount: e.reviewCount, imageList: e.imageList, days: e.days), large: true)
                                ).toList()
                            )
                          ],
                        );
                      }),
                  InkWell(
                    child: Text('dddd'),
                    onTap: (){
                      context.push('/reservation/review',extra: Room());
                    },
                  ),
                  const SizedBox(height: 40),
                  const CopyRightWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

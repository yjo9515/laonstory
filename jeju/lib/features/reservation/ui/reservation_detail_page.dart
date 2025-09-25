import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../room/widget/info_widget.dart';
import '../../room/widget/room_image.dart';
import '../bloc/reservation_detail_bloc.dart';
import '../bloc/reservation_state.dart';

class ReservationDetailPage extends StatelessWidget {
  ReservationDetailPage({super.key, required this.id});
  final String id;
  var showMoreText = false;
  var showMoreIcon = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationDetailBloc()..add(Initial(id: id)),
      child: BlocConsumer<ReservationDetailBloc, ReservationDetailState>(
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
          } else if (state.status == CommonStatus.success) {}
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colorScheme.background,
            appBar: const CustomAppBar(
              tag: 'add_room',
              backButton: true,
              textTitle: '숙소 예약 상세',
              actions: [],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: 272,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                              child: Hero(
                                tag: 'roomImage',
                                child: CarouselSlider(
                                    items: state.room.imageList != null
                                        ? state.room.imageList
                                            ?.map((e) => Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${imageUrl}${e.path}'),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ))
                                            .toList()
                                        : state.room?.imageList.isEmpty ?? true
                                            ? [
                                                CachedNetworkImage(
                                                    imageUrl:
                                                        'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}',
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        height: 500,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: white,
                                                        ),
                                                      );
                                                    }),
                                                CachedNetworkImage(
                                                    imageUrl:
                                                        'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}',
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        height: 500,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: white,
                                                        ),
                                                      );
                                                    }),
                                              ]
                                            : state.room?.imageList
                                                .map((e) => CachedNetworkImage(
                                                    imageUrl:
                                                        '$imageUrl${e.path}',
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        height: 500,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: white,
                                                        ),
                                                      );
                                                    }))
                                                .toList(),
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      aspectRatio: 38 / 24,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: false,
                                      scrollDirection: Axis.horizontal,
                                    )),
                              ),
                            )),
                        // InfoWidget(room: state.room),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      '${state.room.name}',
                                      style: context.textTheme.krPoint1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(Icons.star,
                                            color: pointJeJuYellow, size: 16),
                                        const SizedBox(width: 8),
                                        Text(
                                            '${state.room?.score ?? 0} (${state.room?.reviewCount ?? 0})',
                                            style: context.textTheme.krBody1
                                                .copyWith(color: black3)),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 20),
                                Row(
                                  children: (state.room?.theme ?? [])
                                      .map(
                                        (e) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ThemeWidget(
                                                theme: e.name ?? '')),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const TitleText(title: "예약 상세 정보"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('게스트',
                                          style: context.textTheme.krBody3)),
                                  Text('${state.reservation.people}명',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('예약번호',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                        '${state.reservation.orderNumber}',
                                        style: context.textTheme.krBody3),
                                  )
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('숙박기간',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                      '${dateParserDate(state.reservation.startDate, format: 'yyyy.MM.dd (E)')} ~ ${dateParserDate(state.reservation.endDate, format: 'yyyy.MM.dd (E)')}',
                                      style: context.textTheme.krBody3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('숙박일 수',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                      '${state.reservation.days}박 ${(state.reservation.days ?? 0) + 1}일',
                                      style: context.textTheme.krBody3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('결제 금액',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                      numberFormatter(
                                          state.reservation.totalAmount),
                                      style: context.textTheme.krBody3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const TitleText(title: "숙소 정보"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('체크인',
                                          style: context.textTheme.krBody3)),
                                  Text('${timeAParser(state.room.checkIn)}부터',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('체크아웃',
                                          style: context.textTheme.krBody3)),
                                  Text('${timeAParser(state.room.checkOut)}까지',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('숙박가능인원',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                      '${state.room.standardPeople}명',
                                      style: context.textTheme.krBody3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 108,
                                      child: Text('숙박최대인원',
                                          style: context.textTheme.krBody3)),
                                  Expanded(
                                    child: Text(
                                      '${state.room.maximumPeople}명',
                                      style: context.textTheme.krBody3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const TitleText(title: "숙소 편의시설"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: showMoreIcon
                                        ? null
                                        : (state.room?.facility.length ?? 0) >
                                                10
                                            ? 280
                                            : null,
                                    child: GridView.count(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      childAspectRatio: 4,
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      children:
                                          state.room!.facility.map((element) {
                                        return SizedBox(
                                          height: 24,
                                          child: Row(children: [
                                            //todo 이미지
                                            const SizedBox(width: 8),
                                            Text(
                                              '${element.name}',
                                              style: context.textTheme.krBody3,
                                            )
                                          ]),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  if ((state.room?.facility.length ?? 0) > 10 &&
                                      !showMoreIcon)
                                    Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white.withOpacity(0),
                                              Colors.white.withOpacity(0.8),
                                              Colors.white.withOpacity(0.95),
                                            ],
                                          ),
                                        ),
                                        height: 48),
                                ],
                              ),
                              if ((state.room?.facility.length ?? 0) > 10 &&
                                  !showMoreIcon)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: LargeButton(
                                    margin: EdgeInsets.zero,
                                    onTap: () {
                                      showMoreIcon = true;
                                    },
                                    color: white,
                                    centerWidget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '더보기',
                                          style: context.textTheme.krButton1,
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.keyboard_arrow_down)
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        const TitleText(title: "숙소 주소"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('${state.room.address?.address ?? ''}${state.room.address?.addressDetail ?? ''}',
                              style: context.textTheme.krBody3,
                              textAlign: TextAlign.left,

                            ),
                          )
                        ),
                        const TitleText(title: "호스트 번호"),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(state.dto.phone ?? state.dto?.subPhone ?? '',
                                style: context.textTheme.krBody3,
                                textAlign: TextAlign.left,

                              ),
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: LargeButton(
                        color: Colors.black,
                        onTap: () {
                          context.push('/reservation/cancel/$id');
                        },
                        text: '예약 취소',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

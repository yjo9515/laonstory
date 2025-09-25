import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/home/bloc/host_room_list_bloc.dart';
import 'package:jeju_host_app/features/room/bloc/add_room_bloc.dart';
import 'package:jeju_host_app/features/room/bloc/room_list_bloc.dart';

import '../../../core/core.dart';
import '../../global/bloc/global_bloc.dart';
import '../../room/bloc/room_state.dart';

class HostHomePage extends StatelessWidget {
  const HostHomePage({Key? key, required this.onReservation, required this.onMyRoom}) : super(key: key);

  final Function() onReservation;
  final Function() onMyRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widgetTitle: const SvgImage('assets/icons/ic_logo_horizontal.svg'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: context.colorScheme.iconColor),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Image.asset('assets/images/example.png'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: mainJeJuBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                        onTap: () {
                          final hostStatus = HostStatus.strToEnum(state.profile?.status);
                          switch (hostStatus) {
                            case HostStatus.WAITING:
                              context.push('/signup/host/1');
                              break;
                            default:
                              context.pushNamed('room', pathParameters: {'path': 'add'}, queryParameters: {'step': '1'});
                              break;
                          }

                        },
                        child: Center(child: Text('숙소 등록하기 +', style: context.textTheme.krButton1.copyWith(color: white)))),
                  ),
                  InkWell(
                      onTap: () {
                        context.push('/setting/notice');
                      },
                      child: const ListTitleButton(title: '호스트 공지사항')),
                  const ListTextButton(text: '제주살이 업데이트 안내', date: '2023-10-16T12:00'),
                  const ListTextButton(text: '제주살이 업데이트 안내', date: '2023-10-16T12:00'),
                  const ListTextButton(text: '제주살이 업데이트 안내', date: '2023-10-16T12:00'),
                 BlocProvider(
                create: (context) => HostRoomListBloc()..add(Initial()),
                  child:BlocConsumer<HostRoomListBloc,HostRoomListState>(
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
                      },
                      builder: (context,state){
                        return Column(
                          children: [
                            InkWell(
                              onTap: onReservation,
                              child: ListTitleButton(
                                title: '예약 확인',
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: '현재 예약 ',
                                    style: context.textTheme.krBody3.copyWith(color: black3),
                                    children: <TextSpan>[
                                      TextSpan(text: '${state.reservations.length}', style: context.textTheme.krBody3.copyWith(color: mainJeJuBlue)),
                                      TextSpan(text: '건', style: context.textTheme.krBody3.copyWith(color: black3)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            state.reservations == [] || state.reservations == null ?
                            Text('예약된 숙소가 없습니다.')
                                :
                            Column(
                              children: state.reservations
                                  .map(
                                      (r) => ListTextButton(text: r.name ?? '예약명', date: r.createdAt.toString())
                              )
                                  .toList(),
                            ),
                            InkWell(
                              onTap: onMyRoom,
                              child: ListTitleButton(
                                title: '등록한 숙소',
                                subtitle:
                                state.rooms == [] || state.rooms == null ?
                                Text('')
                                :RichText(
                                  text: TextSpan(
                                    text: '현재 등록 숙소 ',
                                    style: context.textTheme.krBody3.copyWith(color: black3),
                                    children: <TextSpan>[
                                      TextSpan(text: '${state.rooms.length}', style: context.textTheme.krBody3.copyWith(color: mainJeJuBlue)),
                                      TextSpan(text: '건', style: context.textTheme.krBody3.copyWith(color: black3)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            state.rooms == [] || state.rooms == null ?
                            Text('숙소를 등록해주세요'):
                            Column(
                              children: state.rooms
                                  .map(
                                    (room) => InkWell(
                                        onTap: onMyRoom,
                                        child:RoomListWidget(
                                        host:true,
                                        room: Room(id: room.id, name: room.name, oneDayAmount: room.oneDayAmount, minCheckDay: room.minCheckDay,imageList: room.imageList)))
                              )
                                  .toList(),
                            )
                          ],
                        );
                      }
                  ),),
                  const SizedBox(height: 80),
                  Image.asset('assets/images/host_home_text.png', height: 74),
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                            border: Border.all(color: black5),
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: CarouselSlider(
                              items: const [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgImage('assets/images/host_guide_4.svg'),
                                    SizedBox(height: 16),
                                    SvgImage('assets/images/host_home_guide_1.svg'),
                                  ],
                                ),
                              ],
                              options: CarouselOptions(
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: false,
                                scrollDirection: Axis.horizontal,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back_ios, color: black5),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, color: black5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      '임대나 분양에 대해 정확한 정보가 필요하신 분들은 하단의 분양의 신 임대/분양문의를 통해 여러가지 정보를 확인하실 수 있습니다.',
                      style: context.textTheme.krBody1.copyWith(color: const Color(0xffAAB0B6), fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                      border: Border.all(color: black5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: '모두의 분양 ',
                          style: context.textTheme.krButton1.copyWith(color: black3),
                          children: <TextSpan>[
                            TextSpan(text: '임대/분양 문의 >', style: context.textTheme.krBody5.copyWith(color: black3, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

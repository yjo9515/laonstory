import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_management_bloc.dart';
import '../bloc/reservation_state.dart';
import '../widget/day_item_widget.dart';
import '../widget/event_widget.dart';
import '../widget/week_days_widget.dart';

class ReservationManagementPage extends StatelessWidget {
  ReservationManagementPage({Key? key, required this.index}) : super(key: key);

  final int index;

  final horizontalController = ScrollController();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        textTitle: '예약관리',
      ),
      body: SafeArea(
        child: index != 1
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
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
                                    offset: const Offset(0, 4), // changes position of shadow
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
                                    offset: const Offset(0, 4), // changes position of shadow
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
                ))
            : BlocProvider(
                create: (context) => ReservationManagementBloc()..add(const Initial()),
                child:BlocConsumer<ReservationManagementBloc, ReservationManagementState>(
                  listenWhen: (previous, current) => previous.room != current.room || previous.status != current.status,
                  listener: (context, state) {
                    switch (state.status) {
                      case CommonStatus.initial:
                        controllers['name']!.text = state.room.name ?? '';
                        controllers['description']!.text = state.room.description ?? '';
                        controllers['additionalPeopleCost']!.text = state.room.additionalPeopleCost?.toString() ?? '';
                        controllers['price']!.text = state.room.oneDayAmount?.toString() ?? '';
                        controllers['minPrice']!.text = ((state.room.oneDayAmount ?? 0) * (state.room.minCheckDay ?? 0)).toString();
                        controllers['square']!.text = state.room.squareFeet?.toString() ?? '';
                        controllers['meter']!.text = ((state.room.squareFeet ?? 0) * 3.305785).toString();
                        controllers['minDay']!.text = state.room.minCheckDay?.toString() ?? '';
                        controllers['maxDay']!.text = state.room.maxCheckDay?.toString() ?? '';
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
                    // }else if (state.reservationList.isEmpty){
                    //   return SafeArea(child: Container(
                    //     decoration: BoxDecoration(
                    //       image:
                    //       DecorationImage(image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'), fit: BoxFit.cover),
                    //     ),
                    //     child: Center(
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text('등록된 예약이 없습니다.', style: context.textTheme.krPoint1.copyWith(color: white)),
                    //           const SizedBox(height: 64),
                    //         ],
                    //       ),
                    //     ),
                    //   ));
                    }else{
                      return SingleChildScrollView(
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
                                        context.read<ReservationManagementBloc>().add(const PageNate());
                                      })),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: state.rooms
                                        .asMap()
                                        .entries
                                        .map((e) => InkWell(
                                        onTap: () {
                                          context.read<ReservationManagementBloc>().add(ChangePickRoom(room: e.value));
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:

                                          e.value.imageList.first.path!.isNotEmpty || e.value.imageList.first.path!.isNotEmpty?"$imageUrl${e.value.imageList.first.path}"
                                              :
                                          'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'
                                          ,
                                          errorWidget: (context, url, error) => Container(
                                            width: 80,
                                            height: 80,
                                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                if (e.value == state.room)
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 4), // changes position of shadow
                                                  ),
                                              ],
                                              border: Border.all(strokeAlign: BorderSide.strokeAlignOutside, color: white, width: e.value == state.room ? 5 : 0),
                                              borderRadius: BorderRadius.circular(16),
                                              image:
                                              e.value.imageList != null &&  e.value.imageList != [] && e.value.imageList.isNotEmpty?
                                              DecorationImage(
                                                image: NetworkImage('$imageUrl${e.value?.imageList.first.path}'),
                                                fit: BoxFit.cover,
                                              )
                                                  :
                                              DecorationImage(
                                                image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 80,
                                            height: 80,
                                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                if (e.value == state.room)
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 4), // changes position of shadow
                                                  ),
                                              ],
                                              border: Border.all(strokeAlign: BorderSide.strokeAlignOutside, color: white, width: e.value == state.room ? 5 : 0),
                                              borderRadius: BorderRadius.circular(16),
                                              image: e.value.imageList.isNotEmpty
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
                            BlocBuilder<ReservationManagementBloc, ReservationManagementState>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const SvgImage('assets/icons/ic_arrow_left.svg'),
                                        onPressed: () => context.read<ReservationManagementBloc>().add(const SwipeDate(true)),
                                      ),
                                      Row(
                                        children: [
                                          Text('${state.calendarDate?.year ?? DateTime.now().year}/${state.calendarDate?.month ?? DateTime.now().month}', style: context.textTheme.krSubtitle1),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const SvgImage('assets/icons/ic_arrow_right.svg'),
                                        onPressed: () => context.read<ReservationManagementBloc>().add(const SwipeDate(false)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            BlocConsumer<ReservationManagementBloc, ReservationManagementState>(
                              listenWhen: (previous, current) => previous.status != current.status,
                              builder: (context, state) {
                                return SizedBox(
                                  height: 560,
                                  child: CrCalendar(
                                    forceSixWeek: true,
                                    eventsTopPadding: 0,
                                    touchMode: TouchMode.singleTap,
                                    maxEventLines: 4,
                                    initialDate: DateTime.now(),
                                    controller: state.calendarController ?? CrCalendarController(),
                                    dayItemBuilder: (builderArgument){
                                      return DayItemWidget(
                                        calendarDate: state.calendarController?.date ?? DateTime.now(),
                                        properties: builderArgument,
                                        disabledDate: state.disabledDate,
                                        dateAmount: state.dateManagement,
                                        onSelected: (date) {
                                          logger.d(date);
                                          logger.d(state.events);
                                          List<DateTime> datesInRange = [];
                                          for(int i = 1; i<state.events.length; i++){
                                            for (DateTime? date = state.events['$i']?.model.begin; date!.isBefore(state.events['$i']!.model.end) || date!.isAtSameMomentAs(state.events['$i']!.model.end); date = date.add(Duration(days: 1))) {
                                              datesInRange.add(date!);
                                            }
                                          }
                                          if(datesInRange.contains(date)){
                                            for(var r in state.reservationList){
                                              if(datesInRange.contains(r.startDate)){
                                                context.push('/reservation/host',extra: r);
                                                break;
                                              }
                                            }
                                          }else{
                                            context.push('/reservation/host/management',extra: {'date' : date, 'id' : state.room.id});
                                          }
                                        },
                                      );
                                    },
                                    weekDaysBuilder: (builderArgument) => WeekDaysWidget(day: builderArgument),
                                    eventBuilder: (builderArgument) => EventWidget(drawer: builderArgument, events: state.events, controller:state.calendarController ?? CrCalendarController()),
                                    firstDayOfWeek: WeekDay.sunday,
                                  ),
                                );
                              }, listener: (BuildContext context, ReservationManagementState state) {  },
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: mainJeJuBlue),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '예약완료',
                                    style: context.textTheme.krBody1.copyWith(color: black3),
                                  ),
                                  const SizedBox(width: 24),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: const SvgImage('assets/icons/ic_disable_date.svg'),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '호스팅 중지',
                                    style: context.textTheme.krBody1.copyWith(color: black3),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('•  ', style: context.textTheme.krBody3.copyWith(color: black3)),
                                      Expanded(
                                        child: AutoSizeText.rich(
                                          TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text: '일일 가격 책정을 원하시는 분들은 날짜를 선택하고 하단에 일일 가격 책정 버튼을 누르고 가격을 설정해주세요.',
                                                style: context.textTheme.krBody3.copyWith(color: black3),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                          style: context.textTheme.krBody1.copyWith(color: const Color(0xff7B878D)),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('•  ', style: context.textTheme.krBody3.copyWith(color: black3)),
                                      Expanded(
                                        child: AutoSizeText.rich(
                                          TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text: '호스팅 가능여부를 설정하시려면 날짜를 선택하고 호스팅가능 여부를 설정해주세요.',
                                                style: context.textTheme.krBody3.copyWith(color: black3),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                          style: context.textTheme.krBody1.copyWith(color: const Color(0xff7B878D)),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
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

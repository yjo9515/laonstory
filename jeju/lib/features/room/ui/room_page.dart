import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../bloc/room_detail_bloc.dart';
import '../bloc/room_event.dart';
import '../bloc/room_state.dart';
import '../widget/room_widget.dart';

final calenderKey = GlobalKey();

class
RoomPage extends StatelessWidget {
  const RoomPage({super.key, this.id});

  final String? id;
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return BlocProvider(
      create: (context) => RoomDetailBloc()..add(Initial(id: id!)),
      child: BlocListener<RoomDetailBloc, RoomDetailState>(
        listenWhen: (previous, current) => (previous.zoomImage != current.zoomImage) || (previous.status != current.status),
        listener: (context, state) {
          // if (state.RoomDetailBloc) {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           fullscreenDialog: true,
          //           builder: (BuildContext ctx) {
          //             return Scaffold(
          //               backgroundColor: black,
          //               body: SafeArea(
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       margin: const EdgeInsets.only(right: 16),
          //                       alignment: Alignment.centerRight,
          //                       child: InkWell(
          //                         onTap: () {
          //                           context.read<RoomDetailBloc>().add(const ZoomImage(false));
          //                           Navigator.pop(context);
          //                         },
          //                         child: const Icon(Icons.close, color: white),
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Hero(
          //                         tag: 'roomImage',
          //                         child: CachedNetworkImage(
          //                             imageUrl: 'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}',
          //                             fit: BoxFit.contain,
          //                             errorWidget: (context, url, error) {
          //                               return Container(
          //                                 decoration: const BoxDecoration(
          //                                   color: white,
          //                                 ),
          //                               );
          //                             }),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           }));
          //   scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          // }
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
        child: Scaffold(
            body: BlocBuilder<RoomDetailBloc, RoomDetailState>(

          builder: (context, state) {
            if(state.status == CommonStatus.success){
              return RoomDetailWidget(
                host:state.hostProfile,
                room: state.room,
                stopHosting:state.stopHosting,
                plusPrice:state.plusPriceList,
                scrollController: scrollController
                  ..addListener(() {
                    if (!state.zoomImage && scrollController.position.pixels < -200) {
                      context.read<RoomDetailBloc>().add(const ZoomImage(true));
                    }
                    context.read<RoomDetailBloc>().add(const ShowPrice(false));
                  }),
                calenderKey: calenderKey,
                calenderDate: state.calenderDate,

                onDateRangeChanged: (value) {
                  // if(value?.start == value?.end){
                  //   context.read<RoomDetailBloc>().add( Error(LogicalException(message: '당일치기는 지원하지않습니다.')));
                  // }else{
                  context.read<RoomDetailBloc>().add(const ShowPrice(true));
                  Scrollable.ensureVisible(calenderKey.currentContext!, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut, alignment: 0);
                  context.read<RoomDetailBloc>().add(ChangeDateRange(value));
                  // }

                },
              );
            }else{
              return Container();
            }

          },
        ), bottomSheet: BlocBuilder<RoomDetailBloc, RoomDetailState>(
          builder: (context, state) {
            return GestureDetector(
              onPanUpdate: (details) {
                context.read<RoomDetailBloc>().add(ShowPrice(details.delta.dy.isNegative));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: black5, borderRadius: BorderRadius.circular(23)),
                      height: 6,
                      width: 104,
                    ),
                    const SizedBox(height: 16),
                    AnimatedContainer(
                      curve: Curves.easeInOut,
                      height: state.showPrice && state.dateSelected ? 420 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                height: 48,
                                decoration: BoxDecoration(
                                  border: Border.all(color: black6),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(child: Text('${dateParserDate(state.dateRange?.start)} 부터', style: context.textTheme.krBody4))),
                            const SizedBox(height: 16),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                height: 48,
                                decoration: BoxDecoration(
                                  border: Border.all(color: black6),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(child: Text('${dateParserDate(state.dateRange?.end)} 까지', style: context.textTheme.krBody4))),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              width: MediaQuery.of(context).size.width,
                              child:
                              DropdownMenuWidget<String>(
                                filled: false,
                                centerTitle: true,
                                alignment: Alignment.center,
                                dropdownList:state.guestList,
                                TextAlignment: Alignment.center,
                                onChanged: (value) {
                                    context.read<RoomDetailBloc>().add(ChangeGuest(guestCount:int.parse(value!.replaceAll('명', ''))));
                                },
                                hint: '인원을 선택해주세요.',
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                      '${numberFormatter(state.room.oneDayAmount ?? 0)} x ${state.normalDay == null ? 0 : (state.normalDay)}박',
                                      style: context.textTheme.krBody3),
                                  const Spacer(),
                                  Text(
                                      '${
                                          numberFormatter((state.room.oneDayAmount ?? 0) * (state.dateRange == null ? 0 : (state.normalDay)))
                                      } 원',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text('특정 날짜 가격', style: context.textTheme.krBody3),
                                  const Spacer(),
                                  Text(
                                      '총 ${
                                      numberFormatter(state.plusPrice)
                                      } 원',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            (state.room.isAdditionalPeople == true && state.guestCount! - state.room.standardPeople! > -1 )?
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                      '추가인원 비용',
                                      style: context.textTheme.krBody3),
                                  const Spacer(),
                                  Text(
                                      '총 ${numberFormatter((state.room.additionalPeopleCost ?? 0) * (state.guestCount - state.room.standardPeople!))} 원',
                                      style: context.textTheme.krBody3),
                                ],
                              ),
                            ):
                            Container()
                            ,
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text('장기숙박 할인', style: context.textTheme.krBody3),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: mainJeJuBlue,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: Text('장기할인 1%', style: context.textTheme.krSubtext1.copyWith(color: white)),
                                  ),
                                  const SizedBox(width: 8),
                                  (state.room.isAdditionalPeople == true  && (state.guestCount - state.room.standardPeople! > -1))?
                                  Text(
                                      '- ${numberFormatter((((state.room.oneDayAmount ?? 0 ) * state.normalDay + state.plusPrice +((state.room.additionalPeopleCost ?? 0) * (state.guestCount - state.room.standardPeople!)))* 0.01).toInt())}원',
                                      style: context.textTheme.krBody4.copyWith(color: black4)):
                                  Text(
                                      '- ${numberFormatter((((state.room.oneDayAmount ?? 0 ) * state.normalDay + state.plusPrice)* 0.01).toInt())}원',
                                      style: context.textTheme.krBody4.copyWith(color: black4)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text('총 합계', style: context.textTheme.krBody3),
                                  const Spacer(),
                                  // Text('${state.guestCount - state.room.standardPeople!}'),
                                  // Text('${state.room.standardPeople! - state.room.maximumPeople!}'),
                                  // Text('${state.room.additionalPeopleCost! * (state.guestCount - state.room.standardPeople!) * 0.01}'),
                                  // Text('${(state.room.oneDayAmount ?? 0 ) * state.normalDay}'),
                                  // Text('${state.plusPrice}'),
                                  // Text('${(((state.room.oneDayAmount??0 ) * state.normalDay + state.plusPrice)* 0.01).toInt()}'),
                                  (state.room.isAdditionalPeople == true  && (state.guestCount - state.room.standardPeople! > -1))?
                                  Text(
                                      '${numberFormatter(((state.room.oneDayAmount ?? 0 ) * state.normalDay) + state.plusPrice + state.room.additionalPeopleCost! * (state.guestCount - state.room.standardPeople!) - (((state.room.oneDayAmount??0 ) * state.normalDay + state.plusPrice +(state.room.additionalPeopleCost! * (state.guestCount - state.room.standardPeople!)))* 0.01).toInt())} 원',
                                      style: context.textTheme.krPoint1):
                                  Text(
                                      '${numberFormatter(((state.room.oneDayAmount ?? 0 ) * state.normalDay) + state.plusPrice - ((((state.room.oneDayAmount??0 ) * state.normalDay + state.plusPrice)* 0.01).toInt()))} 원',
                                      style: context.textTheme.krPoint1)

                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    LargeButton(
                      margin: EdgeInsets.zero,
                      text: '예약하기',
                      onTap: () {
                        if (!state.showPrice) {
                          context.read<RoomDetailBloc>().add(const ShowPrice(true));
                        } else {
                          if (state.dateRange?.start != null && state.dateRange?.end != null) {
                            if(state.dateRange!.end.difference(state.dateRange!.start).inDays + 1 > state.room!.maxCheckDay! ){
                              context.read<RoomDetailBloc>().add( Error(LogicalException(message: '숙박이 가능한 최대 일수는 ${state.room!.maxCheckDay}일 입니다.')));
                            }else{
                            if(state.dateRange!.end.difference(state.dateRange!.start).inDays + 1 < state.room!.minCheckDay! ){
                              context.read<RoomDetailBloc>().add( Error(LogicalException(message: '숙박이 가능한 최소 일수는 ${state.room!.minCheckDay}일 입니다.')));
                            }else{
                              if(state.guestCount < state.room!.standardPeople! ){
                              context.read<RoomDetailBloc>().add( Error(LogicalException(message: '숙박이 가능한 최소 인원는 ${state.room!.standardPeople}명 입니다.')));
                              }else{
                                if(state.dateRange?.start == state.dateRange?.end){
                                  context.read<RoomDetailBloc>().add( Error(LogicalException(message: '당일치기는 지원하지않습니다.')));
                                }else{
                                  if(state.room.isAdditionalPeople == true && state.guestCount - state.room.standardPeople! > -1){
                                    context.push('/reservation', extra: {'room': state.room,'dateRange': state.dateRange, 'guestCount': state.guestCount, 'guestPlus' : (state.room.additionalPeopleCost ?? 0) * (state.guestCount - state.room.standardPeople!),
                                    'totalAmount' : ((state.room.oneDayAmount ?? 0) *
                                    state.normalDay) + state.plusPrice +
                                    state.room.additionalPeopleCost! *
                                    (state.guestCount -
                                    state.room.standardPeople!) -
                                    (((state.room.oneDayAmount ?? 0) *
                                    state.normalDay +
                                    state.plusPrice + (state.room
                                        .additionalPeopleCost! *
                                    (state.guestCount - state.room
                                        .standardPeople!))) * 0.01)
                                        .toInt(),
                                    'discount' : (((state.room.oneDayAmount ?? 0 ) * state.normalDay + state.plusPrice +((state.room.additionalPeopleCost ?? 0) * (state.guestCount - state.room.standardPeople!)))* 0.01).toInt(),
                                      'plusPrice' : state.plusPrice
                                    });

                                  }else{
                                    context.push('/reservation', extra: {
                                      'room': state.room,
                                      'dateRange': state.dateRange,
                                      'guestCount': state.guestCount,
                                      'guestPlus': 0,
                                      'totalAmount':
                                      ((state.room.oneDayAmount ?? 0) *
                                          state.normalDay) + state.plusPrice -
                                          ((((state.room.oneDayAmount ?? 0) *
                                              state.normalDay +
                                              state.plusPrice) * 0.01).toInt()),
                                      'discount' : (((state.room.oneDayAmount ?? 0 ) * state.normalDay + state.plusPrice)* 0.01).toInt(),
                                      'plusPrice' : state.plusPrice
                                    });
                                    logger.d('추가비용');
                                  }
                                }
                              }
                            }
                            }
                          }else{
                            context.read<RoomDetailBloc>().add( Error(LogicalException(message: '날짜 설정을 완료해주세요.')));
                          }
                        }
                        Scrollable.ensureVisible(calenderKey.currentContext!, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut, alignment: 0);
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        )

        ),
      ),
    );
  }
}

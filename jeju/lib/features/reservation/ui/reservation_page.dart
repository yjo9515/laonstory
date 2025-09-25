import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/room/bloc/room_state.dart';

import '../../features.dart';
import '../../room/bloc/room_detail_bloc.dart';
import '../../room/bloc/room_event.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage(
      {super.key,
      this.room,
      this.dateRange,
      this.guestPlus,
      this.guestCount = 0,
      this.totalAmount = 0,
        this.discount = 0,
        this.plusPrice = 0
      });

  final Room? room;
  final DateRange? dateRange;
  final int guestCount;
  final int? guestPlus;
  final int? totalAmount;
  final int? discount;
  final int? plusPrice;

  @override
  Widget build(BuildContext context) {
    final range =
        (dateRange?.end.difference(dateRange?.start ?? DateTime.now()).inDays ??
                0);
    // final discount = ((room?.oneDayAmount ?? 0) * range * 0.01).toInt();
    // final totalAmount =
    //     (room?.oneDayAmount ?? 0) * range - discount + (guestPlus ?? 0);
    return BlocProvider(create: (context) => RoomDetailBloc(),
      child:BlocConsumer<RoomDetailBloc, RoomDetailState>(

      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(backButton: true, textTitle: '예약 진행'),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  RoomBigImage(room: room),
                  RoomHorizontalTitleWidget(room: room),
                  const TitleText(title: '예약 상세 정보'),
                  ReservationInfoWidget(title: '게스트', content: '$guestCount명'),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '숙박기간',
                        style: context.textTheme.krBody3,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '${dateParserDate(dateRange?.start, format: 'yyyy.MM.dd (E)')} ~ ${dateParserDate(dateRange?.end, format: 'yyyy.MM.dd (E)')}',
                        style: context.textTheme.krBody3,
                      ),
                    ),
                  ),
                  // ReservationInfoWidget(title: '숙박기간', content: '${dateParserDate(dateRange?.start, format: 'yyyy.MM.dd (E)')} ~ ${dateParserDate(dateRange?.end, format: 'yyyy.MM.dd (E)')}'),
                  ReservationInfoWidget(title: '숙박일 수', content: '$range박'),
                  const TitleText(title: '요금 세부 정보'),
                  ReservationInfoWidget(
                      title: '${numberFormatter(room?.oneDayAmount)} x $range박',
                      content:
                      '${numberFormatter((room?.oneDayAmount ?? 0) * range)} 원'),
                  ReservationInfoWidget(
                    title: '특정 날짜 가격',
                    child: Row(
                      children: [
                        Text(
                            '총 ${
                                numberFormatter(plusPrice)
                            } 원',
                            style: context.textTheme.krBody3),
                      ],
                    ),
                  ),
                  ReservationInfoWidget(
                    title: '장기숙박 할인',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: mainJeJuBlue,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text('장기할인 1%',
                              style: context.textTheme.krSubtext1
                                  .copyWith(color: white)),
                        ),
                        Text(
                          '- ${numberFormatter(discount)} 원',
                          style: context.textTheme.krBody4.copyWith(color: black4),
                        ),
                      ],
                    ),
                  ),
                  ReservationInfoWidget(
                    title: '추가인원 비용',
                    content: '${numberFormatter(guestPlus ?? 0)} 원',
                  ),
                  const Divider(),
                  ReservationInfoWidget(
                    title: '총 합계',
                    child: RichText(
                      text: TextSpan(
                        text: numberFormatter(totalAmount),
                        style: context.textTheme.krPoint1,
                        children: <TextSpan>[
                          TextSpan(text: '  원', style: context.textTheme.krBody5),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: const BoxDecoration(color: black7),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Text(
                      '해당 숙소의 취소 및 환불 정책을 필히 정독하시고 결제해주시기바랍니다. 제주살이는 해당숙소의 호스트에게 환불 권한을 모두 부여하며 부당하게 환불을 요구할 경우 직접 개입하게 될 수 있습니다.',
                      style: context.textTheme.krBody1.copyWith(color: black4),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LargeButton(
                    text: '${numberFormatter(totalAmount)} 원 결제하기',
                    onTap: () {
                      context.read<RoomDetailBloc>().add(const CreateOrder());
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
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
        } else if (state.status == CommonStatus.success) {
          context.push('/pay', extra: {'totalAmount':totalAmount,'order':state.order,'name':room?.name,'id':room?.id,'dateRange':dateRange,'guestCount':guestCount} );
        }
      })
    );




  }
}

class ReservationInfoWidget extends StatelessWidget {
  const ReservationInfoWidget(
      {super.key, this.title = '', this.content = '', this.child});

  final String title;
  final String content;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: context.textTheme.krBody3,
          ),
          const Spacer(),
          child ?? Text(content, style: context.textTheme.krBody3),
        ],
      ),
    );
  }
}

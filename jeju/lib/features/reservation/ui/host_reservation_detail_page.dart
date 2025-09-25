import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_event.dart';

import '../../../core/core.dart';

import '../bloc/host_reservation_detail_bloc.dart';
import '../bloc/reservation_detail_bloc.dart';
import '../bloc/reservation_state.dart';

class HostReservationDetailPage extends StatelessWidget {
  HostReservationDetailPage({super.key, required this.reservation});
  final Reservation reservation;


  @override
  Widget build(BuildContext context) {
    final memo = TextEditingController(text: reservation.memo ?? '');
    return BlocProvider(
      create: (context) => HostReservationDetailBloc(),
      child: BlocConsumer<HostReservationDetailBloc, HostReservationDetailState>(
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
            context.pushNamed('main', queryParameters: {'index' : '1'});
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colorScheme.background,
            appBar: const CustomAppBar(
              backButton: true,
              textTitle: '예약 상세',
              actions: [],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleText(
                        title:
                        '${DateFormat('yyyy-MM-dd').format(reservation.startDate!)} - ${DateFormat('yyyy-MM-dd').format(reservation.endDate!)}'),
                    TitleText(title: '예약 상세 정보'),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 108,
                                  child:
                                  Text('게스트', style: context.textTheme.krBody3)),
                              Expanded(
                                child: Text('${reservation.people}명',
                                    style: context.textTheme.krBody3),
                              )
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //         width: 108,
                          //         child: Text('예약자 성함',
                          //             style: context.textTheme.krBody3)),
                          //     Expanded(
                          //       child: Text(
                          //           '${reservation.name}',
                          //           style: context.textTheme.krBody3),
                          //     )
                          //   ],
                          // ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 108,
                                  child: Text('게스트 성함',
                                      style: context.textTheme.krBody3)),
                              Expanded(
                                child: Text('${reservation.name}',
                                    style: context.textTheme.krBody3),
                              )
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //         width: 108,
                          //         child: Text('게스트 번호',
                          //             style: context.textTheme.krBody3)),
                          //     Expanded(
                          //       child: Text(
                          //           '${reservation}',
                          //           style: context.textTheme.krBody3),
                          //     )
                          //   ],
                          // ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 108,
                                  child: Text('예약 번호',
                                      style: context.textTheme.krBody3)),
                              Expanded(
                                child: Text('${reservation.orderNumber}',
                                    style: context.textTheme.krBody3),
                              )
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              SizedBox(
                                  width: 108,
                                  child: Text('숙박 일 수',
                                      style: context.textTheme.krBody3)),
                              Expanded(
                                child: Text('${reservation.days}',
                                    style: context.textTheme.krBody3),
                              )
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
                                child: Text('${numberFormatter(reservation.totalAmount)}원',
                                    style: context.textTheme.krBody3),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('비공개 메모', style: context.textTheme.krSubtitle1),
                          TextButton(onPressed: () { context.read<HostReservationDetailBloc>().add(AddMemo(memo: memo.text, reservationId: reservation.id!)); },
                            child: Text('저장하기', style: context.textTheme.krBody1.copyWith(color: Colors.blue)),)
                        ],
                      ),
                    ),
                    InputWidget(
                      controller: memo,
                      // onChange: (value){
                      //   logger.d(value);
                      // },
                      hint: '비공개 메모를 적을 수 있습니다.',
                      format: TextInputType.text,
                      maxLength: 32,
                      count: true,
                      minLines: 7,
                      maxLines: 7,
                    ),
                    const SizedBox(height: 32),
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

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_event.dart';

import '../../../core/core.dart';
import '../bloc/reservation_detail_bloc.dart';
import '../bloc/reservation_state.dart';

class ReservationCancelPage extends StatelessWidget {
  ReservationCancelPage({super.key, required  this.id});
  String? id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationDetailBloc(),
      child: Scaffold(
          extendBody: true,
          backgroundColor: context.colorScheme.background,
          appBar: const CustomAppBar(
            backButton: true,
            textTitle: '예약 취소',
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '예약을 취소하시겠습니까?',
                        style: context.textTheme.krBody1,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '아래의 환불정책을 확인해주세요.',
                        style: context.textTheme.krBody1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TitleText(title: '숙소 환불 정책'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 108,
                              child: Text('10일 전 까지',
                                  style: context.textTheme.krBody3)),
                          Expanded(
                            child: Text(
                              '전액 환급',
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
                              child: Text('7일 전',
                                  style: context.textTheme.krBody3)),
                          Expanded(
                            child: Text(
                              '10%를 공제한 후 환급',
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
                              child: Text('5일 전',
                                  style: context.textTheme.krBody3)),
                          Expanded(
                            child: Text(
                              '30%를 공제한 후 환급',
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
                              child: Text('3일 전',
                                  style: context.textTheme.krBody3)),
                          Expanded(
                            child: Text(
                              '50%를 공제한 후 환급',
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
                              child: Text('1일 전',
                                  style: context.textTheme.krBody3)),
                          Expanded(
                            child: Text(
                              '80%를 공제한 후 환급',
                              style: context.textTheme.krBody3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '예) 숙박료로 10만원을 결제한 뒤 예약하고 하루전에 취소하게 되면 80%인 8만원을 위약금으로 내고 2만원을 돌려받습니다.',
                        style: TextStyle(
                            color: ColorTheme.light.disableTextColor,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 103),
                BlocSelector<ReservationDetailBloc, ReservationDetailState,
                    bool>(
                  selector: (state) => state.agree,
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<ReservationDetailBloc>()
                                .add(Agree(agree: !state));
                          },
                          child: Row(
                            children: [
                              SvgImage(
                                  width: 24,
                                  height: 24,
                                  state
                                      ? 'assets/icons/ic_checkbox_on.svg'
                                      : 'assets/icons/ic_checkbox_off.svg'),
                              const SizedBox(width: 16),
                              Text(
                                '숙소 환불정책에 동의하시겠습니까?',
                                style: context.textTheme.krBody3,
                              )
                            ],
                          ),
                        ));
                  },
                ),
                SizedBox(
                    height: LargeButton.of(context).floatingActionButtonHeight),
              ],
            )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              BlocConsumer<ReservationDetailBloc, ReservationDetailState>(
                  listenWhen: (previous, current) => previous.status != current.status,
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
                    }else if (state.status == CommonStatus.success){
                      context.push('/reservation/done');
                    }
                  },
                  builder: (context, state) {
                    return LargeButton(
                      color: ColorTheme.dark.disableButton,
                      onTap: () {
                        if(state.agree){
                          context.read<ReservationDetailBloc>().add(Cancel(id: id ?? ''));
                        }else{
                          showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: const Text(
                                    '알림',
                                  ),
                                  content: Text(
                                    '환불정책에 동의해주세요!',
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
                      text: '예약 취소',
                    );
                  })),
    );
  }
}

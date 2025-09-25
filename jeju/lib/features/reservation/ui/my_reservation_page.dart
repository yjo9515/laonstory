import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeju_host_app/features/reservation/bloc/my_reservation_list_bloc.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_state.dart';

import '../../../core/core.dart';
import '../../features.dart';

class MyReservationPage extends StatelessWidget {
  const MyReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MyReservationListBloc()..add(const Initial()),
        child: BlocConsumer<MyReservationListBloc, ReservationListState>(
          listener: (BuildContext context, ReservationListState state) {
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
          builder: (context, state) {
            var notCancel = state.reservationList.where((element) => element.status != '취소');
            if (state.reservationList.isEmpty || notCancel.first == null) {
              return SafeArea(child: Container(
                decoration: BoxDecoration(
                  image:
                  DecorationImage(image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'), fit: BoxFit.cover),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('예약된 숙소가 없습니다.', style: context.textTheme.krPoint1.copyWith(color: white)),
                      const SizedBox(height: 64),
                      Text('제주살이에서 예약을 진행하고', style: context.textTheme.krBody4.copyWith(color: white)),
                      Text('멋진 시간을 경험해보세요', style: context.textTheme.krBody4.copyWith(color: white)),
                    ],
                  ),
                ),
              ));
            }else{
              return SingleChildScrollView(
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image:
                          state.reservationList.isNotEmpty &&
                          state.reservationList.first.image != null &&
                          state.reservationList.first.image!.path != null &&
                          state.reservationList.first.image!.path!.isNotEmpty?
                          DecorationImage(image: NetworkImage('$imageUrl${state.reservationList.first.image?.path}'), fit: BoxFit.cover):
                          DecorationImage(image: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'), fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: AppBar(
                                elevation: 0,
                                leadingWidth: 64,
                                centerTitle: true,
                                actions: [Container(margin: const EdgeInsets.only(right: 8), child: IconButton(splashRadius: 24, onPressed: () {}, icon: const SvgImage('assets/icons/ic_share.svg')))],
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 160),
                             ReservationCard(response:notCancel.first,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TitleText(title: '나의 모든 예약'),

                      ReservationListWidget(response:state.reservationList),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),

    );

  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../bloc/alert_bloc.dart';
import '../bloc/alert_event.dart';
import '../bloc/alert_state.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textTitle: '알림 설정',
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => AlertBloc()..add(Initial()),
          child: BlocConsumer<AlertBloc, AlertState>(
            listener: (context, state){

            },
            builder: (context, state){
              return Column(
                children: [
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2,color: black5))
                    ),
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('전체알림',style: context.textTheme.krButton1.copyWith(fontSize: 18),),
                        Transform.scale(
                            scale: 0.75,
                            child:CupertinoSwitch(
                                thumbColor: state.isAll == true ? mainJeJuBlue : gray0,
                                activeColor: Colors.white,
                                value: state.isAll,
                                onChanged: (value) async {
                                  context.read<AlertBloc>().add(ChangeAlert(type: 'all',value: value));
                                }))
                      ],
                    )
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2,color: black5))
                    ),
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1:1문의',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
                        Transform.scale(
                            scale: 0.75,
                            child:CupertinoSwitch(
                                thumbColor: state.isOneToOneInquiry == true ? mainJeJuBlue : gray0,
                                activeColor: Colors.white,
                                value: state.isOneToOneInquiry,
                                onChanged: (value) async {
                                  context.read<AlertBloc>().add(ChangeAlert(type: 'isOneToOneInquiry',value: value));
                                }))
                      ],
                    ),
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2,color: black5))
                    ),
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('예약현황',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
                        Transform.scale(
                            scale: 0.75,
                            child:CupertinoSwitch(
                                thumbColor: state.isReservation == true ? mainJeJuBlue : gray0,
                                activeColor: Colors.white,
                                value: state.isReservation,
                                onChanged: (value) async {
                                  context.read<AlertBloc>().add(ChangeAlert(type: 'isReservation',value: value));
                                }))
                      ],
                    ),
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2,color: black5))
                    ),
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('메세지',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
                        Transform.scale(
                            scale: 0.75,
                            child:CupertinoSwitch(
                                thumbColor: state.isMessage == true ? mainJeJuBlue : gray0,
                                activeColor: Colors.white,
                                value: state.isMessage,
                                onChanged: (value) async {
                                  context.read<AlertBloc>().add(ChangeAlert(type: 'isMessage',value: value));
                                }))
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        )
      ),
    );
  }
}

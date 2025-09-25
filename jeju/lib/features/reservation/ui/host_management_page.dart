import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_event.dart';

import '../../../core/core.dart';

import '../bloc/host_management_bloc.dart';
import '../bloc/host_reservation_detail_bloc.dart';
import '../bloc/reservation_management_bloc.dart';
import '../bloc/reservation_state.dart';

class HostManagementPage extends StatelessWidget {
  const HostManagementPage({super.key, required this.id, required this.date, this.data});
  final int id;
  final DateTime date;
  final DateManagement? data;


  @override
  Widget build(BuildContext context) {

    final memo = TextEditingController(text: data?.memo ?? '');
    final amount = TextEditingController();
    final afterAmount = TextEditingController();
    return BlocProvider(
      create: (context) => HostManagementBloc()..add(Initial(id: id.toString(),data: date)),
      child: BlocConsumer<HostManagementBloc, HostManagementState>(
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
            // showAdaptiveDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog.adaptive(
            //         title: const Text(
            //           '알림',
            //         ),
            //         content: Text(
            //           '설정이 완료되었습니다.',
            //         ),
            //         actions: <Widget>[
            //           adaptiveAction(
            //             context: context,
            //             onPressed: () => Navigator.pop(context, '확인'),
            //             child: const Text('확인'),
            //           ),
            //         ],
            //       );
            //     });
            context.pushNamed('main', queryParameters: {'index' : '1'});
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: context.colorScheme.background,
            appBar: const CustomAppBar(
              backButton: true,
              textTitle: '호스팅 관리',
              actions: [],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${DateFormat('yyyy-MM-dd').format(date)}', style: context.textTheme.krSubtitle1),
                              // TextButton(onPressed: () {
                              //   showModalBottomSheet(
                              //     context: context,
                              //     builder: (BuildContext builderContext) {
                              //       return Container(
                              //         child: Column(
                              //           children: [
                              //             Row(
                              //               children: [
                              //
                              //               ],
                              //
                              //             )
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   );
                              //
                              // },
                              //   child: Text('날짜 변경하기', style: context.textTheme.krSubtext2.copyWith(decoration: TextDecoration.underline,),),)
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('호스팅 가능', style: context.textTheme.krSubtitle1),
                              Row(
                                children: [
                                  Text( state.isHosting??false ? '호스팅 중': '호스팅 중지',style: context.textTheme.krSubtext1.copyWith(color: gray0)),
                                  Transform.scale(
                                    scale: 0.75,
                                    child:
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:  CupertinoSwitch(
                                            thumbColor: (state.isHosting ?? false) ? mainJeJuBlue : white,
                                            activeColor: Colors.white,
                                            value: state.isHosting ?? false,
                                            onChanged: (value) async {
                                              context.read<HostManagementBloc>().add(SwitchToggle(toggle: value));
                                            })),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            height: (state.isHosting ?? false) ? 300 : 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('숙소요금 설정', style: context.textTheme.krSubtitle1),
                                  const SizedBox(height: 16),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller:amount,
                                    inputFormatters: const FillTypes(format: NewTextInputType.price).inputFormat,
                                    maxLength: 9,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                        child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),),
                                    ),
                                    onChanged: (value){
                                      context.read<HostManagementBloc>().add(SetAmount(amount: int.parse(value.replaceAll(',', ''))));
                                    },
                                  ),
                                  const SizedBox(height: 32),
                                  Row(
                                    children: [
                                      Expanded(flex:40,child: Text('맞춤 금액 설정', style: context.textTheme.krSubtitle1),),
                                      Expanded(flex:60,child: Text('선택한 날짜에 할인/추가금을 설정하세요.', style: context.textTheme.krSubtext2.copyWith(color: gray0)),),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                        DropdownMenuWidget<String>(
                                          filled: false,
                                          hint: '선택해주세요',
                                          dropdownList: const [
                                            '-10%',
                                            '-20%',
                                            '+10%',
                                            '직접입력'
                                          ],
                                          onChanged: (value) {
                                            if(amount.text != null){
                                              switch(value){
                                                case '-10%':
                                                  afterAmount.text = numberFormatter((int.parse(amount.text.replaceAll(',', '')) * 0.9).toInt());
                                                  break;
                                                case '-20%':
                                                  afterAmount.text = numberFormatter((int.parse(amount.text.replaceAll(',', '')) * 0.8).toInt());
                                                  break;
                                                case '+10%':
                                                  afterAmount.text = numberFormatter((int.parse(amount.text.replaceAll(',', '')) * 1.1).toInt());
                                                  break;
                                                case '직접입력':
                                                  break;
                                              }
                                            }
                                            context.read<HostManagementBloc>().add(ChangeAmount(menu:value!));
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(child:
                                      TextField(
                                        controller:afterAmount ,
                                        inputFormatters: const FillTypes(format: NewTextInputType.price).inputFormat,
                                        maxLength: 9,
                                        enabled: state.enable,
                                        decoration: InputDecoration(
                                          hintText: '변동 후 총 금액',
                                          fillColor: state.enable ? Theme.of(context).inputDecorationTheme.fillColor : context.colorScheme.disableButton,
                                          counterText: '',
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                                            child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),),
                                        ),
                                        onChanged: (value){
                                          logger.d(value);
                                          context.read<HostManagementBloc>().add(SetAmount(amount:int.parse(amount.text.replaceAll(',', ''))));
                                        },
                                      ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text('비공개 메모', style: context.textTheme.krSubtitle1),
                    //       TextButton(onPressed: () { context.read<HostReservationDetailBloc>().add(AddMemo(memo: memo.text, reservationId: data!.id!)); },
                    //         child: Text('저장하기', style: context.textTheme.krBody1.copyWith(color: Colors.blue)),)
                    //     ],
                    //   ),
                    // ),
                    // InputWidget(
                    //   controller: memo,
                    //   // onChange: (value){
                    //   //   logger.d(value);
                    //   // },
                    //   hint: '비공개 메모를 적을 수 있습니다.',
                    //   format: TextInputType.text,
                    //   maxLength: 32,
                    //   count: true,
                    //   minLines: 7,
                    //   maxLines: 7,
                    // ),
                    const SizedBox(height: 16),

                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LargeButton(
                onTap: () {
                  context.read<HostManagementBloc>().add(Host(id: id, date: date));
                },
                text: '저장하기',
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );

  }



}

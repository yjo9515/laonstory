part of '../ui/add_room_page.dart';

class AddRoomEighthPage extends StatelessWidget {
  const AddRoomEighthPage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController(text: '0');
    final minPriceController = TextEditingController(text: '0');
    final minDayController = TextEditingController(text: '1');
    final maxDayController = TextEditingController(text: '10');

    return BlocConsumer<AddRoomBloc, AddRoomState>(
      bloc: bloc,
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
          context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '9'});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            tag: 'add_room',
            backButton: true,
            textTitle: '숙소 등록',
            actions: [],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Hero(
                  tag: 'progress',
                  child: ProgressWidget(
                    begin: 1,
                    end: 1,
                  ),
                ),
                Hero(
                  tag: 'text',
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        text: '숙소등록 ',
                        style: context.textTheme.krSubtitle1,
                        children: <TextSpan>[
                          TextSpan(text: '(8/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: RichText(
                            text: TextSpan(
                              text: '숙박 요금을 설정해주세요  ',
                              style: context.textTheme.krSubtitle1,
                              children: <TextSpan>[
                                TextSpan(text: '(이후 변경 가능)', style: context.textTheme.krBody3.copyWith(color: black3)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                          child: Text(
                              '사업자는 본인 주민등록 소재지인 시-군-구에 제주살이를 등록해야 하며, 연 120일 이상 숙소를 빌려줄 수 없고, 오피스텔과 원룸은 숙박시설로 제공할 수 없는 등 관련하여 다양한 규제가 이루어지고 있습니다. 제주살이는 예약당 결제된 숙박요금에서 15%의 수수료를 부과하고있습니다. 숙박요금은 기타비용(청소비)를 포함하여 설정해주십시오.',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: context.textTheme.krBody3),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('숙박 최소 기간(일)', style: context.textTheme.krBody3),
                              CountWidget(
                                  controller: minDayController,
                                  count: state.room.minCheckDay ?? 2,
                                  onChanged: (value) {
                                    if(value == 1){
                                      context.read<AddRoomBloc>().add( Error(LogicalException(message: '당일치기는 지원하지않습니다.')));
                                    }else{
                                      minDayController.text = '$value';
                                      if ((state.room.maxCheckDay ?? 0) < value) {
                                        maxDayController.text = '$value';
                                        bloc.add(ChangeRoom(room: state.room.copyWith(minCheckDay: value, maxCheckDay: value)));
                                      } else {
                                        bloc.add(ChangeRoom(room: state.room.copyWith(minCheckDay: value)));
                                      }
                                      if (priceController.text.isEmpty) return;
                                      minPriceController.text = numberFormatter(int.parse(priceController.text.replaceAll(',', '')) * (value));
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('숙박 최대 기간(일)', style: context.textTheme.krBody3),
                              CountWidget(
                                  controller: maxDayController,
                                  count: state.room.maxCheckDay ?? 1,
                                  onChanged: (value) {
                                    maxDayController.text = '$value';
                                    if ((state.room.minCheckDay ?? 0) > value) {
                                      minDayController.text = '$value';
                                      bloc.add(ChangeRoom(room: state.room.copyWith(minCheckDay: value, maxCheckDay: value)));
                                    } else {
                                      bloc.add(ChangeRoom(room: state.room.copyWith(maxCheckDay: value)));
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 120,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Text('1일 숙박 요금', style: context.textTheme.krBody3)),
                              const SizedBox(width: 16),
                              // Expanded(
                              //   child: InputWidget(
                              //     controller: priceController,
                              //     format: NewTextInputType.price,
                              //     helper: false,
                              //     maxLength: 9,
                              //     onChange: (value) {
                              //       if (value.isEmpty) return;
                              //       minPriceController.text = numberFormatter(int.parse(value.replaceAll(',', '')) * (state.room.minCheckDay ?? 1));
                              //       bloc.add(ChangeRoom(room: state.room.copyWith(oneDayAmount: int.parse(value.replaceAll(',', '')))));
                              //     },
                              //     suffixWidget: Padding(
                              //       padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                              //       child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                  child:
                                Padding(
                                  padding: EdgeInsets.fromLTRB(36,0,24,0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          maxLength: 9,
                                          inputFormatters: FillTypes(format: NewTextInputType.price).inputFormat,
                                          controller: priceController,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                              child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.isEmpty) return;
                                            minPriceController.text = numberFormatter(int.parse(value.replaceAll(',', '')) * (state.room.minCheckDay ?? 1));
                                            bloc.add(ChangeRoom(room: state.room.copyWith(oneDayAmount: int.parse(value.replaceAll(',', '')))));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 120,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Text('최소기간 숙박 금액', style: context.textTheme.krBody3)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InputWidget(
                                  enabled: false,
                                  controller: minPriceController,
                                  format: NewTextInputType.price,
                                  helper: false,
                                  maxLength: 9,
                                  suffixWidget: Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                    child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                            child:ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (int index, bool isExpanded) {},
                          children: [
                            ExpansionPanel(
                                backgroundColor: Colors.white,
                                isExpanded: true,
                                canTapOnHeader: true,
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(
                                      '환불정책',
                                      style: context.textTheme.krSubtitle1,
                                    ),

                                  );
                                },
                                body: Column(
                                  children: ['10', '7', '5', '3', '1'].map<Widget>((String data) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child:Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), child: Text('$data일 까지', style: context.textTheme.krBody3)), ),
                                          Expanded(child:Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),child: TextFormField(
                                            inputFormatters: FillTypes(format: NewTextInputType.percent).inputFormat,
                                            textAlign:TextAlign.right,
                                            initialValue: switch (data) {
                                              '10' => state.room.refundRuleTen.toString(),
                                              '7' => state.room.refundRuleSeven.toString(),
                                              '5' => state.room.refundRuleFive.toString(),
                                              '3' => state.room.refundRuleThree.toString(),
                                              '1' => state.room.refundRuleOne.toString(),
                                              _ => state.room.refundRuleTen.toString()
                                            },
                                            onChanged: (value) {
                                              if (value.isEmpty) return;
                                              bloc.add(ChangeRoom(
                                                  room: switch (data) {
                                                    '10' => state.room.copyWith(refundRuleTen: int.parse(value)),
                                                    '7' => state.room.copyWith(refundRuleSeven: int.parse(value)),
                                                    '5' => state.room.copyWith(refundRuleFive: int.parse(value)),
                                                    '3' => state.room.copyWith(refundRuleThree: int.parse(value)),
                                                    '1' => state.room.copyWith(refundRuleOne: int.parse(value)),
                                                    _ => state.room
                                                  }));
                                            },
                                            decoration: InputDecoration(
                                              counterText:'',
                                              suffix: Padding(
                                                padding: const EdgeInsets.only(left: 36, right: 24),
                                                child: Text('%', style: context.textTheme.krBody3.copyWith(color: black3)),
                                              ),

                                            ),
                                            maxLength: 3,
                                          ),) )
                                          // SizedBox(
                                          //   width: 200,
                                          //   child:
                                          //   // InputWidget(
                                          //   //   format: NewTextInputType.percent,
                                          //   //   initialValue: switch (data) {
                                          //   //     '10' => state.room.refundRuleTen.toString(),
                                          //   //     '7' => state.room.refundRuleSeven.toString(),
                                          //   //     '5' => state.room.refundRuleFive.toString(),
                                          //   //     '3' => state.room.refundRuleThree.toString(),
                                          //   //     '1' => state.room.refundRuleOne.toString(),
                                          //   //     _ => state.room.refundRuleTen.toString()
                                          //   //   },
                                          //   //   onChange: (value) {
                                          //   //     if (value.isEmpty) return;
                                          //   //     bloc.add(ChangeRoom(
                                          //   //         room: switch (data) {
                                          //   //       '10' => state.room.copyWith(refundRuleTen: int.parse(value)),
                                          //   //       '7' => state.room.copyWith(refundRuleSeven: int.parse(value)),
                                          //   //       '5' => state.room.copyWith(refundRuleFive: int.parse(value)),
                                          //   //       '3' => state.room.copyWith(refundRuleThree: int.parse(value)),
                                          //   //       '1' => state.room.copyWith(refundRuleOne: int.parse(value)),
                                          //   //       _ => state.room
                                          //   //     }));
                                          //   //   },
                                          //   //   helper: true,
                                          //   //   maxLength: 3,
                                          //   //   suffixWidget: Padding(
                                          //   //     padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                          //   //     child: Text('%', style: context.textTheme.krBody3.copyWith(color: black3)),
                                          //   //   ),
                                          //   // ),
                                          //   ,
                                          // ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ))
                          ],
                        ),
                        ),

                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            onTap: () async {
                              state.room.oneDayAmount == 0 ?
                              showAdaptiveDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      title: const Text(
                                        '알림',
                                      ),
                                      content: Text(
                                        '1일 숙박 요금을 입력해주세요.',
                                      ),
                                      actions: <Widget>[
                                        adaptiveAction(
                                          context: context,
                                          onPressed: () => Navigator.pop(context, '확인'),
                                          child: const Text('확인'),
                                        ),
                                      ],
                                    );
                                  }) :
                              context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '9'});
                              // checkInputData(context,
                              //     controllers:
                              //     // kDebugMode
                              //     //     ? []
                              //     //     :
                              //     [
                              //       (state.room.oneDayAmount.toString(), '1일 숙박 요금을 입력해주세요.')
                              //     ], onDone: () {
                              //       context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '9'});
                              //     });
                            },
                            text: '다음',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

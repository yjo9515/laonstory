part of '../ui/add_room_page.dart';

class AddRoomSecondPage extends StatelessWidget {
  const AddRoomSecondPage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController();
    final squareController = TextEditingController();
    final meterController = TextEditingController();

    return BlocBuilder<AddRoomBloc, AddRoomState>(
      bloc: bloc,

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
                    begin: 0.125,
                    end: 0.250,
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
                          TextSpan(text: '(2/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
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
                          child: Text(
                            '숙소 기본 정보를 알려 주세요 ',
                            style: context.textTheme.krSubtitle1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('숙박 기준 인원', style: context.textTheme.krBody3),
                              CountWidget(
                                  count: state.room.standardPeople ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(standardPeople: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('숙박 최대 인원', style: context.textTheme.krBody3),
                              CountWidget(count: state.room.maximumPeople ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(maximumPeople: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('추가인원 비용', style: context.textTheme.krBody3),
                              SwitchWidget(
                                value: state.room.isAdditionalPeople ?? false ? '비용있음' : '비용없음',
                                switches: const ['비용있음', '비용없음'],
                                onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(isAdditionalPeople: value == '비용있음'))),
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: (state.room.isAdditionalPeople ?? false) ? 130 : 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text('추가인원 1인당 비용', style: context.textTheme.krBody3)),
                                    const SizedBox(width: 16),
                                    // Expanded(
                                    //   child: InputWidget(
                                    //     controller: priceController,
                                    //     format: FillTypes(format: NewTextInputType.price).inputFormat,
                                    //     onChange: (value) {
                                    //       logger.d(value);
                                    //
                                    //       if (value.isNotEmpty) {
                                    //         bloc.add(ChangeRoom(room: state.room.copyWith(additionalPeopleCost: int.parse(value.replaceAll(',', '')))));
                                    //       } else {
                                    //         bloc.add(ChangeRoom(room: state.room.copyWith(additionalPeopleCost: 0)));
                                    //       }
                                    //     },
                                    //     helper: false,
                                    //     maxLength: 7,
                                    //     suffixWidget: Padding(
                                    //       padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                    //       child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      maxLength: 7,
                                      inputFormatters: const FillTypes(format: NewTextInputType.price).inputFormat,
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                          child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          bloc.add(ChangeRoom(room: state.room.copyWith(additionalPeopleCost: int.parse(value.replaceAll(',', '')))));
                                        } else {
                                          bloc.add(ChangeRoom(room: state.room.copyWith(additionalPeopleCost: 0)));
                                        }
                                      },
                                    ),),
                                    const SizedBox(width: 24),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  alignment: Alignment.centerLeft,
                                  child: Text('입실 당일 추가인원확인 후, 현장결제/계좌이체로 진행됨', style: context.textTheme.krBody1.copyWith(color: Colors.orange)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('방 개수', style: context.textTheme.krBody3),
                              CountWidget(count: state.room.roomCount ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(roomCount: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('층', style: context.textTheme.krBody3),
                              CountWidget(count: state.room.floor ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(floor: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('욕실 개수', style: context.textTheme.krBody3),
                              CountWidget(count: state.room.bathroomCount ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(bathroomCount: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('숙소의 실평수', style: context.textTheme.krBody3),
                              const SizedBox(width: 32),
                              Expanded(
                                flex: 1,
                                child: InputWidget(
                                  nonePadding: true,
                                  controller: squareController,
                                  onChange: (value) {
                                    if (value.isNotEmpty) {
                                      meterController.text = (int.parse(value.replaceAll(',', '')) * 3.305785).toStringAsFixed(1);
                                      bloc.add(ChangeRoom(room: state.room.copyWith(squareFeet: int.parse(value.replaceAll(',', '')))));
                                    }
                                  },
                                  format: TextInputType.number,
                                  helper: false,
                                  maxLength: 3,
                                  suffixWidget: Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                    child: Text('평', style: context.textTheme.krBody3.copyWith(color: black3)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: InputWidget(
                                  nonePadding: true,
                                  enabled: false,
                                  controller: meterController,
                                  format: NewTextInputType.under,
                                  helper: false,
                                  maxLength: 6,
                                  suffixWidget: Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                                    child: Text('㎡', style: context.textTheme.krBody3.copyWith(color: black3)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('반려동물 가능 여부', style: context.textTheme.krBody3),
                              SwitchWidget(
                                value: state.room.isPossiblePet ?? false ? '가능' : '불가능',
                                switches: const ['가능', '불가능'],
                                onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(isPossiblePet: value == '가능'))),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('침대개수', style: context.textTheme.krBody3),
                              RichText(
                                text: TextSpan(
                                  text: '총 ',
                                  style: context.textTheme.krBody3,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${(state.room.doubleBed ?? 0) + (state.room.queenBed ?? 0) + (state.room.kingBed ?? 0) + (state.room.singleBed ?? 0) + (state.room.superSingleBed ?? 0)}',
                                        style: context.textTheme.krBody5.copyWith(color: mainJeJuBlue)),
                                    TextSpan(text: ' 개', style: context.textTheme.krBody3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('싱글', style: context.textTheme.krBody3),
                              CountWidget(count: (state.room.singleBed ?? 0), onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(singleBed: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('슈퍼 싱글', style: context.textTheme.krBody3),
                              CountWidget(count: (state.room.superSingleBed ?? 0), onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(superSingleBed: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('더블', style: context.textTheme.krBody3),
                              CountWidget(count: (state.room.doubleBed ?? 0), onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(doubleBed: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('퀸', style: context.textTheme.krBody3),
                              CountWidget(count: (state.room.queenBed ?? 0), onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(queenBed: value)))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('킹', style: context.textTheme.krBody3),
                              CountWidget(count: (state.room.kingBed ?? 0), onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(kingBed: value)))),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                              child: Text('숙소 입/퇴실 시간', style: context.textTheme.krSubtitle1),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).inputDecorationTheme.fillColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        DateTime checkIn = state.room.checkIn ?? DateTime(2023, 1, 1, 15, 0);
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              height: 400,
                                              margin: const EdgeInsets.symmetric(horizontal: 8),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Container(margin: const EdgeInsets.all(16), alignment: Alignment.centerLeft, child: Text('숙소 입실시간', style: context.textTheme.krBody4)),
                                                    Expanded(
                                                      child: CupertinoDatePicker(
                                                        onDateTimeChanged: (value) {
                                                          checkIn = value;
                                                        },
                                                        mode: CupertinoDatePickerMode.time,
                                                        minuteInterval: 10,
                                                        initialDateTime: checkIn,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 24),
                                                    LargeButton(
                                                      onTap: () {
                                                        bloc.add(ChangeRoom(room: state.room.copyWith(checkIn: checkIn)));
                                                        Navigator.pop(context);
                                                      },
                                                      text: '확인',
                                                    ),
                                                    const SizedBox(height: 24),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child:
                                          Text('${state.room.checkIn?.hour ?? 15} : ${(state.room.checkIn?.minute ?? 0) == 0 ? '00' : state.room.checkIn?.minute}', style: context.textTheme.krBody3),
                                    ),
                                    const SizedBox(width: 32),
                                    Text('/', style: context.textTheme.krBody3),
                                    const SizedBox(width: 32),
                                    InkWell(
                                        onTap: () {
                                          DateTime checkOut = state.room.checkOut ?? DateTime(2023, 1, 1, 11, 0);
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    color: Theme.of(context).scaffoldBackgroundColor,
                                                    height: 400,
                                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                                    child: Center(
                                                        child: Column(
                                                      children: [
                                                        Container(margin: const EdgeInsets.all(16), alignment: Alignment.centerLeft, child: Text('숙소 퇴실시간', style: context.textTheme.krBody4)),
                                                        Expanded(
                                                            child: CupertinoDatePicker(
                                                          onDateTimeChanged: (value) {
                                                            checkOut = value;
                                                          },
                                                          mode: CupertinoDatePickerMode.time,
                                                          minuteInterval: 10,
                                                          initialDateTime: checkOut,
                                                        )),
                                                        const SizedBox(height: 24),
                                                        LargeButton(
                                                          onTap: () {
                                                            bloc.add(ChangeRoom(room: state.room.copyWith(checkOut: checkOut)));
                                                            Navigator.pop(context);
                                                          },
                                                          text: '확인',
                                                        ),
                                                        const SizedBox(height: 24),
                                                      ],
                                                    )));
                                              });
                                        },
                                        child: Text('${state.room.checkOut?.hour ?? 11} : ${(state.room.checkOut?.minute ?? 0) == 0 ? '00' : state.room.checkOut?.minute}',
                                            style: context.textTheme.krBody3)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: LargeButton(
                                onTap: () {
                                  checkInputData(context,
                                      controllers:
                                      // kDebugMode
                                      //     ? []
                                      //     :
                                      (state.room.isAdditionalPeople == true && priceController.text.isEmpty) ?
                                      [
                                        (priceController.text, '추가인원 1인당 비용을 입력해 주세요.'),
                                      ] :[
                                        (squareController.text, '숙소의 실평수를 입력해 주세요.'),
                                        (squareController.text, '숙소의 실평수를 입력해 주세요.'),

                                      ], onDone: () {
                                        // (state.room.doubleBed ?? 0) + (state.room.queenBed ?? 0) + (state.room.kingBed ?? 0) + (state.room.singleBed ?? 0) + (state.room.superSingleBed ?? 0) == 0
                                        //     ?
                                        // AlertDialog.adaptive(
                                        //   title: const Text(
                                        //     '알림',
                                        //   ),
                                        //   content: Text(
                                        //     '침대 개수를 선택해 주세요',
                                        //   ),
                                        //   actions: <Widget>[
                                        //     adaptiveAction(
                                        //       context: context,
                                        //       onPressed: () => Navigator.pop(context, '확인'),
                                        //       child: const Text('확인'),
                                        //     ),
                                        //   ],
                                        // ):
                                        context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '3'});
                                      });
                                },
                                text: '다음',
                              ),
                            ),
                          ],
                        )
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

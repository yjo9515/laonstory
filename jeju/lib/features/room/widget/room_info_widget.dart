import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/room_event.dart';
import '../bloc/room_management_bloc.dart';
import '../bloc/room_state.dart';
import 'edit_reorderable_list_widget.dart';
import 'room_widget.dart';

class RoomInfoWidget extends StatelessWidget {
  RoomInfoWidget({super.key, required this.bloc, required this.controllers});

  final RoomManagementBloc bloc;
  final Map<String, TextEditingController> controllers;

  String? name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomManagementBloc, RoomManagementState>(
      bloc: bloc,
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (RoomStatus.strToEnum(state.room.status) == RoomStatus.WAITING)
                Container(
                  color: black7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleText(title: '숙소 심사가 진행중입니다.'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text('숙소 심사 진행중에도 내용은 수정할 수 있으며, 수정된 내용을 포함하여 심사를 진행합니다.', style: context.textTheme.krBody3.copyWith(color: black3)),
                      )
                    ],
                  ),
                ),
              if (RoomStatus.strToEnum(state.room.status) == RoomStatus.REJECT)
                Container(
                  color: black7,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(title: '숙소 승인이 반려되었습니다.'),

                      /// todo : 반려 사유
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text('${state.room.rejectReason ?? ''}', style: context.textTheme.krBody3.copyWith(color: black3)),
                      )
                    ],
                  ),
                ),
              InputWidget(
                controller: controllers['name'],
                onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(name: value))),
                label: '숙소이름',
                hint: '이름을 입력해주세요.',
                format: TextInputType.text,
                maxLength: 32,
                count: true,
                minLines: 3,
                maxLines: 3,
              ),
              InputWidget(
                controller: controllers['description'],
                labelSuffixWidget: Container(margin: const EdgeInsets.only(left: 16), child: Text('특징과 장점, 주의사항을 입력해주세요', style: context.textTheme.krBody3.copyWith(color: black3))),
                label: '숙소 설명',
                hint: '숙소 설명을 아낌없이 적어주세요.',
                onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(description: value))),
                format: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLength: 1500,
                count: true,
                minLines: 10,
                maxLines: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Text('숙소 소유 구분', style: context.textTheme.krSubtitle1),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(bottom: 8),
                width: double.infinity,
                child: DropdownMenuWidget<String>(
                  filled: false,
                  alignment: Alignment.centerLeft,
                  value: state.room.possessionClassification == 'RENTAL' ? '부동산 명의자에게 임대운영에 동의를 구한 경우' : '호스트가 집주인일 경우(부동산 명의자)',
                  hint: '소유 구분값을 선택해 주세요',
                  dropdownList: const [
                    '부동산 명의자에게 임대운영에 동의를 구한 경우',
                    '호스트가 집주인일 경우(부동산 명의자)',
                  ],
                  onChanged: (value) => bloc.add(CheckOwner(owner: value)),
                ),
              ),
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
                    CountWidget(count: state.room.standardPeople ?? 1, onChanged: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(standardPeople: value)))),
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
                height: (state.room.isAdditionalPeople ?? false) ? 140 : 0,
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
                          Expanded(
                            child:
                            // InputWidget(
                            //   controller: controllers['additionalPeopleCost'],
                            //   onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(oneDayAmount: int.parse(value.replaceAll(',', ''))))),
                            //   format: NewTextInputType.price,
                            //   helper: false,
                            //   maxLength: 7,
                            //   suffixWidget: Padding(
                            //     padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                            //     child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                            //   ),
                            // ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                maxLength: 7,
                                inputFormatters: const FillTypes(format: NewTextInputType.price).inputFormat,
                                controller: controllers['additionalPeopleCost'],
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
                              )
                          ),
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
                        controller: controllers['square'],
                        onChange: (value) => (controllers['meter']!).text = (int.parse(value.replaceAll(',', '')) * 3.025).toStringAsFixed(2),
                        onFieldSubmitted: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(squareFeet: int.parse(value.replaceAll(',', ''))))),
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
                        controller: controllers['meter'],
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
                              text: '${(state.room.doubleBed ?? 0) + (state.room.queenBed ?? 0) + (state.room.kingBed ?? 0) + (state.room.singleBed ?? 0) + (state.room.superSingleBed ?? 0)}',
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
                        child: Text('${state.room.checkIn?.hour ?? 15} : ${(state.room.checkIn?.minute ?? 0) == 0 ? '00' : state.room.checkIn?.minute}', style: context.textTheme.krBody3),
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
                                            onDateTimeChanged: (value) {},
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
                          child: Text('${state.room.checkOut?.hour ?? 11} : ${(state.room.checkOut?.minute ?? 0) == 0 ? '00' : state.room.checkOut?.minute}', style: context.textTheme.krBody3)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                        controller: controllers['minDay'],
                        count: state.room.minCheckDay ?? 1,
                        onChanged: (value) {
                          controllers['minDay']?.text = '$value';
                          if ((state.room.maxCheckDay ?? 0) < value) {
                            controllers['maxDay']?.text = '$value';
                            bloc.add(ChangeRoom(room: state.room.copyWith(minCheckDay: value, maxCheckDay: value)));
                          } else {
                            bloc.add(ChangeRoom(room: state.room.copyWith(minCheckDay: value)));
                          }
                          if (controllers['price']?.text.isEmpty ?? true) return;
                          controllers['minPrice']?.text = numberFormatter(int.parse((controllers['price'] ?? TextEditingController()).text.replaceAll(',', '')) * (value));
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
                        controller: controllers['maxDay'],
                        count: state.room.maxCheckDay ?? 1,
                        onChanged: (value) {
                          controllers['maxDay']?.text = '$value';
                          if ((state.room.minCheckDay ?? 0) > value) {
                            controllers['minDay']?.text = '$value';
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
                    Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text('1일 숙박 요금          ', style: context.textTheme.krBody3)),
                    const SizedBox(width: 16),
                    Expanded(
                      child:
                      // InputWidget(
                      //   controller: controllers['price'],
                      //   format: NewTextInputType.price,
                      //   onChange: (value) {
                      //     if (value.isEmpty) return;
                      //     controllers['minPrice']?.text = numberFormatter(int.parse(value.replaceAll(',', '')) * (state.room.minCheckDay ?? 1));
                      //   },
                      //   helper: false,
                      //   maxLength: 9,
                      //   suffixWidget: Padding(
                      //     padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                      //     child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                      //   ),
                      // ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        maxLength: 9,
                        inputFormatters: FillTypes(format: NewTextInputType.price).inputFormat,
                        controller: controllers['price'],
                        decoration: InputDecoration(
                          counterText: '',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8),
                            child: Text('원', style: context.textTheme.krBody3.copyWith(color: black3)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) return;
                          controllers['minPrice']?.text = numberFormatter(int.parse(value.replaceAll(',', '')) * (state.room.minCheckDay ?? 1));
                          bloc.add(ChangeRoom(room: state.room.copyWith(oneDayAmount: int.parse(value.replaceAll(',', '')))));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text('최소기간 숙박 금액', style: context.textTheme.krBody3)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputWidget(
                        enabled: false,
                        controller: controllers['minPrice'],
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
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: RichText(
                  text: TextSpan(
                    text: '숙소의 이미지를 등록해주세요  ',
                    style: context.textTheme.krSubtitle1,
                    children: <TextSpan>[
                      TextSpan(text: '(최소 5개)', style: context.textTheme.krBody3.copyWith(color: black3)),
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => bloc.add(const PickImage(source: ImageSource.gallery)),
                      child: Container(
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: black5, width: 1)),
                        padding: const EdgeInsets.all(40),
                        child: const Icon(Icons.add, color: black3, size: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022', style: context.textTheme.krBody1.copyWith(color: black4)),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  '이미지는 jpg, png 형식만 등록 가능합니다.',
                                  style: context.textTheme.krBody1.copyWith(color: black4),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022', style: context.textTheme.krBody1.copyWith(color: black4)),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  '1520 x 960 사이즈의 이미지를 권장합니다.',
                                  style: context.textTheme.krBody1.copyWith(color: black4),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022', style: context.textTheme.krBody1.copyWith(color: black4)),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  '부적절한 이미지를 사용시 숙소 등록이 거부될 수 있습니다. (화질저하, 음란성 컨텐츠)',
                                  style: context.textTheme.krBody1.copyWith(color: black4),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022', style: context.textTheme.krBody1.copyWith(color: black4)),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  '길게 눌러 드래그하여 순서를 변경해주세요.',
                                  style: context.textTheme.krBody1.copyWith(color: black4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: EditReorderableListViewWidget(
                  images: state.images ?? [],
                  originImages: state.room.imageList,
                  onReorder: (value) => bloc.add(EditReorder(images: value)),
                  onRemove: (value) => bloc.add(EditRemove(deleteImage: state.images?[value],images: (state.images ?? [])..removeAt(value),index: value,)),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('숙소 상태', style: context.textTheme.krSubtitle1),
                    TextButton(onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builderContext) {
                            return BlocBuilder<RoomManagementBloc, RoomManagementState>(
                              bloc: bloc,
                            builder: (context, state) {
                              return Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                            Icons.close
                                        ),
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ),
                                    ),
                                    TitleText(title: '숙소 상태'),
                                    RadioListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: RoomStatus
                                                          .strToColor(
                                                          'ACTIVE')),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(RoomStatus.strToData(
                                                    'ACTIVE'),
                                                    style: context.textTheme
                                                        .krBody3),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text(RoomStatus.strToDescription(
                                                'ACTIVE'),
                                                style: context.textTheme.krBody1
                                                    .copyWith(color: black4)),
                                          ],
                                        ),
                                        value: 'ACTIVE',
                                        groupValue: state.room.status,
                                        onChanged: (value) {
                                          bloc.add(ChangeRoom(
                                              room: state.room.copyWith(
                                                  status: value.toString())));
                                        }),
                                    RadioListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:RoomStatus
                                                          .strToColor(
                                                          'STOP')),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(RoomStatus.strToData(
                                                    'STOP'),
                                                    style: context.textTheme
                                                        .krBody3),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text(RoomStatus.strToDescription(
                                                'STOP'),
                                                style: context.textTheme.krBody1
                                                    .copyWith(color: black4)),
                                          ],
                                        ),
                                        value: 'STOP',
                                        groupValue: state.room.status,
                                        onChanged: (value) {
                                          bloc.add(ChangeRoom(
                                              room: state.room.copyWith(
                                                  status: value.toString())));
                                        }),
                                    RadioListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: RoomStatus
                                                          .strToColor(
                                                          'DELETED')),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(RoomStatus.strToData(
                                                    'DELETED'),
                                                    style: context.textTheme
                                                        .krBody3),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text(RoomStatus.strToDescription(
                                                'DELETED'),
                                                style: context.textTheme.krBody1
                                                    .copyWith(color: black4)),
                                          ],
                                        ),
                                        value: 'DELETED',
                                        groupValue: state.room.status,
                                        onChanged: (value) {
                                          bloc.add(ChangeRoom(
                                              room: state.room.copyWith(
                                                  status: value.toString())));
                                        }),
                                  ],
                                ),
                              );
                            });
                        },
                      );
                    },
                        child: Text('수정', style: context.textTheme.krBody3.copyWith(decoration: TextDecoration.underline, color: gray0)))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: RoomStatus.strToColor(state.room.status)),
                        ),
                        const SizedBox(width: 16),
                        Text(RoomStatus.strToData(state.room.status), style: context.textTheme.krBody3)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(RoomStatus.strToDescription(state.room.status), style: context.textTheme.krBody1.copyWith(color: black4)),
                    )
                  ],
                ),
              ),
              LargeButton(
                text: '저장',
                onTap: () {
                  bloc.add(const Edit(data: {'updateType':'INFORMATION'}));
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

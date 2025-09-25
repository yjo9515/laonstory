import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(const Initial()),
      child: Scaffold(
        appBar: const CustomAppBar(
          textTitle: '탐색',
        ),
        body: BlocConsumer<SearchBloc, SearchState>(
          listener: (BuildContext context, SearchState state) {
            if(state.status == CommonStatus.route){
              context.push('/search', extra: state.searchList);
            }
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
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    InputWidget(
                      label: '숙박날짜',
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '숙박하실 날짜를 입력해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builderContext) {
                                return Container(
                                  height: 200,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (DateTime selectedDate) {
                                      context.read<SearchBloc>().add(SelectDate(
                                          date: selectedDate, type: 0));
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: TextFormField(
                            controller: TextEditingController(
                                text: DateFormat('yyyy  /  MM  /  dd   부터')
                                    .format(DateTime.parse(
                                        (state.checkIn ?? DateTime.now())
                                            .toString()))),
                            textAlign: TextAlign.center,
                            autofocus: false,
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              counterStyle: context.textTheme.krBody1
                                  .copyWith(color: black4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InputWidget(
                      label: '숙박 기간',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '숙박하실 기간을 입력해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        SwitchWidget(
                          overflow: true,
                          value: state.range ?? '일주일',
                          switches: range,
                          onChange: (value) {
                            context
                                .read<SearchBloc>()
                                .add(SelectRange(range: value));
                          },
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: (state.range == '직접 입력') ? 130 : 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builderContext) {
                                    return Container(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged:
                                            (DateTime selectedDate) {
                                          context.read<SearchBloc>().add(
                                              SelectDate(
                                                  date: selectedDate, type: 1));
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: TextFormField(
                                // initialValue: '2023  /  07  /  09   까지',
                                controller: TextEditingController(
                                    text: DateFormat('yyyy  /  MM  /  dd   까지')
                                        .format(DateTime.parse(
                                            (state.checkOut ?? DateTime.now())
                                                .toString()))),
                                textAlign: TextAlign.center,
                                autofocus: false,
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  counterStyle: context.textTheme.krBody1
                                      .copyWith(color: black4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InputWidget(
                      label: '숙박 인원',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '숙박하실 인원을 입력해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        CountWidget(
                            count: state.people,
                            onChanged: (value) {
                              context
                                  .read<SearchBloc>()
                                  .add(SelectCount(count: value));
                            }),
                      ],
                    ),
                    InputWidget(
                      label: '지역 찾기',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '원하는 지역을 선택해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        SwitchWidget(
                          overflow: true,
                          value: state.address ?? '전체',
                          switches: location,
                          onChange: (value) {
                            context
                                .read<SearchBloc>()
                                .add(SelectAddress(address: value));
                          },
                        ),
                      ],
                    ),
                    InputWidget(
                      label: '층수 찾기',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '원하는 숙소의 층수를 선택해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        SwitchWidget(
                          overflow: true,
                          value: state.floor ?? '전체',
                          switches: floor,
                          onChange: (value) {
                            context
                                .read<SearchBloc>()
                                .add(SelectFloor(floor: value));
                          },
                        ),
                      ],
                    ),
                    InputWidget(
                      label: '테마 찾기',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '찾는 테마를 선택해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        // Column(
                        //   children: state.themes.entries.map((e) {
                        //     return PickTileWidget(
                        //         facilityThemeList: e.value,
                        //         name: e.key ?? '',
                        //         onSelected: (select, value) {
                        //           logger.d(value);
                        //           context.read<SearchBloc>().add(SelectTheme(
                        //                 select,
                        //                 theme: value,
                        //               ));
                        //         });
                        //   }).toList(),
                        // ),
                        SwitchWidget(
                          overflow: true,
                          value: state.selectTheme?.name ?? '전체',
                          switches: state.themes['테마']
                                  ?.map((e) => e.name!)
                                  .toList() ??
                              [],
                          onChange: (value) {
                            for (var r in state.themes['테마']!) {
                              if (value == r.name) {
                                context.read<SearchBloc>().add(SelectTheme(
                                    theme: Facility(name: value, id: r.id)));
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    InputWidget(
                      label: '가격 범위',
                      labelSuffixWidget: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '원하는 숙소의 가격을 선택해주세요',
                            style: context.textTheme.krBody3
                                .copyWith(color: black3),
                          )),
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 88,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 130,
                                      child: InputWidget(
                                        format: TextInputType.number,
                                        controller: start,
                                        hint:
                                            '${NumberFormat('###,###,###,###').format(state.priceRange.start)}',
                                        nonePadding: true,
                                        helper: false,
                                        price: true,
                                        onChange: (value) {
                                          final numValue = int.tryParse(
                                              value.replaceAll(
                                                  ',', '')); // 쉼표를 제거하고 숫자로 변환
                                          if (numValue != null) {
                                            // 입력된 값이 숫자인 경우에만 포맷팅 적용
                                            final formattedValue =
                                                NumberFormat('###,###,###')
                                                    .format(numValue); // 포맷팅 적용
                                            start.value = TextEditingValue(
                                              text: formattedValue,
                                              // 포맷팅된 값을 컨트롤러에 할당
                                              selection: TextSelection
                                                  .fromPosition(TextPosition(
                                                      offset: formattedValue
                                                          .length)), // 커서 위치 조정
                                            );
                                          }
                                        },
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 32),
                                      child: Center(
                                          child: Text('-',
                                              style:
                                                  context.textTheme.krBody3))),
                                  SizedBox(
                                      width: 130,
                                      child: InputWidget(
                                        controller: end,
                                        hint: NumberFormat('###,###,###,###')
                                            .format(state.priceRange.end),
                                        format: TextInputType.number,
                                        nonePadding: true,
                                        helper: false,
                                        price: true,
                                        onChange: (value) {
                                          final numValue = int.tryParse(
                                              value.replaceAll(
                                                  ',', '')); // 쉼표를 제거하고 숫자로 변환
                                          if (numValue != null) {
                                            // 입력된 값이 숫자인 경우에만 포맷팅 적용
                                            final formattedValue =
                                                NumberFormat('###,###,###')
                                                    .format(numValue); // 포맷팅 적용
                                            end.value = TextEditingValue(
                                              text: formattedValue,
                                              // 포맷팅된 값을 컨트롤러에 할당
                                              selection: TextSelection
                                                  .fromPosition(TextPosition(
                                                      offset: formattedValue
                                                          .length)), // 커서 위치 조정
                                            );
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ),
                            RangeSliderWidget(
                              onChanged: (value) {
                                context
                                    .read<SearchBloc>()
                                    .add(ChangeRange(value));
                                start.value = TextEditingValue(
                                    text: NumberFormat('###,###,###')
                                        .format(state.priceRange.start.toInt())
                                        .toString());
                                end.value = TextEditingValue(
                                    text: NumberFormat('###,###,###')
                                        .format(state.priceRange.end.toInt())
                                        .toString());
                              },
                              currentRangeValues: state.priceRange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 32),
                        child: LargeButton(
                          text: '찾기',
                          onTap: () {
                            checkInputData(context, controllers: [],
                                onDone: () {
                              // if(state.range == '일주일' || state.range == null){
                              //   if(state.checkIn != null){
                              //     state.checkOut = state.checkIn!.add(Duration(days: 6));
                              //   }
                              //
                              // }
                              (state.people == 0)
                                  ? AlertDialog.adaptive(
                                      title: const Text(
                                        '알림',
                                      ),
                                      content: Text(
                                        '인원은 1명 이상부터 선택 가능합니다.',
                                      ),
                                      actions: <Widget>[
                                        adaptiveAction(
                                          context: context,
                                          onPressed: () =>
                                              Navigator.pop(context, '확인'),
                                          child: const Text('확인'),
                                        ),
                                      ],
                                    )
                                  : context
                                      .read<SearchBloc>()
                                      .add(SearchRoom(body: {
                                        'accommodationPeople':
                                            state.people ?? 0,
                                        'addressType': state.address == '제주시' ? 'JEJU': state.address == '서귀포시' ? 'SEOGWIPO' : 'ALL'  ,
                                        'checkIn': DateFormat('yyyy-MM-dd').format(state!.checkIn!),
                                        'checkOut': DateFormat('yyyy-MM-dd').format(state!.checkOut!),
                                        'startAmount':
                                            state.priceRange.start.toInt(),
                                        'endAmount':
                                            state.priceRange.end.toInt(),
                                        'floorType': state.floor == '중~고층' ? 'LOW' : state.floor == '고층 이상' ? 'HIGH' : 'ALL',
                                        'facilityThemeId': state.selectTheme?.id
                                      }));
                            });
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static const range = ['일주일', '보름', '한달', '한 달 이상', '직접 입력'];
  static const location = ['전체', '제주시', '서귀포시'];
  static const floor = ['전체', '중~고층', '고층 이상'];
  static const themes = [
    '선택안함',
    '캠핑',
    '초소형',
    '아기와',
    '펜션',
    '편안한',
    '노래방',
    '화원',
    '숲속',
    '바닷속',
    '감귤',
    '미술관'
  ];
}

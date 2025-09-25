import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/room_event.dart';
import '../bloc/room_management_bloc.dart';
import '../bloc/room_state.dart';
import 'room_widget.dart';

class RoomThemesWidget extends StatelessWidget {
  const RoomThemesWidget({Key? key, required this.bloc}) : super(key: key);

  final RoomManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomManagementBloc, RoomManagementState>(
      bloc: bloc,
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: RichText(
                  text: TextSpan(
                    text: '숙소의 테마를 알려 주세요  ',
                    style: context.textTheme.krSubtitle1,
                    children: <TextSpan>[
                      TextSpan(text: '(최대 8개)', style: context.textTheme.krBody3.copyWith(color: black3)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\u2022', style: context.textTheme.krBody3),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text('오션뷰: 숙소 내부에서 보이는 오션뷰 이미지를 필수로 등록해야 합니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\u2022', style: context.textTheme.krBody3),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text('바다근처: 바다에서 1~1.5km (성인 걸음 기준 도보 15분 이내)에 위치한 숙소', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\u2022', style: context.textTheme.krBody3),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text('프리미엄: 고가의 가구 및 자재(대리석 등)를 활용하여 지어진 숙소', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\u2022', style: context.textTheme.krBody3),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text('워케이션: 숙소 내 서재 혹은 사무용 책상이 있는 숙소 ( 유/무선 인터넷필수 )', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: state.themes.entries.map((e) {
                    return IconItemWidget(bloc: bloc, selectedThemeList : state.selectedThemes , facilityThemeList: e.value, name: e.key ?? '', onSelected: (select, value) => bloc.add(SelectFacility(select, theme: value, isInitial: false)));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: LargeButton(
                  onTap: () {
                    bloc.add(Edit(data: {'updateType':'THEME'}));
                  },
                  text: '저장',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

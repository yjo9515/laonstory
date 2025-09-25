part of '../ui/add_room_page.dart';

class AddRoomFifthPage extends StatelessWidget {
  const AddRoomFifthPage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
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
                    begin: 0.5,
                    end: 0.625,
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
                          TextSpan(text: '(5/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
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
                              return IconItemWidget(facilityThemeList: e.value, name: e.key ?? '', onSelected: (select, value) => bloc.add(SelectFacility(select, theme: value)));
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            onTap: () {
                              context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '6'});
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

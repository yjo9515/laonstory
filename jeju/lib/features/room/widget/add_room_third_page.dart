part of '../ui/add_room_page.dart';

class AddRoomThirdPage extends StatelessWidget {
  const AddRoomThirdPage({Key? key, required this.bloc}) : super(key: key);

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
                    begin: 0.250,
                    end: 0.375,
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
                          TextSpan(text: '(3/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
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
                            '숙소 시설 정보를 알려 주세요 ',
                            style: context.textTheme.krSubtitle1,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: Text(
                              '숙박업이 아닌 비사업자/임대 사업자의 경우 욕실 용품 제공이 불가합니다 (샴푸, 린스, 화장지, 수건, 칫솔, 비누, 치약, 바디워시 등)',
                              style: context.textTheme.krBody3,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: state.facilities.entries.map((e) {
                              return ['취사', '세탁','인터넷/TV', '주차', '가구', '냉/난방'].indexWhere((element) => element == e.key!) != -1
                                  ? IconItemWidget(facilityThemeList: e.value, name: e.key ?? '', onSelected: (select, value) => bloc.add(SelectFacility(select, facility: value)))
                                  : Container();
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            onTap: () {
                              context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '4'});
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

part of '../ui/add_room_page.dart';

class AddRoomSixthPage extends StatelessWidget {
  const AddRoomSixthPage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

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
                    begin: 0.625,
                    end: 0.750,
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
                          TextSpan(text: '(6/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
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
                            '숙소의 설명을 적어 주세요  ',
                            style: context.textTheme.krSubtitle1,
                          ),
                        ),
                        InputWidget(
                          controller: nameController,
                          labelSuffixWidget: Container(margin: const EdgeInsets.only(left: 16), child: Text('숙소이름은 나중에도 변경할 수 있어요', style: context.textTheme.krBody3.copyWith(color: black3))),
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
                          controller: descriptionController,
                          labelSuffixWidget: Container(margin: const EdgeInsets.only(left: 16), child: Text('특징과 장점, 주의사항을 입력해주세요', style: context.textTheme.krBody3.copyWith(color: black3))),
                          label: '숙소 설명',
                          hint: '숙소 설명을 아낌없이 적어주세요.',
                          format: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onChange: (value) => bloc.add(ChangeRoom(room: state.room.copyWith(description: value))),
                          maxLength: 1500,
                          count: true,
                          minLines: 10,
                          maxLines: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('예시)', style: context.textTheme.krBody3),
                                ],
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text('저희 숙소를 소개합니다.🌿 마당이 있는 아담한 단독 주택', style: context.textTheme.krBody3),
                              //   ],
                              // ),
                              Text('저희 숙소를 소개합니다.🌿 마당이 있는 아담한 단독 주택', style: context.textTheme.krBody3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\u2022', style: context.textTheme.krBody3),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text('따뜻한 느낌의 실내, 아기자기한 마당을 단독으로 사용하실 수 있어요.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
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
                                    child: Text('조용한 동네로 동물 울음(닭, 개)소리, 단독의 장점인 층간 소음도 없습니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
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
                                    child: Text('주택 밀집지역으로 인원이 많아지면 소음의 원인이 되어 유의 부탁드립니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('📍 위치 및 주변 환경', style: context.textTheme.krBody3),
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
                                    child: Text('숙소 위치는 서울에서 시외버스 이용 시 (동서울>속초) "속초 중학교" 중간 하차 하시면 도보 5분 거리입니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
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
                                    child: Text('대형마트, 편의점, 병원 등 생활 편의 시설이 잘 갖추어져 있습니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
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
                                    child: Text('도보로 이용 가능한 맛집, 관광지가 주변에 위치합니다.', textAlign: TextAlign.left, softWrap: true, style: context.textTheme.krBody3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            onTap: () => checkInputData(context,
                                controllers:
                                // kDebugMode
                                //     ? []
                                //     :
                                [
                                        (nameController.text, '숙소 이름을 입력해 주세요.'),
                                        (descriptionController.text, '숙소 설명을 입력해 주세요.'),
                                      ], onDone: () {
                              context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '7'});

                            }),
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

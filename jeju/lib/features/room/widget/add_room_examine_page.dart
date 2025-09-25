part of '../ui/add_room_page.dart';

class AddRoomExaminePage extends StatelessWidget {
  const AddRoomExaminePage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
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
          context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': 'done'});
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
                Hero(
                  tag: 'text',
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        text: '마지막으로 숙소 검토하기  ',
                        style: context.textTheme.krSubtitle1,
                        children: <TextSpan>[
                          TextSpan(text: '미리보기', style: context.textTheme.krSubtitle1.copyWith(color: black3)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RoomDetailWidget(room: state.room, imageList: state.images),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            onTap: () {
                              bloc.add(const Add());
                            },
                            text: '숙소 등록',
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

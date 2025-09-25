part of '../ui/add_room_page.dart';

class AddRoomSeventhPage extends StatelessWidget {
  const AddRoomSeventhPage({Key? key, required this.bloc}) : super(key: key);

  final AddRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomBloc, AddRoomState>(
      listener: (BuildContext context, AddRoomState state) {
        if(state.status == CommonStatus.failure){
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
        }
      },
      bloc: bloc,
      buildWhen: (previous, current) => previous.images != current.images,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Hero(
                  tag: 'progress',
                  child: ProgressWidget(
                    begin: 0.750,
                    end: 0.875,
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
                          TextSpan(text: '(7/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
                        ],
                      ),
                    ),
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
                        onTap: () => bloc.add(const PickImage(source: ImageSource.gallery,multiImage: true)),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: black5, width: 1)),
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
                // Column(
                //   children:state.images!.map((e) => Text('${e.name}'),).toList()
                //
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ReorderableListViewWidget(
                      images: state.images ?? [],
                      onReorder: (value) => bloc.add(Reorder(images: value,)),
                      onRemove: (value) => bloc.add(Remove(images: (state.images ?? [])..removeAt(value),paths: (state.paths ?? [])..removeAt(value))),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //     child: ReorderableListViewWidget(
                //       images: state.images ?? [],
                //       onReorder: (value) => bloc.add(Reorder(images: value)),
                //       onRemove: (value) => bloc.add(Remove(images: (state.images ?? [])..removeAt(value))),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: LargeButton(
                    onTap: () {
                      if(state.images != null){
                        if(state.images!.length <= 4){
                          bloc.add(Error(LogicalException(message: '최소 5개의 이미지를 등록해주세요')));
                        }else{
                          context.pushNamed('room', extra: bloc, pathParameters: {'path': 'add'}, queryParameters: {'step': '8'});
                        }
                      }else{
                        bloc.add(Error(LogicalException(message: '최소 5개의 이미지를 등록해주세요')));
                      }


                    },
                    text: '다음',
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

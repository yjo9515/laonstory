part of '../ui/add_room_page.dart';

class AddRoomFirstPage extends StatelessWidget {
  const AddRoomFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final detailAddressController = TextEditingController();

    return BlocBuilder<AddRoomBloc, AddRoomState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            tag: 'add_room',
            backButton: true,
            textTitle: '숙소 등록',
            actions: [],
          ),
          body: Column(
            children: [
              const Hero(
                tag: 'progress',
                child: ProgressWidget(
                  begin: 0,
                  end: 0.125,
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
                        TextSpan(text: '(1/8)', style: context.textTheme.krSubtitle1.copyWith(color: mainJeJuBlue)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        InputWidget(
                          label: '숙소 주소를 알려 주세요',
                          controller: addressController,
                          hint: '주소를 입력해 주세요',
                          format: TextInputType.streetAddress,
                          onChange: (value) => context.read<AddRoomBloc>().add(const ReTypeAddress()),
                          suffixWidget: IconButton(
                            onPressed: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              context.read<AddRoomBloc>().add(SearchAddress(address: addressController.text));
                            },
                            icon: SvgImage('assets/icons/ic_search.svg', width: 24, color: context.colorScheme.iconColor),
                          ),
                          helper: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: (state.addressStatus == CommonStatus.success || state.addressStatus == CommonStatus.failure) && (state.documents?.isEmpty ?? true) ? 24 : 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          margin: const EdgeInsets.only(top: 8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '검색된 주소가 없습니다.',
                              style: context.textTheme.krBottom.copyWith(color: Colors.red),
                            ),
                          ),
                        ),

                        AnimatedContainer(
                            alignment: Alignment.centerLeft,
                            margin: state.documents?.isEmpty ?? true ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            duration: const Duration(milliseconds: 300),
                            height: state.documents?.isEmpty ?? true ? 0 : ((state.documents ?? []).take(5).length * 40),
                            child: SingleChildScrollView(
                              child: Column(
                                children: (context.read<AddRoomBloc>().state.documents ?? []).take(5).map((document) {
                                  return SizedBox(
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            addressController.text = document.roadAddress?.addressName ?? document.address!.addressName!;
                                            context.read<AddRoomBloc>().add(SelectAddress(index: (state.documents ?? []).indexWhere((element) => element == document)));
                                          },
                                          child: Text(document.roadAddress?.addressName ?? document.address!.addressName!, style: context.textTheme.krBody1.copyWith(color: black3))));
                                }).toList(),
                              ),
                            )),

                        const SizedBox(height: 8),
                        InputWidget(controller: detailAddressController, hint: '상세주소를 입력해 주세요.', format: TextInputType.text),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: AspectRatio(
                            aspectRatio: 1,
                            // child: Platform.isAndroid ? const AddGoogleMapWidget() : const AddAppleMapWidget(),
                            child: Platform.isAndroid ? const AddNaverMapWidget() : const AddAppleMapWidget(),
                          ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                          width: MediaQuery.of(context).size.width,
                          child:
                          DropdownMenuWidget<String>(

                            filled: false,
                            hint: '소유 구분값을 선택해 주세요',
                            dropdownList: const [
                              '부동산 명의자에게 임대운영에 동의를 구한 경우',
                              '호스트가 집주인일 경우(부동산 명의자)',
                            ],
                            onChanged: (value) {
                              context.read<AddRoomBloc>().add(CheckOwner(owner: value));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            text: '다음',
                            onTap: () =>
                                checkInputData(context,
                                controllers:
                                // kDebugMode
                                //     ? []
                                //     :
                                [
                                        (addressController.text, '주소를 입력해 주세요.'),
                                        (detailAddressController.text, '상세주소를 입력해 주세요.'),
                                        (state.document?.addressName, '검색된 주소가 없습니다.'),
                                        (state.owner, '숙소 소유 구분을 선택해주세요.'),
                                      ], onDone: () {
                              context.pushNamed('room', extra: context.read<AddRoomBloc>(), pathParameters: {'path': 'add'}, queryParameters: {'step': '2'});
                            }),
                            // context.pushNamed('room', pathParameters: {'path': 'add'},extra: context.read<AddRoomBloc>(), queryParameters: {'step': 'done'})
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

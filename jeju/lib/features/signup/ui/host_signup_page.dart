import 'dart:async';
import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/signup/bloc/host_signup_bloc.dart';

import '../../../core/core.dart';
import '../bloc/host_signup_state.dart';

class HostSignupPageFirst extends StatelessWidget {
  const HostSignupPageFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final subPhoneController = TextEditingController();
    final accountController = TextEditingController();
    String? bank;
    String? businessClassification;
    String? calculateClassification;



    return BlocProvider(
        create: (context) => HostSignUpBloc()..add(const Initial()),
        child: BlocConsumer<HostSignUpBloc, HostSignUpState>(
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
              context.push('/signup/host/2');
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: const CustomAppBar(
                backButton: true,
                textTitle: '호스트 정보 입력',
                actions: [],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    const Hero(
                      tag: 'progress',
                      child: ProgressWidget(
                        begin: 0,
                        end: 0.5,
                      ),
                    ),
                    Hero(
                      tag: 'text',
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: RichText(
                          text: TextSpan(
                            text: '숙소 등록을 위하여 호스트 정보를 알려주세요 ',
                            style: context.textTheme.krSubtitle1,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '(1/2)',
                                  style: context.textTheme.krSubtitle1
                                      .copyWith(color: mainJeJuBlue)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InputWidget(
                                label: '이름',
                                controller: nameController,
                                hint: '실명을 입력해 주세요.',
                                onChange: (value) {
                                context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(name: value)));
                                // emailController.text = value;
                                },
                            ),
                            InputWidget(
                                onChange: (value) {
                                  context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(email: value)));
                                  // emailController.text = value;
                                },
                                label: '이메일 주소',
                                controller: emailController,
                                hint: '이메일 주소를 입력해 주세요.',
                                format: TextInputType.emailAddress),
                            InputWidget(
                              label: '휴대폰 번호',
                              controller: phoneController,
                              hint: '휴대폰 번호를 입력해 주세요.',
                              format: TextInputType.phone,
                              onChange: (value) {
                                context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(phone: value)));
                              },
                            ),
                            InputWidget(
                              label: '비상 연략 휴대폰 번호',
                              controller: subPhoneController,
                              hint: '비상 연락처 번호를 입력해 주세요.',
                              format: TextInputType.phone,
                              onChange: (value) {
                                context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(subPhone: value)));
                                // subPhoneController.text = value;
                              },
                            ),
                            InputWidget(
                              label: '수입금/출금 계좌정보',
                              format: NewTextInputType.accountNumber,
                              controller: accountController,
                              hint: '계좌번호를 입력해 주세요',
                              onChange: (value) {
                                context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(account: value)));
                                // accountController.text = value;
                              },
                              dropdownWidget: DropdownMenuWidget<String>(
                                hint: '선택',
                                dropdownList: const [
                                  '우리은행',
                                  '국민은행',
                                ],
                                onChanged: (value) {
                                  context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(bank: value)));
                                },
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              margin: const EdgeInsets.only(bottom: 32),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('호스트와 정산 계좌주가 동일해야합니다.',
                                      style: context.textTheme.krBody1
                                          .copyWith(color: Colors.orange))),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Text('호스트 사업자 구분',
                                      style: context.textTheme.krSubtitle1),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              margin: const EdgeInsets.only(bottom: 8),
                              width: double.infinity,
                              child: DropdownMenuWidget<String>(
                                filled: false,
                                hint: '사업자 구분을 선택해 주세요',
                                dropdownList: const [
                                  '임대 사업자',
                                  '비사업자',
                                  '숙박 사업자'
                                ],
                                onChanged: (value) {
                                  // businessClassification = value;
                                  String? r;
                                  switch(value){
                                    case '임대 사업자':
                                      r = 'LODGING';
                                    case '비사업자':
                                      r = 'NON_BUSINESS';
                                    case '숙박 사업자':
                                      r = 'RENTAL_BUSINESS';
                                  }
                                  context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(businessClassification: r)));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Text('정산 구분',
                                      style: context.textTheme.krSubtitle1),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              margin: const EdgeInsets.only(bottom: 8),
                              width: double.infinity,
                              child: DropdownMenuWidget<String>(
                                filled: false,
                                hint: '정산 구분을 선택해 주세요',
                                dropdownList: const ['일반 과제', '간이/명세', '숙박 중개'],
                                onChanged: (value) {
                                  String? r;
                                  switch(value){
                                    case '일반 과제':
                                      r = 'GENERAL';
                                    case '간이/명세':
                                      r = 'LODGING_BROKER';
                                    case '숙박 중개':
                                      r = 'TAX_FREE';
                                  }
                                  context.read<HostSignUpBloc>().add(ChangeHostSignUp(dto: state.dto.copyWith(calculateClassification: r)));
                                  // calculateClassification = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Text('사업자등록증 첨부',
                                      style: context.textTheme.krSubtitle1),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 77,
                                    child: InputWidget(
                                      nonePadding: true,
                                      enabled: false,
                                      controller: TextEditingController(),
                                      hint: '파일 찾기',
                                    ),
                                  ),
                                  Expanded(
                                      flex: 23,
                                      child: InkWell(
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxHeight: 60),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: black5, width: 0.5),
                                              color: context
                                                  .colorScheme.activeButton,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: SizedBox(
                                            child: Center(
                                              child: Text(
                                                '찾기',
                                                style: context
                                                    .textTheme.krButton1
                                                    .copyWith(
                                                        color: white,
                                                        fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<HostSignUpBloc>()
                                              .add(SearchFile());
                                        },
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 16),
                              child: Container(
                                height: 55,
                                child: ListView.builder(
                                  itemCount: context
                                      .read<HostSignUpBloc>()
                                      .state
                                      .businessLicense
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.horizontal,
                                      child: ListTile(
                                        dense: true,
                                        title: Text(context
                                            .read<HostSignUpBloc>()
                                            .state
                                            .fileName[index]),
                                        trailing: Container(
                                          width: 30,
                                          height: 30,
                                          padding: const EdgeInsets.all(0),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: black5),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<HostSignUpBloc>()
                                                  .add(Remove(
                                                      files: context
                                                          .read<
                                                              HostSignUpBloc>()
                                                          .state
                                                          .businessLicense!,
                                                      fileName: context
                                                          .read<
                                                              HostSignUpBloc>()
                                                          .state
                                                          .fileName));
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // :Container(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: LargeButton(
                                text: '다음',
                                onTap: () {

                                  try{

                                    // context.read<HostSignUpBloc>().add(
                                    //     SecondHostSignUp(
                                    //         dto: state.dto.copyWith(
                                    //             name: nameController.text,
                                    //             account: accountController.text,
                                    //             bank: bank,
                                    //             email: emailController.text,
                                    //             phone: phoneController.text,
                                    //             subPhone: subPhoneController.text,
                                    //             businessClassification: businessClassification,
                                    //             calculateClassification: calculateClassification
                                    //         ),
                                    //         businessLicense:context
                                    //             .read<
                                    //             HostSignUpBloc>()
                                    //             .state
                                    //             .businessLicense!.single  ));
                                    context.read<HostSignUpBloc>().add(
                                        SecondHostSignUp());


                                    // context.push('/room/add?step=1');
                                  } catch (e){
                                    logger.e(e);
                                    context.read<HostSignUpBloc>().add(const Error(LogicalException(message: '빈 값이 있는지 체크해주세요')));
                                  }


                                },
                              ),
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
        ));
  }
}

class HostSignupPageSecond extends StatelessWidget {
  const HostSignupPageSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backButton: true,
        textTitle: '호스트 정보 입력',
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Hero(
              tag: 'progress',
              child: ProgressWidget(begin: 0.5, end: 1),
            ),
            Hero(
              tag: 'text',
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  text: TextSpan(
                    text: '숙소 등록을 위해 호스트 정보를 등록해 주세요 ',
                    style: context.textTheme.krSubtitle1,
                    children: <TextSpan>[
                      TextSpan(
                          text: '(2/2)',
                          style: context.textTheme.krSubtitle1
                              .copyWith(color: mainJeJuBlue)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Text('실명인증', style: context.textTheme.krSubtitle1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                        '제주살이는 최초 숙소 등록시 실명인증을 실행합니다 .원하시는 인증방법을 선택해 주세요.',
                        style: context.textTheme.krBody3),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(40),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      spacing: 32,
                      runSpacing: 32,
                      children: [
                        InkWell(
                          onTap: () {
                            // context.pushReplacement('/signup/host/done');
                            context.pushReplacement('/auth');
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/images/pass_icon.png',
                                  width: 100),
                              Text('PASS 인증', style: context.textTheme.krBody3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HostSignUpDonePage extends StatefulWidget {
  const HostSignUpDonePage({Key? key}) : super(key: key);

  @override
  State<HostSignUpDonePage> createState() => _HostSignUpDonePageState();
}

class _HostSignUpDonePageState extends State<HostSignUpDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to
        .timer(time: 3)
        .timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.go('/');
      context.push('/room/add?step=1');
    }).listen((event) {
      if (event <= 0) {
        context.go('/');
        context.push('/room/add?step=1');
      }
      setState(() {
        second = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backButton: true,
        textTitle: '호스트 정보 입력',
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Hero(
              tag: 'progress',
              child: ProgressWidget(begin: 0.5, end: 1),
            ),
            Hero(
              tag: 'text',
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  text: TextSpan(
                    text: '숙소 등록을 위해 호스트 정보를 등록해 주세요 ',
                    style: context.textTheme.krSubtitle1,
                    children: <TextSpan>[
                      TextSpan(
                          text: '(2/2)',
                          style: context.textTheme.krSubtitle1
                              .copyWith(color: mainJeJuBlue)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Text('실명인증', style: context.textTheme.krSubtitle1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                        '제주살이는 최초 숙소 등록시 실명인증을 실행합니다 .원하시는 인증방법을 선택해 주세요.',
                        style: context.textTheme.krBody3),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(40),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      spacing: 32,
                      runSpacing: 32,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushReplacement('/signup/host/done');
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/images/pass_icon.png',
                                  width: 100),
                              Text('PASS 인증', style: context.textTheme.krBody3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

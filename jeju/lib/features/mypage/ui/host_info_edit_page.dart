import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../bloc/host_info_bloc.dart';
import '../bloc/host_info_state.dart';

class HostInfoEditPage extends StatelessWidget {
  const HostInfoEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final emergencyPhoneController = TextEditingController();
    final accountController = TextEditingController();
    String? bank;
    String? businessClassification;
    String? calculateClassification;

    return Scaffold(
      appBar: const CustomAppBar(
        tag: 'host_info',
        textTitle: '호스트 정보',
        backButton: true,
      ),

      body: BlocProvider(create: (context) => HostInfoBloc()..add(Initial()),
          child: BlocConsumer<HostInfoBloc, HostInfoState>(
          listener: (context,state){
            if (state.status == CommonStatus.success) {
              nameController.text = state.dto.name??'';
              emailController.text = state.dto.email??'';
              nameController.text = state.dto.name??'';
              phoneController.text = state.dto.phone??'';
              emergencyPhoneController.text = state.dto.subPhone??'';
              accountController.text = state.dto.account??'';
            }else if (state.status == CommonStatus.failure){
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
            }else if (state.status == CommonStatus.ready){
              context.push('/info/host/edit/done');
            }
          },
          builder:(context, state){
            return SingleChildScrollView(
              child: Column(
                children: [
                  InputWidget(
                    label: '이름',
                    controller: nameController,
                    onChange: (value){
                      context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(name: value)));
                    },
                  ),
                  InputWidget(
                    label: '이메일 주소',
                    controller: emailController,
                    textInputAction: TextInputAction.done,
                    format: TextInputType.emailAddress,
                    onChange: (value){
                      logger.d(value);
                      context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(email: value)));
                    },
                  ),
                  InputWidget(
                    label: '휴대폰 번호',
                    controller: phoneController,
                    textInputAction: TextInputAction.done,
                    format: TextInputType.phone,
                    onChange: (value){
                      context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(phone: value)));
                    },
                  ),
                  InputWidget(
                    label: '비상 연락 휴대폰 번호',
                    controller: emergencyPhoneController,
                    textInputAction: TextInputAction.done,
                    format: TextInputType.phone,
                    onChange: (value){
                      context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(subPhone: value)));
                    },
                  ),
                  InputWidget(
                    label: '수입금/출금 계좌정보',
                    format: NewTextInputType.accountNumber,
                    controller: accountController,
                    hint: '계좌번호를 입력해 주세요',
                    onChange: (value) {
                      context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(account: value)));
                    },
                    dropdownWidget: DropdownMenuWidget<String>(
                      hint: '선택',
                      dropdownList: const [
                        '우리은행',
                        '국민은행',
                      ],
                      onChanged: (value) {
                        context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(bank: value)));
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Align(alignment: Alignment.centerLeft, child: Text('호스트와 정산 계좌주가 동일해야합니다.', style: context.textTheme.krBody1.copyWith(color: Colors.orange))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Text('호스트 사업자 구분', style: context.textTheme.krSubtitle1),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        String? r;
                        switch(value){
                          case '임대 사업자':
                            r = 'LODGING';
                          case '비사업자':
                            r = 'NON_BUSINESS';
                          case '숙박 사업자':
                            r = 'RENTAL_BUSINESS';
                        }
                        context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(businessClassification: r)));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Text('정산 구분', style: context.textTheme.krSubtitle1),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        context.read<HostInfoBloc>().add(ChangeHostSignUp(dto:state.dto.copyWith(calculateClassification: r)));
                      },
                    ),
                  ),
                  TitleText(title: '사업자등록증/신분증 첨부'),
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
                                    .read<HostInfoBloc>()
                                    .add(SearchFile());
                              },
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 0),
                    child: Container(
                      height: 55,
                      child: ListView.builder(
                        itemCount: context
                            .read<HostInfoBloc>()
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
                                  .read<HostInfoBloc>()
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
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HostInfoBloc>()
                                        .add(Remove(
                                        files: context
                                            .read<
                                            HostInfoBloc>()
                                            .state
                                            .businessLicense!,
                                        fileName: context
                                            .read<
                                            HostInfoBloc>()
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: LargeButton(
                      text: '변경 승인 요청',
                      onTap: () {
                          context.read<HostInfoBloc>().add(
                              SecondHostSignUp());
                        // context.push('/info/host/edit/done');


                      },
                    ),
                  )
                ],
              ),
            );

          })),
    );
  }
}
class HostInfoEditDonePage extends StatefulWidget {
  const HostInfoEditDonePage({Key? key}) : super(key: key);

  @override
  State<HostInfoEditDonePage> createState() => _HostInfoEditDonePageState();
}

class _HostInfoEditDonePageState extends State<HostInfoEditDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to.timer(time: 3).timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.go('/');
      // context.go('/signup/host/1');

    }).listen((event) {
      if (event <= 0) {
        context.go('/');
        // context.go('/signup/host/1');
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
      backgroundColor: context.colorScheme.activeButton,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('', style: context.textTheme.krBody5.copyWith(color: white)),
              const Spacer(),
              const SizedBox(height: 32),
              Text('변경 승인 요청이 완료 되었습니다.', style: context.textTheme.krPoint1.copyWith(color: white)),
              const SizedBox(height: 56),
              Text('영업일 내 2~3일 내에 승인 결과를 알려드립니다.\n변경요청이 승인되면 알림을 드릴게요!', style: context.textTheme.krBody3.copyWith(color: white),textAlign: TextAlign.center,),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('${second}초뒤 호스트 홈으로', style: context.textTheme.krBody5.copyWith(color: white))),
            ],
          ),
        ),
      ),
    );
  }
}

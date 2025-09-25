import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:union_management/common/widget/edit_text_field_widget.dart';
import 'package:union_management/login/bloc/login_cubit.dart';

import '../../common/enum/enums.dart';
import '../../common/style.dart';
import '../../global/bloc/global_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode focusNodeID = FocusNode();
  final FocusNode focusNodePW = FocusNode();
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  bool hasFocus = false;

  @override
  void initState() {
    focusNodeID.addListener(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          hasFocus = focusNodeID.hasFocus || focusNodePW.hasFocus;
        });
      });
    });
    focusNodePW.addListener(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          hasFocus = focusNodeID.hasFocus || focusNodePW.hasFocus;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (globalContext, globalState) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              switch (state.status) {
                case CommonStatus.initial:
                  break;
                case CommonStatus.failure:
                  IconDialog.show(context: context, title: '', content: state.message, iconType: AlertIconType.alert, iconTitle: true);
                  break;

                case CommonStatus.loading:
                  break;
                case CommonStatus.success:
                  BlocProvider.of<GlobalBloc>(context).add(InitialToken(context));
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    Color(0xff5292F1),
                    Color(0xff2A74E3),
                  ])),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          const begin = 0.0;
                          const end = 1.0;
                          final tween = Tween(begin: begin, end: end);
                          return SizeTransition(sizeFactor: animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut))), child: child);
                        },
                        duration: const Duration(milliseconds: 300),
                        child: hasFocus
                            ? Container()
                            : Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 96),
                                    SvgPicture.asset('assets/icons/ic_logo.svg'),
                                    const SizedBox(height: 16),
                                    Hero(tag: 'title', child: SvgPicture.asset('assets/icons/title_icon.svg')),
                                    const SizedBox(height: 64),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 32),
                      EditTextFieldWidget(
                        focusNode: focusNodeID,
                        label: '휴대폰번호',
                        controller: idController,
                        hint: '휴대폰번호를 입력해주세요',
                        isPhone: true,
                        textColor: white,
                        noneBorder: true,
                        fillColor: white.withOpacity(0.2),
                      ),
                      const SizedBox(height: 24),
                      EditTextFieldWidget(
                        focusNode: focusNodePW,
                        label: '비밀번호',
                        controller: pwController,
                        isPassword: true,
                        regexPassword: false,
                        noneBorder: true,
                        textColor: white,
                        hint: '비밀번호(생년월일 6자리)를 입력해주세요',
                        fillColor: white.withOpacity(0.2),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            context.read<LoginCubit>().login(idController.text, pwController.text);
                          },
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(
                              "로그인",
                              style: textTheme(context).krTitle2.copyWith(color: primary),
                            )),
                          )),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

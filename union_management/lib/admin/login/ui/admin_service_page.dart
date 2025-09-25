import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/widget/edit_text_field_widget.dart';
import '../../widget/binding.dart';
import '../bloc/login_bloc.dart';

class AdminServicePage extends StatelessWidget {
  const AdminServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final pwController = TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (prev, state) => prev.status != state.status,
          listener: (context, state) {
            switch (state.status) {
              case CommonStatus.initial:
                break;
              case CommonStatus.loading:
                break;
              case CommonStatus.success:
                TextInput.finishAutofillContext();
                context.pushReplacementNamed('/main');
                break;
              case CommonStatus.failure:
                IconDialog.show(
                    context: context,
                    content: state.message ?? "오류가 발생하였습니다.",
                    width: 300,
                    iconTitle: true,
                    buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
                    title: '');
                break;
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 144, horizontal: 80),
                width: 1128,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: white),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "로그인",
                            style: textTheme(context).krTitle2,
                          )),
                      const SizedBox(height: 32),
                      // SvgPicture.asset('assets/images/app_bar_image.svg', height: 80),
                      const SizedBox(height: 64),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(controller: emailController, hint: '', label: '이메일', enabled: true, isEmail: true, errorWidget: const SizedBox(height: 24)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(controller: pwController, hint: '', label: '비밀번호', enabled: true, isPassword: true, errorWidget: const SizedBox(height: 24)),
                      ),
                      const SizedBox(height: 64),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 240),
                            child: LargeButtonWidget(
                                text: '로그인',
                                onClick: () {
                                  BlocProvider.of<LoginBloc>(context).add(Login(emailController.text, pwController.text));
                                },
                                height: 72),
                          );
                        },
                      ),
                      const SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '아직 회원이 아니신가요? ',
                              style: textTheme(context).krSubtitle2.copyWith(fontWeight: FontWeight.normal),
                            ),
                            TextButton(
                              child: Text(
                                '회원가입',
                                style: textTheme(context).krSubtitle2,
                              ),
                              onPressed: () {
                                context.pushReplacementNamed('/signUp');
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'CopyrightⓒLaonStory. All rights reserved.',
                        style: textTheme(context).krSubtext2.copyWith(color: gray3, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 32)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

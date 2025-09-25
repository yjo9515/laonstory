import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:union_management/admin/login/bloc/login_bloc.dart';
import 'package:union_management/common/enum/enums.dart';

import '../../../common/style.dart';
import '../../../common/widget/edit_text_field_widget.dart';
import '../../widget/binding.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController pwController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginBloc()..add(const Initial()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state.status) {
            case CommonStatus.initial:
              break;
            case CommonStatus.loading:
              break;
            case CommonStatus.success:
              TextInput.finishAutofillContext();
              context.pushReplacement('/admin');
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
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
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
                        Align(alignment: Alignment.centerLeft, child: Text("관리자 로그인", style: textTheme(context).krTitle2)),
                        const SizedBox(height: 32),
                        Image.asset('assets/images/brand_icon.png', height: 100),
                        const SizedBox(height: 32),
                        Text("평택시민의료소비자생활협동조합 조합원 관리 시스템", style: textTheme(context).krTitle2R),

                        const SizedBox(height: 64),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 240),
                          child: EditTextFieldWidget(
                            controller: idController,
                            hint: '',
                            label: '아이디',
                            enabled: true,
                            isUserId: true,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 240),
                          child: EditTextFieldWidget(controller: pwController, hint: '', label: '비밀번호', enabled: true, isPassword: true),
                        ),
                        const SizedBox(height: 64),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 240),
                          child: LargeButtonWidget(text: '로그인', onClick: () => BlocProvider.of<LoginBloc>(context).add(Login(idController.text, pwController.text)), height: 72),
                        ),
                        const SizedBox(height: 32),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 240),
                        //   child: TextButton(
                        //     child: Text(
                        //       '회원가입',
                        //       style: textTheme(context).krBody2,
                        //     ),
                        //     onPressed: () {
                        //       context.push('/signUp');
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 24),
                        Text('CopyrightⓒLaonStory. All rights reserved.', style: textTheme(context).krSubtext2.copyWith(color: gray3, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 16)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

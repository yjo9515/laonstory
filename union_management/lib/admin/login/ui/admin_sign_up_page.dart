import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:flutter_static_utility/flutter_static_utility.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/widget/edit_text_field_widget.dart';
import '../../widget/binding.dart';
import '../bloc/sign_up_bloc.dart';
import '../model/create_admin_model.dart';

class AdminSignUpPage extends StatelessWidget {
  const AdminSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final codeController = TextEditingController();
    final pwController = TextEditingController();
    final registrationController = TextEditingController();
    final ceoController = TextEditingController();
    final dateController = TextEditingController();
    final brandController = TextEditingController();
    final searchController = TextEditingController();
    Future<PlatformFile?> file;

    return BlocProvider(
      create: (context) => SignUpBloc()..add(const Initial()),
      child: BlocListener<SignUpBloc, SignUpState>(
        listenWhen: (prev, state) => prev.status != state.status,
        listener: (context, state) {
          switch (state.status) {
            case SignUpStatus.initial:
              break;
            case SignUpStatus.success:
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        child: Container(
                      height: 250,
                      width: 300,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text("회원가입 신청이 완료되었습니다.", style: textTheme(context).krBody1),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                context.replace('/admin');
                              },
                              child: Container(
                                  decoration: const BoxDecoration(color: black),
                                  width: double.infinity,
                                  height: 56,
                                  child: Center(child: Text("확인", style: textTheme(context).krBody1.copyWith(color: white)))))
                        ],
                      ),
                    ));
                  });
              break;
            case SignUpStatus.failure:
              IconDialog.show(
                  context: context,
                  content: state.message ?? "오류가 발생하였습니다.",
                  width: 300,
                  iconTitle: true,
                  buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
                  title: '');
              break;
            case SignUpStatus.oauth:
              IconDialog.show(
                  context: context,
                  content: '인증번호가 전송되었습니다.',
                  width: 300,
                  iconTitle: true,
                  buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
                  title: '');
              break;
            case SignUpStatus.oauthSuccess:
              IconDialog.show(
                  context: context,
                  content: '인증이 완료되었습니다.',
                  width: 300,
                  iconTitle: true,
                  buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
                  title: '');

              break;
          }
        },
        child: Scaffold(
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
                      Align(alignment: Alignment.centerLeft, child: Text("기업 회원가입", style: textTheme(context).krTitle2)),
                      const SizedBox(height: 32),
                      // SvgPicture.asset('assets/images/app_bar_image.svg', height: 80),
                      const SizedBox(height: 64),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        buildWhen: (prev, state) => prev.status != state.status,
                        builder: (context, state) {
                          return Container(
                            height: 128,
                            padding: const EdgeInsets.symmetric(horizontal: 240),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: EditTextFieldWidget(
                                    hint: '',
                                    label: '이메일',
                                    subLabelWidget: state.status == SignUpStatus.oauthSuccess ? const Icon(Icons.check_circle_outline, color: green) : null,
                                    controller: emailController,
                                    isEmail: true,
                                    enabled: state.status != SignUpStatus.oauthSuccess,
                                    suffixWidget: getEmailButton(context, state.status, emailController),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: EditTextFieldWidget(
                                    hint: '',
                                    label: '이메일 인증번호',
                                    controller: codeController,
                                    subLabelWidget: state.status == SignUpStatus.oauthSuccess ? const Icon(Icons.check_circle_outline, color: green) : null,
                                    enabled: state.status == SignUpStatus.oauth || state.status == SignUpStatus.failure ? true : false,
                                    isCode: true,
                                    max: 6,
                                    suffixWidget: state.status == SignUpStatus.oauth || state.status == SignUpStatus.failure
                                        ? TextButton(
                                            onPressed: () {
                                              BlocProvider.of<SignUpBloc>(context).add(CheckEmail(emailController.text, codeController.text));
                                            },
                                            child: Text("인증", style: textTheme(context).krBody2.copyWith(color: green)))
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        height: 128,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(
                          hint: '',
                          label: '비밀번호',
                          controller: pwController,
                          max: 20,
                          isPassword: true,
                        ),
                      ),
                      Container(
                        height: 128,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(
                          hint: '',
                          label: '등록번호',
                          controller: registrationController,
                          max: 10,
                          isNumber: true,
                        ),
                      ),
                      Container(
                        height: 128,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(
                          hint: '',
                          label: '대표자 성명',
                          controller: ceoController,
                        ),
                      ),
                      Container(
                        height: 128,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(
                          onClick: (data) async {
                            dateController.text = await _selectDate(context);
                          },
                          hint: '',
                          label: '개업일자',
                          controller: dateController,
                          enabled: false,
                        ),
                      ),
                      Container(
                        height: 128,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: EditTextFieldWidget(
                          hint: '',
                          label: '조합원명',
                          controller: brandController,
                        ),
                      ),
                      Container(
                        height: 104,
                        padding: const EdgeInsets.symmetric(horizontal: 240),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    "조합 등록 증명원",
                                    style: textTheme(context).krBody1,
                                  ),
                                ),
                                const Spacer(),
                                Container(margin: const EdgeInsets.only(bottom: 16), child: IconButton(onPressed: () {}, icon: const Icon(Icons.question_mark_outlined, size: 16)))
                              ],
                            ),
                            BlocSelector<SignUpBloc, SignUpState, PlatformFile?>(
                              selector: (state) => state.file,
                              builder: (context, state) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 48,
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              file = _selectFile();
                                              BlocProvider.of<SignUpBloc>(context).add(Upload(file));
                                            },
                                            child: Text("파일 업로드", style: textTheme(context).krSubtext1))),
                                    const SizedBox(width: 16),
                                    Container(margin: const EdgeInsets.only(bottom: 16), child: Text(state?.name ?? "", style: textTheme(context).krSubtext1)),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 240),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: TextField(
                                    controller: searchController,
                                    style: textTheme(context).krBody1,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                      enabledBorder: UnderlineInputBorder(
                                        //<-- SEE HERE
                                        borderSide: BorderSide(width: 1, color: black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        //<-- SEE HERE
                                        borderSide: BorderSide(width: 1, color: black),
                                      ),
                                    ),
                                    cursorColor: black,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      BlocProvider.of<SignUpBloc>(context).add(GetBrand(searchController.text, 1));
                                    },
                                    child: const Icon(Icons.search, size: 24)),
                                const SizedBox(width: 8),
                                IconButton(
                                    onPressed: () {
                                      if (state.page != 1) {
                                        int page = state.page! - 1;
                                        BlocProvider.of<SignUpBloc>(context).add(GetBrand(searchController.text, page));
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_new)),
                                Text("${state.page}", style: textTheme(context).krBody2),
                                IconButton(
                                    onPressed: () {
                                      int page = state.page! + 1;
                                      BlocProvider.of<SignUpBloc>(context).add(GetBrand(searchController.text, page));
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios)),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 64),
                      BlocBuilder<SignUpBloc, SignUpState?>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 240),
                            child: LargeButtonWidget(
                                text: '회원가입 신청',
                                onClick: () {
                                  BlocProvider.of<SignUpBloc>(context).add(SignUp(CreateAdminModel(emailController.text, codeController.text, pwController.text, registrationController.text,
                                      brandController.text, ceoController.text, DateTime.parse(dateController.text), state?.file?.name)));
                                  // context.replace('/admin');
                                },
                                height: 72),
                          );
                        },
                      ),
                      const SizedBox(height: 100),
                      Text('CopyrightⓒLaonStory. All rights reserved.', style: textTheme(context).krSubtext2.copyWith(color: gray3, fontWeight: FontWeight.w400)),
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

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return DateFormat('yyyy-MM-dd').format(selected ?? DateTime.now());
  }

  Future<PlatformFile?> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, withReadStream: true, allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);
    return result?.files.first;
  }

  Widget? getEmailButton(BuildContext context, SignUpStatus status, TextEditingController emailController) {
    switch (status) {
      case SignUpStatus.initial:
      case SignUpStatus.failure:
        return TextButton(
            onPressed: () {
              if (checkEmailRegex(email: emailController.text)) {
                BlocProvider.of<SignUpBloc>(context).add(Oauth(email: emailController.text));
              }
            },
            child: Text("전송", style: textTheme(context).krBody2.copyWith(color: green)));
      case SignUpStatus.oauth:
        return TextButton(
            onPressed: () {
              if (checkEmailRegex(email: emailController.text)) {
                BlocProvider.of<SignUpBloc>(context).add(Oauth(email: emailController.text, resend: true));
              }
            },
            child: Text("재전송", style: textTheme(context).krBody2.copyWith(color: green)));
      case SignUpStatus.oauthSuccess:
      case SignUpStatus.success:
        return null;
    }
  }
}

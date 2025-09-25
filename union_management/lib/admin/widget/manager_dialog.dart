import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_static_utility/flutter_static_utility.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../etc/bloc/detail_bloc.dart';
import '../settings/model/manager_model.dart';
import '../../common/enum/enums.dart';
import 'binding.dart';

class ManagerDialog {
  static add(BuildContext context, {Function()? onChange}) {
    return dialog(context, AddManagerDialog(onChange: onChange ?? () => {}));
  }

  static edit(BuildContext context, {required Manager manager, Function()? onChange}) {
    return dialog(context, EditManagerDialog(onChange: onChange ?? () => {}, manager: manager));
  }
}

class AddManagerDialog extends StatelessWidget {
  const AddManagerDialog({Key? key, required this.onChange}) : super(key: key);

  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    final pwController = TextEditingController();

    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '관리자 신규 등록',
                          style: textTheme(context).krBody2,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(width: 1, color: gray2)),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DataInputWidget(title: '이름', hint: '관리자의 이름을 입력해 주세요.', controller: nameController),
                            const SizedBox(height: 16),
                            DataInputWidget(
                              title: '사용자 아이디',
                              hint: '사용자 아이디를 입력해 주세요.',
                              controller: idController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '비밀번호 (대문자, 특수문자 포함 8자리 이상)',
                              hint: '비밀번호를 입력해 주세요.',
                              isPassword: true,
                              controller: pwController,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (!checkPasswordRegex(password: pwController.text, min: 8, max: 20)) {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog.adaptive(
                                        title: const Text(
                                          '알림',
                                        ),
                                        content: Text(
                                          '비밀번호는 8자 이상의\n대소문자 영문, 숫자, 특수문자를 포함해주세요',
                                          style: textTheme(context).krBody1,
                                        ),
                                        actions: <Widget>[
                                          adaptiveAction(
                                            context: context,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('확인'),
                                          ),
                                        ],
                                      );
                                    });
                                return;
                              }
                              final managerData = {
                                'name': nameController.text,
                                'loginId': idController.text,
                                'password': pwController.text,
                              };
                              context.read<DetailBloc>().add(AddManager(managerData));
                              await context.read<DetailBloc>().stream.first.then((value) {
                                if (value.status == CommonStatus.success) {
                                  onChange();
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '등록',
                                  style: textTheme(context).krBody2,
                                ))))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditManagerDialog extends StatelessWidget {
  const EditManagerDialog({Key? key, required this.manager, required this.onChange}) : super(key: key);

  final Function() onChange;
  final Manager manager;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: manager.name);
    final idController = TextEditingController(text: manager.loginId);
    final pwController = TextEditingController();

    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '관리자 정보 수정',
                          style: textTheme(context).krBody2,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(width: 1, color: gray2)),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DataInputWidget(title: '이름', hint: '관리자의 이름을 입력해 주세요.', controller: nameController),
                            const SizedBox(height: 16),
                            DataInputWidget(
                              title: '사용자 아이디',
                              hint: '사용자 아이디를 입력해 주세요.',
                              controller: idController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '새 비밀번호 (대문자, 특수문자 포함 8자리 이상)',
                              hint: '새 비밀번호를 입력해 주세요.',
                              controller: pwController,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            context.read<DetailBloc>().add(DeleteManager(manager.id ?? '0'));
                            await context.read<DetailBloc>().stream.first.then((value) {
                              onChange();
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            '하위관라자 삭제',
                            style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                          )),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (!checkPasswordRegex(password: pwController.text, min: 8, max: 20)) {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog.adaptive(
                                        title: const Text(
                                          '알림',
                                        ),
                                        content: Text(
                                          '비밀번호는 8자 이상의\n대소문자 영문, 숫자, 특수문자를 포함해주세요',
                                          style: textTheme(context).krBody1,
                                        ),
                                        actions: <Widget>[
                                          adaptiveAction(
                                            context: context,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('확인'),
                                          ),
                                        ],
                                      );
                                    });
                                return;
                              }
                              final managerData = {
                                'name': nameController.text,
                                'loginId': idController.text,
                                'password': pwController.text,
                              };
                              context.read<DetailBloc>().add(EditManager(manager.id ?? '0', managerData));
                              await context.read<DetailBloc>().stream.first.then((value) {
                                if (value.status == CommonStatus.success) {
                                  onChange();
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '저장',
                                  style: textTheme(context).krBody2,
                                ))))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

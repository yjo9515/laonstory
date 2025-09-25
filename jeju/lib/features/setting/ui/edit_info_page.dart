import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/setting/bloc/edit_info_bloc.dart';
import 'package:jeju_host_app/features/setting/bloc/edit_info_state.dart';

import '../../global/bloc/global_bloc.dart';

class EditInfoPage extends StatelessWidget {
  const EditInfoPage({Key? key, required this.bloc}) : super(key: key);

  final GlobalBloc bloc;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nicknameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    return BlocProvider(
        create: (context) =>
            EditInfoBloc()..add(Initial(data: bloc.state.profile)),
        child: Scaffold(
          appBar: CustomAppBar(
            textTitle: '내 정보 변경',
            backButton: true,
          ),
          body: BlocConsumer<EditInfoBloc, EditInfoState>(
              // listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
            if (state.status == CommonStatus.success) {
              nicknameController.text = state.profile.nickname ?? '';
              emailController.text = state.profile.email ?? '';
              phoneController.text = state.profile.phone ?? '';
            } else if (state.status == CommonStatus.failure) {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text(
                        '알림',
                      ),
                      content: Text(
                        state.errorMessage ?? '오류가 발생했습니다. 다시 시도해주세요.',
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

            if (state.emailConfirm == true &&
                state.status == CommonStatus.success) {
              context.pop();
            }
            if (state.sendEmail == true &&
                state.status == CommonStatus.success) {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext buildContext) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(buildContext).viewInsets.bottom),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${state.profile.email}',
                              style: context.textTheme.krButton1.copyWith()),
                          SizedBox(
                            height: 8,
                          ),
                          Text('으로 인증코드를 보냈습니다.',
                              style: context.textTheme.krBody1
                                  .copyWith(color: gray2)),
                          SizedBox(
                            height: 50,
                          ),
                          Text('코드 입력를 입력해 주세요.',
                              style: context.textTheme.krBody1
                                  .copyWith(color: gray0)),
                          SizedBox(
                            height: 15,
                          ),
                          InputWidget(
                            maxLength: 6,
                            autofocus: true,
                            showCursor: false,
                            inputTextStyle: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 24),
                            nonePadding: true,
                            textAlign: TextAlign.center,
                            format: TextInputType.number,
                            helper: false,
                            onChange: (value) {
                              if (value.length == 6) {
                                context
                                    .read<EditInfoBloc>()
                                    .add(ConfirmEmail(code: value ?? ''));
                              }
                            },
                          ),
                          SizedBox(height: 48),
                          LargeButton(
                            margin: EdgeInsets.zero,
                            text: '인증코드 다시 보내기',
                            onTap: () {
                              context.pop();
                              context.read<EditInfoBloc>().add(
                                  SendEmail(email: state.profile.email ?? ''));
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }, builder: (context, state) {
            return Stack(
              children: [
                     SingleChildScrollView(
                        child: Column(children: [
                        InputWidget(
                          label: '닉네임',
                          format: TextInputType.name,
                          controller: nicknameController,
                          onChange: (value) {
                            context.read<EditInfoBloc>().add(ChangeInfo(
                                profile:
                                    state.profile.copyWith(nickname: value)));
                          },
                        ),
                        Form(
                          key: formKey,
                          child: InputWidget(
                            label: '이메일 주소',
                            format: TextInputType.emailAddress,
                            onChange: (value) {
                              context.read<EditInfoBloc>().add(ChangeInfo(
                                  profile:
                                      state.profile.copyWith(email: value)));
                            },
                            labelSuffixWidget: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    state.profile.email!.isNotEmpty) {
                                  context.read<EditInfoBloc>().add(SendEmail(
                                      email: state.profile.email ?? ''));
                                }
                              },
                              child: Text('인증하기',
                                  style: context.textTheme.krBody1
                                      .copyWith(color: Colors.orange)),
                            ),
                            controller: emailController,
                          ),
                        ),
                        InputWidget(
                          label: '휴대폰 번호',
                          format: TextInputType.phone,
                          onChange: (value) {
                            context.read<EditInfoBloc>().add(ChangeInfo(
                                profile: state.profile.copyWith(phone: value)));
                          },
                          labelSuffixWidget: state.phoneConfirm
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () async {
                                        if(state.profile.phone!.isNotEmpty) {
                                          await context.push('/auth?path=edit').then((value){
                                            if(value == true){
                                              context.read<EditInfoBloc>().add(ConfirmPhone());
                                            }else{
                                              showAdaptiveDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog.adaptive(
                                                      title: const Text(
                                                        '알림',
                                                      ),
                                                      content: Text(
                                                        value == null ?
                                                        '오류가 발생했습니다. 다시 시도해주세요.':
                                                        value.toString(),
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
                                          });
                                        }

                                      },
                                      child: Text('변경하기',
                                          style: context.textTheme.krBody1
                                              .copyWith(color: gray0)),
                                    ),
                                    SizedBox(width: 5,),
                                    Text('|',
                                        style: context.textTheme.krBody1
                                            .copyWith(color: gray0)),
                                    SizedBox(width: 5,),
                                    Text('인증완료',
                                        style: context.textTheme.krBody1
                                            .copyWith(color: mainJeJuBlue))
                                  ],
                                )
                              : TextButton(
                                  onPressed: () async{
                                    if(state.profile.phone!.isNotEmpty) {
                                      await context.push('/auth?path=edit').then((value){
                                        if(value == true){
                                          context.read<EditInfoBloc>().add(ConfirmPhone());
                                        }else{
                                          showAdaptiveDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog.adaptive(
                                                  title: const Text(
                                                    '알림',
                                                  ),
                                                  content: Text(
                                                    value == null ?
                                                    '오류가 발생했습니다. 다시 시도해주세요.':
                                                    value.toString() ,
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
                                      });
                                    }
                                  },
                                  child: Text('인증하기',
                                      style: context.textTheme.krBody1
                                          .copyWith(color: Colors.orange)),
                                ),
                          controller: phoneController,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('숙소 예약을 위해서는 휴대폰 인증이 필수입니다..',
                                  style: context.textTheme.krBody1
                                      .copyWith(color: Colors.orange))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: LargeButton(
                            text: '저장하기',
                            onTap: () {},
                          ),
                        )
                      ])),
                (state.status == CommonStatus.loading)?
                Offstage(
                  offstage: state.status != CommonStatus.loading,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.black,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          color: mainJeJuBlue,
                        ),
                      )
                    ],
                  ),
                )
                    :Container(),
              ],
            );
          }),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/setting/bloc/question_event.dart';
import 'package:jeju_host_app/features/setting/bloc/question_state.dart';

import '../bloc/question_bloc.dart';

class QuestionWritePage extends StatelessWidget {
  const QuestionWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) =>
      QuestionBloc()..add(Initial()),
      child: Scaffold(
        appBar: const CustomAppBar(
          textTitle: '1:1 문의',
          backButton: true,
        ),
        body: BlocConsumer<QuestionBloc, QuestionState>(
          listener: (context, state){
            if (state.status == CommonStatus.failure) {
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
          },
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Column(

                children: [
                  InputWidget(
                    label: '제목',
                    hint: '제목을 입력해주세요',
                    onChange: (value){
                      context.read<QuestionBloc>().add(ChangeValue(value: value, type: 'title'));
                    },
                  ),
                  InputWidget(
                    label: '문의 내용',
                    hint: '내용을 입력해주세요',
                    minLines: 6,
                    maxLines: 10,
                    maxLength: 300,
                    count: true,
                    onChange: (value){
                      context.read<QuestionBloc>().add(ChangeValue(value: value, type: 'comment'));
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('문의 내용은 영업일 기준 1~2일 이내로 답변이 완료되며, 문의가 등록되면 알림으로 알려드릡니다.',style: context.textTheme.krBody1.copyWith(color: gray0),)
                  )

                ],
              )
            );
          },


        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: LargeButton(
            text: '작성완료',
            onTap: () {

            },
          ),
        ),
      ),
    );
  }
}

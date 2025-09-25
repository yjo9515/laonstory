import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/setting/bloc/question_state.dart';

import '../bloc/question_bloc.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

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
              child: state.questionList.isEmpty
                  ? Container(
                height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!.toInt(),
                child: Center(
                  child: Text(
                      "현재 등록된 문의가 없습니다.",
                      textAlign: TextAlign.center, style: context.textTheme.krBody1
                  ),
                ),
              )
                  : Column(
                children: state.questionList!.map((e) => InkWell(
                  onTap: () {
                    context.push('/setting/notice/${e.id}');
                  },
                  child: ListTextButton(text: e.title!, date: e.updatedAt!),
                )).toList(),
              ),
            );
          },


        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: LargeButton(
            text: '1:1 문의 하기',
            onTap: () {
              context.push('/setting/question/write');

            },
          ),
        ),
      ),
    );
  }
}

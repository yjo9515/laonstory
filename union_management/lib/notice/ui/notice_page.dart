import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';
import '../bloc/notice_bloc.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoticeBloc()..add(Detail(id)),
      child: BlocBuilder<NoticeBloc, NoticeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              onBack: () {
                context.pop();
              },
              backButton: true,
              textTitle: "공지사항",
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.detailNotice.title ?? "",
                          style: textTheme(context).krTitle1),
                      const SizedBox(height: 24),
                      Html(data:( state.detailNotice.content  ?? "내용없음").replaceAll('font-feature-settings: normal;', ''))

                    ],
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

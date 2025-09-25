import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/style.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "이런 페이지가 없어요 😢\n오류가 발생한것 같네요.\n\n불편을 드려 죄송해요\n개발자가 빠르게 고쳐줄거에요!",
        style: textTheme(context).krSubtitle1R,
        textAlign: TextAlign.center,
      )),
      bottomNavigationBar: InkWell(
          onTap: () {
            context.go('/');
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 32),
            height: 100,
            color: black,
            child: Center(
                child: Text(
              "홈으로",
              style: textTheme(context).krTitle2.copyWith(color: white),
            )),
          )),
    );
  }
}

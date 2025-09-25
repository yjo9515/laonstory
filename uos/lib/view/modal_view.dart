// 개인정보 처리 방침 모달 창 위젯
import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget title;
  final Widget content;

  const CustomModal({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: title,
          ), // 받아온 타이틀을 사용
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: content, // 받아온 내용 위젯을 사용
          ),
        ),
      ),
    );
  }
}

Future<T?> showFullDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = false,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.white.withOpacity(1), // 배경 투명도 조절
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return builder(context);
    },
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';

Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return TextButton(onPressed: onPressed, child: child);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoDialogAction(onPressed: onPressed, child: child);
  }
}

errorDialog(context, String message, Function() onClick) {
  IconDialog.show(
      context: context,
      title: "",
      content: message,
      buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: context.textTheme.krBody1),
      iconTitle: true,
      widgets: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
        ),
        width: double.infinity,
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onClick();
            },
            child: Text('확인', style: context.textTheme.krBody1.copyWith(color: Colors.white))),
      ));
}

dialog(BuildContext context, Widget widget) {
  showDialog<void>(
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.1),
    context: context,
    builder: (BuildContext ctx) {
      return widget;
    },
  );
}

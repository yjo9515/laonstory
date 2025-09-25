import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';

import '../enum/enums.dart';
import '../style.dart';


Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child, bool isCancel = false}) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return TextButton(onPressed: onPressed, child: child);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoDialogAction(onPressed: onPressed, textStyle: TextStyle(color: isCancel ? Colors.red : null), child: child);
  }
}


errorDialog(context, String message, Function() onClick) {
  IconDialog.show(
      context: context,
      title: "",
      content: message,
      buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
      iconTitle: true,
      widgets: Container(
        decoration: const BoxDecoration(
          color: black,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
        ),
        width: double.infinity,
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onClick();
            },
            child: Text('확인', style: textTheme(context).krBody1.copyWith(color: white))),
      ));
}

showImageModal(context, Function(ImageType) onImage) {
  Map<String, List<Widget>> orderWidget = {
    'android': ImageType.values.asMap().entries.map((element) {
      switch (element.value) {
        case ImageType.camera:
          return Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
                onImage(element.value);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt),
                  const SizedBox(width: 16),
                  Text(
                    '카메라 업로드',
                    style: textTheme(context).krSubtitle1R,
                  ),
                ],
              ),
            ),
          );
        case ImageType.gallery:
          return Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
                onImage(element.value);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_library),
                  const SizedBox(width: 16),
                  Text(
                    '갤러리 업로드',
                    style: textTheme(context).krSubtitle1R,
                  ),
                ],
              ),
            ),
          );
      }
    }).toList(),
    'iOS': ImageType.values.asMap().entries.map((element) {
      switch (element.value) {
        case ImageType.camera:
          return CupertinoActionSheetAction(
            child: Text('카메라 업로드', style: textTheme(context).krTitle2R.copyWith(color: Colors.blueAccent)),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pop();
              onImage(element.value);
            },
          );

        case ImageType.gallery:
          return CupertinoActionSheetAction(
              child: Text('갤러리 업로드', style: textTheme(context).krTitle2R.copyWith(color: Colors.blue)),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
                onImage(element.value);
              });
      }
    }).toList(),
  };

  if (defaultTargetPlatform == TargetPlatform.android) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: black.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: orderWidget['android'] ?? [],
              ),
            ));
      },
    );
  } else {
    showCupertinoModalPopup<void>(
      barrierColor: black.withOpacity(0.7),
      context: context,
      builder: (BuildContext ctx) => CupertinoActionSheet(
        title: Text('이미지 업로드', style: textTheme(context).krSubtext1),
        actions: orderWidget['iOS'],
        cancelButton: CupertinoActionSheetAction(
            child: Text('취소', style: textTheme(context).krTitle2R.copyWith(color: Colors.red)),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}

showEventModal(context, {required Function() onClick}) {
  Map<String, List<Widget>> orderWidget = {
    'android': [
      Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
            onClick();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.cancel),
              const SizedBox(width: 16),
              Text(
                '신청 취소',
                style: textTheme(context).krSubtitle1R,
              ),
            ],
          ),
        ),
      ),
    ],
    'iOS': [
      CupertinoActionSheetAction(
        child: Text('신청 취소', style: textTheme(context).krTitle2R.copyWith(color: Colors.blueAccent)),
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pop();
          onClick();
        },
      )
    ],
  };

  if (defaultTargetPlatform == TargetPlatform.android) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: black.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: orderWidget['android'] ?? [],
              ),
            ));
      },
    );
  } else {
    showCupertinoModalPopup<void>(
      barrierColor: black.withOpacity(0.7),
      context: context,
      builder: (BuildContext ctx) => CupertinoActionSheet(
        title: Text('더 보기', style: textTheme(context).krSubtext1),
        actions: orderWidget['iOS'],
        cancelButton: CupertinoActionSheetAction(
            child: Text('취소', style: textTheme(context).krTitle2R.copyWith(color: Colors.red)),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}

dialog(BuildContext context, Widget widget) {
  showDialog<void>(
      barrierDismissible: true,
      barrierColor: black.withOpacity(0.1),
      context: context,
      builder: (BuildContext ctx) {
        return widget;
      });
}

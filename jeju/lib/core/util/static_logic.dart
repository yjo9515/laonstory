import 'package:flutter/material.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core.dart';

void onScroll({required ScrollController controller, Function()? onDone, bool edge = false}) {
  if (isMaximum(controller)) {
    onDone?.call();
  }
}

bool isMaximum(ScrollController controller, {bool edge = false}) {
  if (!controller.hasClients) return false;
  if (edge) controller.position.atEdge && controller.position.pixels != 0;
  final maxScroll = controller.position.maxScrollExtent;
  final currentScroll = controller.offset;
  return currentScroll >= (maxScroll * 0.95);
}

void checkInputData(context, {required List<(String?, String)> controllers, Function()? onDone}) {
  final data = controllers.indexWhere((element) {
    return element.$1?.isEmpty ?? true;
  });
  if (data != -1) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text(
              '알림',
            ),
            content: Text(
              controllers[data].$2,
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
    return;
  } else {
    onDone?.call();
  }
}

String dateParser(String? date) {
  if (date == null) return "";
  return DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date));
}

String dateDotParser(String? date) {
  if (date == null) return "";
  return DateFormat('yyyy.MM.dd HH:mm').format(DateTime.parse(date));
}

String monthParserDate(DateTime? date) {
  if (date == null) return "";
  return DateFormat('yyyy년 MM월').format(date);
}

String dateParserDate(DateTime? date, {String? format}) {
  if (date == null) return "";
  return DateFormat(format ?? 'yyyy년 MM월 dd일','ko').format(date);
}

String timeParser(String? date, bool showCurrentYear) {
  if (date == null) return "";
  final dateData = DateTime.parse(date).toLocal();
  if (dateData.year == DateTime.now().year && !showCurrentYear) {
    return DateFormat('MM월 dd일 HH시 mm분').format(dateData);
  }
  return DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(dateData);
}

String timeAParser(DateTime? date) {
  if (date == null) return "";
  return DateFormat('a hh:mm').format(date);
}

String numberFormatter(int? number) {
  if (number == null) {
    return '-';
  }
  return NumberFormat('###,###,###,###').format(number);
}

DateTime dateFormatter(String? date) {
  if (date == null) return DateTime.now().toUtc();
  final result = date.replaceAll("년", "-").replaceAll("월", "-").replaceAll("일", "").replaceAll(" ", "");
  return DateTime.parse(result).toUtc();
}

changeAgeToString(String? age) {
  if (age?.contains("AGERANGE_AGE") ?? false) {
    return "${age?.replaceAll('AGERANGE_AGE_', "").substring(0, 2)}대";
  } else {
    return null;
  }
}

changeGenderToString(String? gender) {
  switch (gender) {
    case "GENDER_MALE":
      return '남';
    case "GENDER_FEMALE":
      return '여';
    default:
      return null;
  }
}

String changeNotificationToString(NotificationType type) {
  switch (type) {
    case NotificationType.notice:
      return "TYPE_NOTICE";
    case NotificationType.event:
      return "TYPE_EVENT";
  }
}

checkPermission(Permission permission, BuildContext context, String data) {
  permission.status.then((value) async {
    switch (value) {
      case PermissionStatus.denied:
        await permission.request();
        break;
      case PermissionStatus.permanentlyDenied:
        await deniedPermission(permission, context, data);
        break;
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
      case PermissionStatus.provisional:
        break;
    }
  });
}

deniedPermission(Permission permission, BuildContext context, String data) async {
  permission.request().then((result) {
    if (result == PermissionStatus.permanentlyDenied) {
      IconDialog.show(
        context: context,
        title: '',
        content: '$data 권한이 거부되어있어요.\n기능 이용을 위해 디바이스 설정에서\n권한 설정을 해야해요. 설정으로 이동할까요?',
        iconTitle: true,
        canGoBack: true,
        buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: context.textTheme.krBody1),
        widgets: Container(
          color: Theme.of(context).primaryColorDark,
          height: 40,
          width: 300,
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                  ),
                  height: 40,
                  width: 150,
                  child: Center(
                    child: Text(
                      "취소",
                      style: context.textTheme.krBody1.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await openAppSettings();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0)),
                  ),
                  height: 40,
                  width: 150,
                  child: Center(
                    child: Text(
                      "확인",
                      style: context.textTheme.krBody1.copyWith(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }).catchError((error) {
    IconDialog.show(
      context: context,
      title: '',
      content: '$data 권한이 거부되어있어요.\n기능 이용을 위해 디바이스 설정에서\n권한 설정을 해야해요. 설정으로 이동할까요?',
      iconTitle: true,
      canGoBack: true,
      buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: context.textTheme.krBody1),
      widgets: Container(
        color: Theme.of(context).primaryColorDark,
        height: 40,
        width: 300,
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                ),
                height: 40,
                width: 150,
                child: Center(
                  child: Text(
                    "취소",
                    style: context.textTheme.krBody1.copyWith(color: Colors.red),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0)),
                ),
                height: 40,
                width: 150,
                child: Center(
                  child: Text(
                    "확인",
                    style: context.textTheme.krBody1.copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

String listToString(List<String>? list) {
  String result = "";
  if (list == null) {
    return result;
  }
  for (int i = 0; i < list.length; i++) {
    result += list[i];
    if (i != list.length - 1) {
      result += ",";
    }
  }
  return result;
}

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:string_validator/string_validator.dart';
import 'package:union_management/common/util/logger.dart';

import '../enum/enums.dart';
import '../../env/env.dart';
import '../style.dart';

int getMinPage(int currentPage, int totalPage) {
  if (totalPage <= 5 || currentPage - 2 <= 1) {
    return 1;
  } else {
    if (totalPage - currentPage > 2) {
      return currentPage - 2;
    }
    return currentPage - 4 + (totalPage - currentPage);
  }
}

int getMaxPage(int currentPage, int totalPage) {
  if (totalPage <= 5 || currentPage + 2 >= totalPage) {
    return totalPage;
  } else if (currentPage < 3) {
    return 5;
  } else {
    return currentPage + 2;
  }
}

int paginateNumber(int currentPage, int totalPage, Path path) {
  switch (path) {
    case Path.left:
      if (currentPage == 1) {
        return 0;
      } else {
        return --currentPage;
      }
    case Path.right:
      if (currentPage == totalPage) {
        return 0;
      } else {
        return ++currentPage;
      }
  }
}


String decryptData(String? encrypted) {
  if (encrypted == null) return '-';
  if (!isBase64(encrypted)) return encrypted;
  final key = Key.fromUtf8(Env.dataPrivateKey);
  final iv = IV.fromUtf8(Env.dataPrivateIv);
  return Encrypter(AES(key, mode: AESMode.cbc)).decrypt64(encrypted, iv: iv);
}

String encryptData(String? data) {
  if (data == null) return '-';
  if (isBase64(data)) return data;
  final key = Key.fromUtf8(Env.dataPrivateKey);
  final iv = IV.fromUtf8(Env.dataPrivateIv);
  return Encrypter(AES(key, mode: AESMode.cbc)).encrypt(data, iv: iv).base64;
}

String dateParser(String? date, bool showCurrentYear) {
  if (date == null || date.isEmpty) return "-";
  final dateData = DateTime.parse(date).toLocal();
  if (dateData.year == DateTime.now().year && !showCurrentYear) {
    return DateFormat('MM월 dd일').format(dateData);
  }
  return DateFormat('yyyy년 MM월 dd일').format(dateData);
}

String dateFormatParser(String? date) {
  if (date == null) return "";
  final dateData = DateTime.parse(date).toLocal();
  return DateFormat('yyyy-MM-dd').format(dateData);
}

String timeParser(String? date, bool showCurrentYear) {
  if (date == null) return "";
  final dateData = DateTime.parse(date).toLocal();
  if (dateData.year == DateTime.now().year && !showCurrentYear) {
    return DateFormat('MM월 dd일 HH시 mm분').format(dateData);
  }
  return DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(dateData);
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
  if (age != null && age.contains("-")) {
    if (int.parse(age.split('-').first.substring(0, 2)) < 23) {
      return "20${age.split('-').first.substring(0, 2)}년생";
    }
    return "19${age.split('-').first.substring(0, 2)}년생";
  } else {
    return null;
  }
}

eventStatusToString(String? status) {
  switch (status) {
    case "EVENT_RECRUIT":
      return '모집중';
    case "EVENT_ON":
      return '진행중';
    case "EVENT_DONE":
      return '진행완료';
    default:
      return null;
  }
}

String activeToString(String? active) {
  switch (active) {
    case "ACTIVE_ACTIVE":
      return '정상';
    case "ACTIVE_DEAD":
      return '사망';
    case "ACTIVE_DUPLICATION":
      return '중복';
    case "ACTIVE_OUT":
      return '탈퇴';
    default:
      return '';
  }
}

String stringToActive(String? active) {
  switch (active) {
    case "정상":
      return 'ACTIVE_ACTIVE';
    case "사망":
      return 'ACTIVE_DEAD';
    case "중복":
      return 'ACTIVE_DUPLICATION';
    case "탈퇴":
      return 'ACTIVE_OUT';
    default:
      return 'ACTIVE_ACTIVE';
  }
}

String positionToString(String? position) {
  switch (position) {
    case "POSITION_MEMBER":
      return '조합원';
    case "POSITION_DELEGATE":
      return '대의원';
    default:
      return '';
  }
}

String stringToPosition(String? position) {
  switch (position) {
    case "조합원":
      return 'POSITION_MEMBER';
    case "대의원":
      return 'POSITION_DELEGATE';
    default:
      return '';
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
        buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
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
                      style: textTheme(context).krBody1.copyWith(color: Colors.red),
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
                      style: textTheme(context).krBody1.copyWith(color: Colors.blue),
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
      buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
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
                    style: textTheme(context).krBody1.copyWith(color: Colors.red),
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
                    style: textTheme(context).krBody1.copyWith(color: Colors.blue),
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

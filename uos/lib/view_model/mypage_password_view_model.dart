import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isus_members/domain/repository/mypage_repository.dart';
import '../domain/api/api_service.dart';
import '../routes/app_pages.dart';

class MyPagePasswordViewModel extends GetxController with ApiService {
  String password = '';
  String newPassword = '';
  String rePassword = '';

  Future<void> passwordModify() async {
    var pattern1 = RegExp(r'[0-9]');

    var pattern2 = RegExp(r'[a-zA-Z]');

    // var pattern3 = /[~!@#$%<>^&*]/;

    if (newPassword.length < 7) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passLengthAlert'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else if (!pattern1.hasMatch(newPassword) ||
        !pattern2.hasMatch(newPassword)) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passPattern'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else {
      // var SamePass_0 = 0; //동일문자 카운트
      // var SamePass_1 = 0; //연속성(+) 카운드
      // var SamePass_2 = 0; //연속성(-) 카운드
      //
      // var chr_pass_0;
      // var chr_pass_1;
      //
      // for (var i = 0; i < newPassword.length; i++) {
      //   chr_pass_0 = newPassword.characters.characterAt(i);
      //   chr_pass_1 = newPassword.characters.characterAt(i + 1);
      //
      //   // 동일 문자 카운트
      //   if (chr_pass_0 == chr_pass_1) {
      //     SamePass_0 = SamePass_0 + 1;
      //   }
      //
      //   // 연속성(+) 카운트
      //   if (chr_pass_0.runes.first - chr_pass_1.runes.first == 1) {
      //     SamePass_1 = SamePass_1 + 1;
      //   }
      //
      //   // 연속성(-) 카운트
      //   if (chr_pass_0.runes.first - chr_pass_1.runes.first == -1) {
      //     SamePass_2 = SamePass_2 + 1;
      //   } // if
      // } // for

    //   if (SamePass_0 > 1) {
    //     return Get.defaultDialog(
    //         title: tr('alert'),
    //         middleText: tr('passSameLength'),
    //         confirm: TextButton(
    //             onPressed: () {
    //               Get.back();
    //             },
    //             child: Text(tr('confirm'))));
    //   } // if
    //
    //   if (SamePass_1 > 1 || SamePass_2 > 1) {
    //     return Get.defaultDialog(
    //         title: tr('alert'),
    //         middleText: tr('passPatternAlert'),
    //         confirm: TextButton(
    //             onPressed: () {
    //               Get.back();
    //             },
    //             child: Text(tr('confirm'))));
    //   } // if
    }
    if (newPassword.isEmpty) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('newPassCheckAlert'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else if (newPassword.length < 7) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passMin'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else if (newPassword.length > 21) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passMax'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else if (rePassword.isEmpty) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passCheck'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    } else if (newPassword != rePassword) {
      return Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('passNotSame'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    }

    try {
      await MyPageRepository.to
          .passwordModify(password, newPassword)
          .then((value) {
        Get.defaultDialog(
            title: tr('alert'),
            middleText: tr('passChangeComplete'),
            confirm: TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(tr('confirm'))));
      }).catchError((e) {
        print(e);
        Get.defaultDialog(
            title: tr('alert'),
            middleText: e.resultMsg,
            confirm: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(tr('confirm'))));
      });
    } catch (e) {
      log('error');
      log(e.toString());
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}

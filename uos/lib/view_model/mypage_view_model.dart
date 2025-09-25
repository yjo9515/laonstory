import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isus_members/domain/repository/mypage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/api/api_service.dart';
import '../domain/model/user_model.dart';
import '../routes/app_pages.dart';

class MyPageViewModel extends GetxController with ApiService {
  User? user;

  List<dynamic> sns = [];

  Future<void> getUserDetail() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      await MyPageRepository.to
          .getUserDetail(pref.getString('idx'))
          .then((value) {
            user = User.fromJson(value['data']['user']);
          update();
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

  Future<void> snsPageLink(url) async {
      launchUrl(
        Uri.parse(url),
      );

  }

  Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> memberOut() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('idx');

    try {
      if(id != null || id != ''){
        await MyPageRepository.to
            .memberOut(id)
            .then((value) {

          if(value['result'] == 1){
            logout();
            print(value['data']);
          }

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
      }

    } catch (e) {
      log('error');
      log(e.toString());
    }
  }

@override
void onInit() {
  getUserDetail();
  super.onInit();
}
}

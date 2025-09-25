import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/api/api_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/repository/login_repository.dart';
import '../domain/repository/splash_repository.dart';
import '../routes/app_pages.dart';

class SplashViewModel extends GetxController with ApiService {

  Future<void> serviceCheck () async {
    await SplashRepository.to.serviceCheck().then((value){
      print(value);
      log(value.toString());
      if(value['result'] == 1){
        if(!value['data']['is_on']){
          Get.offAllNamed(Routes.NOT_SERVICE);
        }else{
          getVersion();
        }
      }else{
        Get.offAllNamed(Routes.NOT_SERVICE);
      }
    }).catchError((e){
      print(e);
      log(e.toString());
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.toString(), );
    });
  }

  Future<void> getVersion () async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("현재 앱 버전"+packageInfo.version);
    await SplashRepository.to.versionCheck().then((value){
      log(value.toString());
      if(Platform.isAndroid){
        if(value['result'] == 1 &&
            packageInfo.version.compareTo(value['data']['android_version']) < 0){
          Get.defaultDialog(
              title: tr('alert'),
              middleText: tr('appUpdate'),
              confirm: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.laonstory.addressbook"));
                  },
                  child: Text(tr('update'))));
        }else{
          login();
        }
      }else if(Platform.isIOS){
        if(value['result'] == 1 &&
            packageInfo.version.compareTo(value['data']['ios_version']) < 0){
          Get.defaultDialog(
              title: tr('alert'),
              middleText: tr('appUpdate'),
              confirm: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse("http://apps.apple.com/kr/app/isus-members/id1559178750"));
                  },
                  child: Text(tr('update'))));
        }else{
          login();
        }
      }
    }).catchError((e){
      log(e.toString());
    });
  }



  Future<void> login () async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('login') == 'true'){
      var id = pref.getString('loginId')!;
      var pw = pref.getString('loginPw')!;
      log(id);
      log(pw);
      await LoginRepository.to.login(id, pw).then((value) {
        print(value.toString());
        if (value['result'] == 1) {
          print('성공');
          log(value['data']['id']);
          pref.setString('loginId', id);
          pref.setString('loginPw', pw);
          pref.setString('id', value['data']['id']);
          pref.setString('idx', value['data']['idx'].toString());
          pref.setString('token', value['data']['token']);
          pref.setString('ROLE_USER', value['data']['ROLE_USER'] ?? 'null');
          String adminRoleString = value['data']['admin_role'] ?? 'null';
          List<String> adminRoleList = adminRoleString == 'null' ? ['null'] : adminRoleString.split(',');
          pref.setStringList('adminRole', adminRoleList);
          // 상태값 바꾼후 업데이트를 해줘야 화면에 값이 반영됨
          update();
          // 업데이트 후 라우팅
          Get.toNamed(Routes.HOME);
        } else {
          Get.defaultDialog(
              title: tr('alert'),
              middleText: value['resultMsg'] ?? '',
              confirm: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(tr('confirm'))));

        }
      }).catchError((e) {
        // 에러처리 (다이얼로그 위젯띄우기)

        Get.defaultDialog(
            title: tr('alert')
            ,
            middleText: e.resultMsg.toString() ?? '에러가 발생했습니다 관리자에게 문의해주세요',
            confirm: TextButton(
                onPressed: () async {
                  // Get.back();
                  final SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: Text(tr('confirm'))));
      });
    }else{
      Timer( Duration(seconds: 3), () =>Get.offAllNamed(Routes.LOGIN) );
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    serviceCheck();
  }
}

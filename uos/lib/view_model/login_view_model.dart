import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/database/SqlLite.dart';
import 'package:isus_members/domain/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/api/api_service.dart';
import '../routes/app_pages.dart';

class LoginViewModel extends GetxController with ApiService {
  bool loginStatus = false;
  bool termStatus = false;
  String? id;
  String? password;
  change(){
    update();
  }

  Future<void> login(id, password,login,term) async {
    if(term == false){
      Get.defaultDialog(
          title: tr('alert'),
          middleText: tr('termsAlert'),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    }else{
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await LoginRepository.to.login(id, password).then((value) async {
        if (value['result'] == 1) {

          if(loginStatus == true){
            pref.setString('login', 'true');
          }
          print(value.toString());

          String? preId = pref.getString('loginId');
          if(preId != id){
            print(preId);
            print(id);
            final db = await SqlLite().initDB();
            int count = await db.rawDelete('DELETE FROM app_state');
            print('접속 기록 초기화 : $count');
          }
          
          pref.setString('loginId', id);
          pref.setString('loginPw', password);
          pref.setString('id', value['data']['id']);
          pref.setString('idx', value['data']['idx'].toString());
          pref.setString('token', value['data']['token']);
          pref.setString('ROLE_USER', value['data']['ROLE_USER'] ?? 'null');
          String adminRoleString = value['data']['admin_role'] ?? 'null';
          List<String> adminRoleList = adminRoleString == 'null' ? ['null'] : adminRoleString.split(',');
          pref.setStringList('adminRole', adminRoleList);
          pref.setString('termAgreement', 'true');
          // 상태값 바꾼후 업데이트를 해줘야 화면에 값이 반영됨

          update();
          // 업데이트 후 라우팅
          Get.toNamed(Routes.HOME);
        } else {
          Get.defaultDialog(
              title: tr('alert')               ,
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
                onPressed: () {
                  Get.back();
                },
                child: Text(tr('confirm'))));
      });
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString('termAgreement') == 'true'){
      termStatus = true;
      update();
    }
  }

}

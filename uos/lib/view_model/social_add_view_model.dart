import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/model/social_model.dart';
import 'package:isus_members/domain/repository/social_repository.dart';
import './social_modify_list_view_model.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../domain/api/api_service.dart';


class SocialAddViewModel extends GetxController with ApiService {

  String snsContent = '';
  String snsType1 = '';
  String snsType2 = '';
  String snsType3 = '';
  String snsUrl1 = '';
  String snsUrl2 = '';
  String snsUrl3 = '';

  change(){
    update();
  }

  Future<void> handleSns(type, value) async {

    if(type == 'type1'){
      snsType1 = value;
    }else if (type == 'type2'){
      snsType2 = value;
    }else{
      snsType3 = value;
    }
    update();
  }

  Future<void> addCommunity(data) async{
    await SocialRepository.to.addCommunity(data).then((value) {
      try{
        log(value.toString());
        if(value['result'] == 1){
          Get.defaultDialog(
              title: tr('alert'),
              middleText: '등록완료',
              confirm: TextButton(
                  onPressed: () {
                    final controller = Get.put(SocialModifyListViewModel());
                    controller.getCommunity();
                    Get.back();
                    Get.back();
                    update();
                  },
                  child: Text(tr('confirm'))));

          log('등록완료');

        }
      }catch(e){
        log('error');
        log(e.toString());
      }
    }).catchError((e) {
      print(e);
      Get.defaultDialog(
          title: tr('alert')
          ,
          middleText: e.resultMsg,
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }
}

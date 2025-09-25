import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/model/social_model.dart';
import 'package:isus_members/domain/repository/social_repository.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isus_members/view_model/social_view_model.dart';
import './social_modify_list_view_model.dart';
import '../domain/api/api_service.dart';

class SocialModifyViewModel extends GetxController with ApiService {

  String? idx = Get.parameters['id'];
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

  Future<void> getSocialDetail(id) async {
    await SocialRepository.to.getCommunityDetail(id).then((value) {
      log('커뮤니티 상세');

      try {

        update();
        log('update');
        log(value['data'].toString());
        snsContent = value['data']['content'];

        if(value['data']['sns'].isNotEmpty){
          snsType1 = value['data']['sns']?[0]?['social'] ?? '';
          snsUrl1 = value['data']['sns']?[0]?['url'] ?? '';
        }

        if(value['data']['sns'].length > 1){
          snsType2 = value['data']['sns']?[1]?['social'] ?? '';
          snsUrl2 = value['data']['sns']?[1]?['url'] ?? '';
        }
        if(value['data']['sns'].length > 2){
          snsType3 = value['data']['sns']?[2]?['social'] ?? '';
          snsUrl3 = value['data']['sns']?[2]?['url'] ?? '';
        }

        log(snsContent);
        log(snsType1);
        log(snsType2);
        log(snsType3);
        log(snsUrl1);
        log(snsUrl2);
        log(snsUrl3);

      } catch (e) {
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

  Future<void> modifyCommunity(data) async {
    log(idx!);


    print(data.toString());

    await SocialRepository.to.modifyCommunity(idx, data).then((value) {
      try{
        log(value.toString());
        if(value['result'] == 1){
          Get.defaultDialog(
              title: tr('alert'),
              middleText: '수정완료',
              confirm: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Text(tr('confirm'))));

          log('수정완료');
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

  Future<void> handleSns(type, value) async {

    if(type == 'type1'){
      snsType1 = value;
    }else if (type == 'type2'){
      snsType2 = value;
    }else{
      snsType3 = value;
    }

    print('snsType1');
    print(snsType1);
    print('snsType2');
    print(snsType2);
    print('snsType3');
    print(snsType3);
    print(value);
    update();
  }


  Future<void> deleteCommunity() async {
    await SocialRepository.to.deleteCommunity(idx).then((value)  {
      try{
        if(value['result'] == 1){
          Get.defaultDialog(
              title: tr('alert')
              ,
              middleText: '삭제완료',
              confirm: TextButton(
                  onPressed: () {
                    final controller1 = Get.put(SocialViewModel());
                    final controller2 = Get.put(SocialModifyListViewModel());
                    controller1.getCommunity();
                    controller2.getCommunity();
                    Get.back();
                    Get.back();
                    update();
                  },
                  child: Text(tr('confirm'))));
          log('삭제완료');
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


  Community selectSnsObj =
  Community.fromJson({'idx': 0, 'content': '', 'sns': []});

  @override
  void onInit(){
    // TODO: implement onInit
    final id = Get.parameters['id'];
    getSocialDetail(id);
    super.onInit();
  }

}

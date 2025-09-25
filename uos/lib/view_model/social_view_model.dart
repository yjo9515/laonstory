import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/model/social_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:isus_members/domain/repository/social_repository.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../domain/api/api_service.dart';
import '../routes/app_pages.dart';

class SocialViewModel extends GetxController with ApiService {

  List<Community> communityList = [];
  String snsContent = '';
  String snsType1 = '';
  String snsType2 = '';
  String snsType3 = '';
  String snsUrl1 = '';
  String snsUrl2 = '';
  String snsUrl3 = '';
  String role = '';

  change(){
    update();
  }

  Future<void> homePageMove() async {
    print('https://isuskor.uos.ac.kr/');
    launchUrl(
      Uri.parse('https://isuskor.uos.ac.kr/'),
    );
  }

  Future<void> homePageEnMove() async {
    print('https://isus.uos.ac.kr/');
    launchUrl(
      Uri.parse('https://isus.uos.ac.kr/'),
    );
  }

  Future<void> snsPageLink(url) async {
    print(url);
    launchUrl(
      Uri.parse(url),
    );
  }

  Future<void> phoneLink() async {
    print('01012341234');
    launchUrl(Uri.parse('tel:01012341234'));
  }



  Future<void> getCommunity() async {
    await SocialRepository.to.getCommunity().then((value) {
      log('커뮤니티');
      communityList.clear();
      try {
        // log(value['data'].length.toString());
        value['data'].forEach((val) {
          communityList.add(Community.fromJson(val));
        });
        update();
        log('update');
        log(communityList.toString());
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
                    Get.back();
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

  Future<void> deleteCommunity(idx) async {
    await SocialRepository.to.deleteCommunity(idx).then((value)  {
      try{
        if(value['result'] == 1){
          Get.defaultDialog(
              title: tr('alert')
              ,
              middleText: '삭제완료',
              confirm: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(tr('confirm'))));
          Get.back();
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

  Future<void> resetSnsData(value) async {

    snsType1 = '';
    snsType2 = '';
    snsType3 = '';
  }

  Community selectSnsObj =
      Community.fromJson({'idx': 0, 'content': '', 'sns': []});

  @override
  void onInit() async {
    super.onInit();

    // ROLE_USER
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('ROLE_USER')!.isNotEmpty && pref.getString('ROLE_USER') != ''){
      role = pref.getString('ROLE_USER') ?? '';
      update();
    }

    getCommunity();
  }
}

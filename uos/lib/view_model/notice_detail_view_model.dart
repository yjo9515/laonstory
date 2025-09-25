
import 'dart:developer';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/comment_model.dart';
import 'package:isus_members/domain/repository/board_repository.dart';
import 'package:isus_members/domain/repository/notice_repository.dart';
import 'package:isus_members/view_model/board_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/model/board_model.dart';
import '../domain/model/notice_model.dart';
import 'notice_view_model.dart';

class NoticeDetailViewModel extends GetxController with ApiService{
  Notice? notice;
  String? userStatus;
  String? comment;
  String? report;
  String? boardReport;


  Future<void> getDetailNotice(id) async {
    if (id == null) {
      // id가 null인 경우에 대한 예외 처리
      return;
    }
    await NoticeRepository.to.getDetailNotice(id).then((value) {
      notice = Notice.fromJson(value['data']);
      update();

    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}


  Future<void> deleteNotice(idx) async {
    await NoticeRepository.to.deleteNotice(notice?.idx).then((value) {
      if(value['data'] == 'success'){
        Get.back();
        Get.back();

        final controller = Get.put(NoticeViewModel());
        controller.getNotice();
        Get.snackbar(tr('alert'), '${tr('delComplete')}',backgroundColor: Colors.white,);
      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  getUserStatus() async{
    SharedPreferences store = await SharedPreferences.getInstance();
    userStatus = store.getString('ROLE_USER');
    update();
  }


  @override
  void onInit(){
    // TODO: implement onInit
    final id = Get.parameters['id'];
    getUserStatus();
    getDetailNotice(id);
    super.onInit();
  }
}

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/repository/board_repository.dart';
import 'package:isus_members/domain/repository/notice_repository.dart';
import 'package:isus_members/view_model/board_detail_view_model.dart';

import '../domain/api/api_service.dart';
import '../domain/model/board_model.dart';
import '../domain/model/notice_model.dart';
import 'notice_detail_view_model.dart';

class NoticeEditViewModel extends GetxController with ApiService{

  final id = Get.parameters['id'];
  String? title;
  String? content;
  Notice? notice;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Future<void> getEditNotice() async {
    await NoticeRepository.to.getDetailNotice(id).then((value){
      notice = Notice.fromJson(value['data']);
      title = notice?.title;
      titleController.text = notice!.title!;
      content = notice?.content;
      contentController.text = notice!.content!;
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
    });
  }



  Future<void> patchEditBoard() async {
    await NoticeRepository.to.patchNotice(id, title ?? '', content ?? '').then((value){
      if(value['data'] == 'success'){
        Get.back();
        final controller = Get.put(NoticeDetailViewModel());
        controller.getDetailNotice(id);
        Get.snackbar(tr('alert'), '${tr('notiModiComplete')}',backgroundColor: Colors.white,);
      }
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
    });
  }

  @override
  void onInit(){
    // TODO: implement onInit
    getEditNotice();
    super.onInit();
  }
}
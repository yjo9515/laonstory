import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/repository/board_repository.dart';
import 'package:isus_members/domain/repository/notice_repository.dart';
import 'package:isus_members/view_model/board_detail_view_model.dart';
import 'package:isus_members/view_model/board_view_model.dart';

import '../domain/api/api_service.dart';
import '../domain/model/board_model.dart';
import 'notice_view_model.dart';

class NoticeWriteViewModel extends GetxController with ApiService{

  final id = Get.parameters['id'];
  String? title;
  String? content;
  Board? board;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();



  Future<void> postWriteNotice() async {
    await NoticeRepository.to.postNotice(title ?? '', content ?? '').then((value){
      if(value['data'] == 'success'){
        Get.back();
        final controller = Get.put(NoticeViewModel());
        controller.getNotice();
        Get.snackbar(tr('alert'), '${tr('writeComplete')}',backgroundColor: Colors.white,);
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
    super.onInit();
  }
}


import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isus_members/domain/repository/mypage_repository.dart';
import 'package:isus_members/view_model/mypage_view_model.dart';
import '../domain/api/api_service.dart';
import '../domain/model/user_model.dart';

class MyPageModifyViewModel extends GetxController with ApiService {

  User? user;
  Sns? sns;
  String? id;
  bool imageSelected = false;
  XFile? image;
  String snsType1 = '';
  String snsType2 = '';
  String snsType3 = '';
  String snsType4 = '';
  String snsType5 = '';
  String snsUrl1 = '';
  String snsUrl2 = '';
  String snsUrl3 = '';
  String snsUrl4 = '';
  String snsUrl5 = '';
  File? imageFile;

  changeSocial(value, index){
    switch(index){
      case 1:
        snsType1 = value;
      case 2:
        snsType2 = value;
      case 3:
        snsType3 = value;
      case 4:
        snsType4 = value;
      case 5:
        snsType5 = value;
    }
     update();
  }

  changeUrl(value, index){
    switch(index){
      case 1:
        snsUrl1 = value;
      case 2:
        snsUrl2 = value;
      case 3:
        snsUrl3 = value;
      case 4:
        snsUrl4 = value;
      case 5:
        snsUrl5 = value;
    }
    update();
  }

  Future<void> patchDetailModify() async {
    await MyPageRepository.to.userModify(
      user?.nickname,
      user?.email,user?.phone,user?.affiliation,user?.dept,user?.position,user?.researchField,
        snsType1,snsUrl1,
      snsType2,snsUrl2,
      snsType3,snsUrl3,
      snsType4,snsUrl4,
      snsType5,snsUrl5,
      imageFile,
        imageFile?.path.split('.').last??''
    ).then((value) {
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: '${tr('accountModi')}${tr('complete')}',
          confirm: TextButton(
              onPressed: () {
                Get.back();
                Get.back();
                var con = Get.put(MyPageViewModel());
                con.getUserDetail();
              },
              child: Text(tr('confirm'))));
    }).catchError((e){
      const int chunkSize = 1000; // 한번에 출력할 데이터 길이
      int length = e.toString().length;

      for (int i = 0; i < length; i += chunkSize) {
        int end = (i + chunkSize < length) ? i + chunkSize : length;
        print(e.toString().substring(i, end));
      }
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }


  Future<void> getDetailNotice(id) async {
    if (id == null) {
      // id가 null인 경우에 대한 예외 처리
      return;
    }
    await MyPageRepository.to.getUserDetail(id).then((value) {
      user = User.fromJson(value['data']['user']);
      log(user!.sns.toString());
        for(int e = 0; e < user!.sns!.length; e++ ){

          if(e == 0){
            snsType1 = user!.sns![e].social!;
            snsUrl1 = user!.sns![e].url!;
          }else if(e == 1){
            snsType2 = user!.sns![e].social!;
            snsUrl2 = user!.sns![e].url!;
          }else if(e == 2){
            snsType3 = user!.sns![e].social!;
            snsUrl3 = user!.sns![e].url!;
          }else if(e == 3){
            snsType4 = user!.sns![e].social!;
            snsUrl4 = user!.sns![e].url!;
          }else if(e == 4){
            snsType5 = user!.sns![e].social!;
            snsUrl5 = user!.sns![e].url!;
          }
        }

      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  Future<void> pickImage(value) async {
    
    try{
      final ImagePicker picker = ImagePicker();
      image = await picker.pickImage(source: value);
      if (image != null) {
        log(image.toString());
        log(id!);
        imageFile = File(image!.path);

        // await MyPageRepository.to.profileChange(id, image, image.path.split('.').last ).then((value) {
        //
        //
        //   update();
        // }).catchError((e) =>
        //     Get.defaultDialog(
        //         title: tr('alert')           ,
        //         middleText: e.resultMsg.toString(),
        //         confirm: TextButton(
        //             onPressed: () {
        //               Get.back();
        //             },
        //             child: Text(tr('confirm'))))
        // );
        }
      update();
    }catch(e){
      log(e.toString());
    }
  }

  @override
  void onInit() {
    id = Get.parameters['id'];
    getDetailNotice(id);
    super.onInit();

  }
}

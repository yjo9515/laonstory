import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/repository/splash_repository.dart';

import '../routes/app_pages.dart';

class NotServiceViewModel extends GetxController {

  String alertTitle = '';
  String alertContent = '';

  Future<void> serviceCheck () async {
    await SplashRepository.to.serviceCheck().then((value){
      log(value.toString());
      if(value['result'] == 1){
        alertTitle = value['data']['title'];
        alertContent = value['data']['content'];
      }
    }).catchError((e){
      log(e.toString());
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    serviceCheck();

  }
}

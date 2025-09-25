import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/not_service_view_model.dart';

class NotServiceView extends GetView<NotServiceViewModel> {
  const NotServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NotServiceViewModel>(
        init: NotServiceViewModel(),
        builder: (controller) => Center(
          child: Container(
            height: 600,
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 280,
                  height: 200,
                ),
                Text(controller.alertTitle != '' ? controller.alertTitle : '서비스 중단 안내', style: TextStyle(fontSize: 24),),
                SizedBox(
                  height: 40,
                ),
                Image(
                  image: AssetImage('assets/images/alert_qu.png'),
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(controller.alertContent != '' ? controller.alertContent : '현재 서비스가 중단된 상태입니다. \n 빠른 시일내에 재개 될 수 있도록 하겠습니다.', style: TextStyle(fontSize: 16),)
              ],
            )
          ),
          // child: Container(),
        ),
      ),
    );
  }
}
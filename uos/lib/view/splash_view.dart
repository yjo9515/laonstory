import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/splash_view_model.dart';

//class SplashView extends StatelessWidget  {//이것도 ok!
class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashViewModel>(
        init: SplashViewModel(),
        builder: (_) => Center(
          child: Container(
            child: Image.asset('assets/images/alert_logo.png'),
          ),
          // child: Container(),
        ),
      ),
    );
  }
}
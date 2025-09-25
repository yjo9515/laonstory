
import 'package:get/get.dart';
import 'package:isus_members/view_model/address_view_model.dart';
import 'package:isus_members/view_model/home_view_model.dart';
import 'package:isus_members/view_model/splash_view_model.dart';

import '../../view_model/login_view_model.dart';




class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(() => SplashViewModel());
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    Get.lazyPut<AddressViewModel>(() => AddressViewModel());
  }
}
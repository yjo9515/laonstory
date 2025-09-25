import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/repository/home_repository.dart';

class HomeViewModel extends GetxController {
  final selectedIndex = 0.obs;
  var pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
  }

  void getAddress() {
    HomeRepository.to.getAddress().then((value) {
      print(value);
    });
  }

  Future<void> changeIndex(int index) async {
    if (pageController.hasClients) {
      pageController
          .animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease)
          .then((value) {
        selectedIndex.value = index;
        update();
      });
    }
  }
}

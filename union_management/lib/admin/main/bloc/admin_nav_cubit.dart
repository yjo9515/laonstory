import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/enum/enums.dart';

part 'admin_nav_state.dart';

class AdminNavCubit extends Cubit<AdminNavState> {
  AdminNavCubit(this._pageController) : super(AdminNavState(NavRailItem.stat, 0));

  final PageController _pageController;

  Future<void> onIndexChanged(int index) async {
    switch (index) {
      case 0:
        // await _pageController.animateToPage(
        //   0,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );
        _pageController.jumpToPage(0);

        emit(AdminNavState(NavRailItem.stat, 0));
        break;
      case 1:
        // await _pageController.animateToPage(
        //   1,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );
        _pageController.jumpToPage(1);

        emit(AdminNavState(NavRailItem.user, 1));
        break;
      case 2:
        // await _pageController.animateToPage(
        //   2,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );

        _pageController.jumpToPage(2);
        emit(AdminNavState(NavRailItem.pay, 2));
        break;
      case 3:
        // await _pageController.animateToPage(
        //   3,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );
        _pageController.jumpToPage(3);

        emit(AdminNavState(NavRailItem.event, 3));
        break;
      case 4:
        // await _pageController.animateToPage(
        //   4,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );
        _pageController.jumpToPage(4);

        emit(AdminNavState(NavRailItem.setting, 4));
        break;
    }
  }
}

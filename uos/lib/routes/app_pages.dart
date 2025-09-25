import 'package:get/get.dart';
import 'package:isus_members/view/board_detail_view.dart';
import 'package:isus_members/view/board_edit_view.dart';
import 'package:isus_members/view/board_write_view.dart';
import 'package:isus_members/view/mypage_modify_view.dart';
import 'package:isus_members/view/mypage_view.dart';
import 'package:isus_members/view/notice_view.dart';
import 'package:isus_members/view/notice_write_view.dart';
import 'package:isus_members/view/social_view.dart';
import 'package:isus_members/view/social_detail_view.dart';
import 'package:isus_members/view/social_modify_list_view.dart';
import '../view/binding/binding.dart';
import '../view/home_view.dart';
import '../view/login_view.dart';
import '../view/notice_detail_view.dart';
import '../view/notice_edit_view.dart';
import '../view/splash_view.dart';
import '../view/address_view.dart';
import '../view/board_view.dart';
import '../view/mypage_privacy_view.dart';
import '../view/mypage_password_view.dart';
import '../view/mypage_modify_view.dart';
import '../view/not_service_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.BOARD,
      page: () => const BoardView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.BOARD_DETAIL,
      page: () => BoardDetailView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.BOARD_EDIT,
      page: () => BoardEditView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.BOARD_WRITE,
      page: () => BoardWriteView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.NOTICE,
      page: () => NoticeView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.NOTICE_DETAIL,
      page: () => NoticeDetailView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.NOTICE_EDIT,
      page: () => NoticeEditView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.NOTICE_WRITE,
      page: () => NoticeWriteView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.SOCIAL,
      page: () => const SocialView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_MODIFY_LIST,
      page: () => const SocialModifyListView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_DETAIL,
      page: () => const SocialDetailView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.MYPAGE,
      page: () => const MypageView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.MYPAGE_PRIVACY,
      page: () => const PrivacyView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.MYPAGE_PASSWORD,
      page: () => const MyPagePasswordView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.MYPAGE_MODIFY,
      page: () => const MyPageModifyView(),
      binding: Binding(),
    ),
    GetPage(
      name: _Paths.NOT_SERVICE,
      page: () => const NotServiceView(),
      binding: Binding(),
    ),
  ];
}

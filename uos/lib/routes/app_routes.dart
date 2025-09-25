part of 'app_pages.dart';


abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const ADDRESS = _Paths.ADDRESS;
  static const BOARD = _Paths.BOARD;
  static const BOARD_DETAIL = _Paths.BOARD_DETAIL;
  static const BOARD_EDIT = _Paths.BOARD_EDIT;
  static const BOARD_WRITE = _Paths.BOARD_WRITE;
  static const NOTICE = _Paths.NOTICE;
  static const NOTICE_DETAIL = _Paths.NOTICE_DETAIL;
  static const NOTICE_EDIT = _Paths.NOTICE_EDIT;
  static const NOTICE_WRITE = _Paths.NOTICE_WRITE;
  static const SOCIAL = _Paths.SOCIAL;
  static const SOCIAL_MODIFY_LIST = _Paths.SOCIAL_MODIFY_LIST;
  static const SOCIAL_DETAIL = _Paths.SOCIAL_DETAIL;
  static const MYPAGE = _Paths.MYPAGE;
  static const MYPAGE_PRIVACY = _Paths.MYPAGE_PRIVACY;
  static const MYPAGE_PASSWORD = _Paths.MYPAGE_PASSWORD;
  static const MYPAGE_MODIFY = _Paths.MYPAGE_MODIFY;
  static const NOT_SERVICE = _Paths.NOT_SERVICE;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const ADDRESS = '/address';
  static const BOARD = '/board';
  static const BOARD_DETAIL = '/board/detail/:id';
  static const BOARD_EDIT = '/board/edit/:id';
  static const BOARD_WRITE = '/board/write/:id';
  static const NOTICE = '/notice';
  static const NOTICE_DETAIL = '/notice/detail/:id';
  static const NOTICE_EDIT = '/notice/edit/:id';
  static const NOTICE_WRITE = '/notice/write/:id';
  static const SOCIAL = '/social';
  static const SOCIAL_MODIFY_LIST = '/social/list';
  static const SOCIAL_DETAIL = '/social/:id';
  static const MYPAGE = '/mypage';
  static const MYPAGE_PRIVACY = '/mypage/privacy';
  static const MYPAGE_PASSWORD = '/mypage/password';
  static const MYPAGE_MODIFY = '/mypage/modify/:id';
  static const NOT_SERVICE = '/notservice';
}



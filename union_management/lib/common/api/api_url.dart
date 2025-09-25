import 'package:flutter/foundation.dart';

const serverUrl =
// kDebugMode ?
// "http://localhost:8000/api/v1"
// :'http://union.oig.kr/api';
//     "http://158.247.211.232:22828/api/v1";
    'http://union.oig.kr/api';
const loginUrl = "$serverUrl/auth/login";
const adminLoginUrl = "$serverUrl/auth/admin/login";
const adminInfoUrl = "$serverUrl/auth/admin/info";
const emailAuthUrl = "$serverUrl/auth/emailAuth";
const checkEmailUrl = '$serverUrl/auth/checkEmail';
const adminUserUrl = "$serverUrl/admin/user";
const adminEventUrl = "$serverUrl/event";
const adminSettingUrl = "$serverUrl/notice";
const adminMangerUrl = "$serverUrl/manager";
const adminDashboardUrl = "$serverUrl/admin/dashboard";
const dashboardUrl = "$serverUrl/dashboard";
const adminPayDetailUrl = "$serverUrl/admin/pay/detail";
const adminPointDetailUrl = "$serverUrl/admin/point/detail";
const adminPayUrl = "$serverUrl/admin/pay";
const adminPointUrl = "$serverUrl/admin/point";
const checkAdminTokenUrl = '$serverUrl/auth/admin/checkToken';
const signUpUrl = "$serverUrl/auth/signup";
const guestSignUpUrl = "$serverUrl/auth/guestSignup";
const signUpAdminUrl = "$serverUrl/auth/admin/signup";
const checkAuthUrl = "$serverUrl/auth/checkAuth";
const checkTokenUrl = "$serverUrl/auth/checkToken";
const refreshTokenUrl = "$serverUrl/auth/refreshToken";
const setFcmTokenUrl = "$serverUrl/auth/fcmToken";
const getUserInfoUrl = "$serverUrl/auth/userInfo";
const getUserLikeBrandUrl = "$serverUrl/brand/likeBrands";
const getUserTitleUrl = "$serverUrl/auth/userTitle";
const getUserAlertUrl = '$serverUrl/alert/checkAlert';
const noticeUrl = "$serverUrl/notice";
const eventUrl = "$serverUrl/event";
const questionUrl = "$serverUrl/notice/question";
const homeUrl = "$serverUrl/home";
const alertUrl = "$serverUrl/alert";

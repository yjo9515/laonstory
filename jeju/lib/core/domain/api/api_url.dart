import 'package:flutter/foundation.dart';

const serverUrl =
    // 'http://192.168.0.12:9123/api/v1';
    'http://192.168.0.106:9123/api/v1';
    // kDebugMode
    // ?
    // 'http://192.168.0.216:9123/api/v1';
    // :
// 'http://192.168.0.216:9123/api/v1' :
//     'http://192.168.0.216:9123/api/v1';

const authUrl = '$serverUrl/auth';

const checkAuthUrl = '$serverUrl/auth/check';
const loginUrl = '$serverUrl/auth/login';
const checkTokenUrl = '$serverUrl/auth/token';
const refreshTokenUrl = '$serverUrl/auth/refresh';
const hostUrl = '$serverUrl/host';
const hostInfoUrl = '$serverUrl/host/me';
const hostRegisterUrl = '$serverUrl/host/register';
const hostUpdateUrl = '$serverUrl/host/update';
const themeUrl = '$serverUrl/facilityTheme';
const hostMessageListUrl = '$serverUrl/host/message/list';
const userMessageListUrl = '$serverUrl/user/message/list';
const hostRoomListUrl = '$serverUrl/host/accommodation/list';
const userRoomListUrl = '$serverUrl/user/accommodation/list';
const reservationListUrl = '$serverUrl/user/reservation/list';
const reservationOrderUrl = '$serverUrl/user/reservation/order';
const addRoomUrl = '$serverUrl/host/accommodation';
const userMyInfoUrl = '$serverUrl/user/me';
const emailAuthUrl = '$serverUrl/auth/email';
const imageUrl = '$serverUrl/resource/image?path=';
const notificationUrl = '$serverUrl/user/notification';
const addressUrl = 'https://dapi.kakao.com/v2/local/search/address.json';
const userBoardUrl = '$serverUrl/user/board';

const resourceUrl = '$serverUrl/resource/image';

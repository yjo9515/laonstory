import 'package:flutter/material.dart';

enum StatusCode { success, notFound, unAuthorized, badRequest, timeout, forbidden, error, multiple }

enum CommonStatus { initial, ready, success, loading, failure, route }

enum TokenStatus { initial, hasToken, noToken, guestToken }

enum SignUpStatus { initial, oauth, oauthSuccess, success, failure }

enum LoginMethod { kakao, naver, google, apple }

enum OrderType { desc, asc }

enum FilterType { none, number, disable, enable, deviceID }

enum NavRailItem { stat, user, notification, setting }

enum NavbarItem { home, search, book, message, myPage }

enum LoginStatus { login, logout }

enum AlertType { notice, like }

enum ImageType { camera, gallery }

enum NotificationType { notice, event }

enum TokenType { none, authToken, refreshToken, customToken }

enum PermissionType { camera, location, manager }

enum TermType { service, privacy, host }

enum TickerStatus { initial, run, pause, complete }

enum InteractionType { nfc, beacon, manual }

enum ChartType { month, year, day }

enum Path { left, right }

enum UserType { guest, host }

/// PASS 인증 상태
enum HostStatus {
  WAITING,
  ACTIVE;

  const HostStatus();

  static HostStatus strToEnum(String? str) {
    if (str == null) {
      return HostStatus.WAITING;
    }
    return HostStatus.values.byName(str);
  }
}

/// 숙소 상태
enum RoomStatus {
  WAITING,
  ACTIVE,
  REJECT,
  STOP,
  DELETED,
  BLOCKED;

  const RoomStatus();

  static RoomStatus strToEnum(String? str) {
    if (str == null) {
      return RoomStatus.DELETED;
    }
    return RoomStatus.values.byName(str);
  }

  static String enumToData(RoomStatus? status) => switch (status) {
        RoomStatus.WAITING => '등록 대기 중',
        RoomStatus.ACTIVE => '운영 중',
        RoomStatus.REJECT => '등록 반려',
        RoomStatus.STOP => '운영 중지',
        RoomStatus.DELETED => '삭제',
        RoomStatus.BLOCKED => '정지',
        _ => '등록 대기 중',
      };

  static String strToData(String? str) {
    if (str == null) {
      return '등록 대기 중';
    }
    return enumToData(strToEnum(str));
  }

  static Color strToColor(String? str) => switch (strToEnum(str)) {
        RoomStatus.WAITING => Colors.orange,
        RoomStatus.ACTIVE => Colors.green,
        RoomStatus.STOP => Color.fromARGB(255, 170, 176, 182),
        RoomStatus.REJECT || RoomStatus.DELETED || RoomStatus.BLOCKED => Colors.red,
      };

  static String strToDescription(String? str) => switch (strToEnum(str)) {
        RoomStatus.ACTIVE => '게스트가 숙소 검색이 가능하며 예약할 수 있고 예약 가능날짜를 검색할 수 있습니다.',
        RoomStatus.WAITING => '숙소 등록을 완료하였으나 관리자의 검토가 필요합니다.',
        RoomStatus.REJECT => '숙소 등록이 반려되였습니다.',
        RoomStatus.STOP => '숙소 예약과 검색이 불가능하지만 숙소는 정상적으로 보존됩니다.',
        RoomStatus.DELETED => '영구적으로 숙소가 삭제되므로 다시 활성화할 수 없습니다.',
        RoomStatus.BLOCKED => '숙소가 정지되었습니다.',
      };
}

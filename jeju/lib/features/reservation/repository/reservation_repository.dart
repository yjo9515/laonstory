import '../../../core/core.dart';

class ReservationRepository with CommonRepository {
  static ReservationRepository get to => ReservationRepository();

  Future<List<Reservation>> getData() async {
    try {
      var result = await get(reservationListUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          List<dynamic>? dataList = result.$2['data']['items'];
          if (dataList != null) {
            List<Reservation> reservations =
                dataList.map((item) => Reservation.fromJson(item)).toList();
            return reservations;
          } else {
            return [];
          }
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> getDetailData(reservationId) async {
    try {
      var result = await get('$reservationListUrl/$reservationId',
          token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> cancelReservation(reservationId) async {
    try {
      var result = await patch('$reservationOrderUrl/cancel/$reservationId',
          token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> postReservation(int? id, var request) async {
    try {
      var result = await post('$reservationOrderUrl/request/$id',
          body: request, token: TokenType.authToken);
      logger.d(result.$2);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  //호스트 예약관련

  Future<Map<String, dynamic>> getHostReservationData(
      accommodationId, endDate, startDate) async {
    try {
      var result = await get(
        '$hostRoomListUrl/$accommodationId/management',
        query: 'endDate=$endDate&startDate=$startDate',
        token: TokenType.authToken,
      );
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> postMemo(int? id, memo) async {
    try {
      final result = await ReservationRepository.to.post(
          '$hostRoomListUrl/reservation/$id/management/host/memo',
          body: {'memo': memo},
          token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> postHostManagement(int? id, var request) async {
    try {
      var result = await post('$hostRoomListUrl/$id/management/host',
          body: request, token: TokenType.authToken);
      logger.d(result.$2);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<ListModel<Reservation>?> getMyReservationList() async {
    try {
      var result = await get('${serverUrl}/host/reservation/main', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return ListModel<Reservation>.fromJson(result.$2);
          // return result.$2;
        default:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }
}

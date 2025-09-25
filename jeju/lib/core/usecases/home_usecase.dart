import 'dart:io';

import 'package:jeju_host_app/features/home/repository/home_repository.dart';

import '../core.dart';

class HomeUsecase {
  static HomeUsecase get to => HomeUsecase();

  Future<ListModel<Room>?> getRoomList({String? search, int? page = 1}) async {
    return await HomeRepository.to.searchRoom(page: page, search: search).then((value) => value).catchError((e) {
      if (e is ExceptionModel) {
        throw LogicalException(code: 'E400', message: '${e.message}');
      } else if (e is SocketException) {
        throw const NetworkException(code: 'E503', message: '네트워크 연결을 확인해주세요.');
      } else {
        throw const UnknownException(code: 'E500', message: '알 수 없는 오류가 발생했습니다.');
      }
    });
  }
}

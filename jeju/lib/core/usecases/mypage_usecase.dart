import 'dart:io';
import '../../features/mypage/repository/mypage_repository.dart';
import '../core.dart';

class MypageUsecase {
  static MypageUsecase get to => MypageUsecase();

  Future<Model<Profile>?> getProfile({required UserType userType}) async {
    final repository = MypageRepository(userType: userType);
    return await repository.getProfile().then((value) => value).catchError((e) {
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

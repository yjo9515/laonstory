import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/features/mypage/repository/mypage_repository.dart';

import '../../../core/core.dart';
import '../../../core/usecases/room_usecase.dart';
import '../../global/bloc/global_bloc.dart';

part 'generated/mypage_bloc.g.dart';
part 'mypage_event.dart';
part 'mypage_state.dart';

class MypageBloc extends Bloc<CommonEvent, MypageState> {
  MypageBloc({this.globalBloc}) : super(const MypageState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<PickImage>(_onPickImage);
  }

  final GlobalBloc? globalBloc;

  _onInitial(Initial event, Emitter<MypageState> emit) async {
    globalBloc?.add(const GetUserInfo());
    // if(globalBloc?.state.secureModel.hostStatus == UserType.host) {
    //   await RoomUseCase.to.getHostRoomList().then((value) {
    //   emit(state.copyWith(rooms: value?.data?.items ?? [], pageInfo: value?.pageInfo,));
    // });
    // }
    // await MypageUsecase.to.getProfile(userType: ).then((value) => logger.d('OK')).catchError((e) => add(Error(e)));
  }

  _onError(Error event, Emitter<MypageState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onPickImage(PickImage event, Emitter<MypageState> emit) async {
    try {
      emit(state.copyWith(status: CommonStatus.loading));

      final ImagePicker picker = ImagePicker();
      var file = <XFile>[];

        final image = await picker.pickImage(source: event.source);
        if (image != null) {
          // state.images?.clear();
          file.add(image);
          emit(state.copyWith(status: CommonStatus.initial, images: List.of([])..addAll(file)));
          logger.d(state.images);
          await MypageRepository(userType: event.userType).postImage(state.images ?? []).then((value) {
            logger.d(value);
            emit(state.copyWith(status: CommonStatus.success));
          }).catchError((e) =>
              emit(state.copyWith(status: CommonStatus.failure, errorMessage: e))
          );
        }

    } catch (e) {
      logger.d(e);
      add(const Error(LogicalException(message: '이미지 업로드 오류가 발생했습니다.')));
    }
  }
}

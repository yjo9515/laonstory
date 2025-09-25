import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
import '../../room/repository/room_repository.dart';

part 'generated/home_bloc.g.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<CommonEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<Initial>(_onInitial);
    on<Search>(_onSearch);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<HomeState> emit) async {
    final themeMap = <String?, List<Facility>?>{};
    final facilityMap = <String?, List<Facility>?>{};
    await RoomRepository.to.getTheme().then((value) {
      for (var element in value) {
        if (element.name == '시설') {
          element.type?.forEach((e) {
            facilityMap[e.name] = e.facilityThemeList;
          });
        } else {
          element.type?.forEach((e) {
            themeMap[e.name] = e.facilityThemeList;
          });
        }
      }
      emit(state.copyWith(themes: themeMap, facilities: facilityMap ));

    }).catchError((e) =>
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()))
    );
    await RoomRepository.to.getNewRoomList().then((value) {
      emit(state.copyWith(newRooms: value.data?.items ?? [], pageInfo: value.pageInfo, status: CommonStatus.success));
    }).catchError((e) =>
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()))
    );
    await RoomRepository.to.getPickRoomList().then((value) {
      emit(state.copyWith(pickRooms: value.data?.items ?? [], pageInfo: value.pageInfo, status: CommonStatus.success));
    }).catchError((e) =>
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()))
    );
  }

  _onSearch(Search event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: CommonStatus.route, query: event.query, route: '/room/list'));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onError(Error event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }
}

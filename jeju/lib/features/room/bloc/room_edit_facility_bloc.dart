import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/core/usecases/room_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../repository/room_repository.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomEditFacilityBloc extends Bloc<CommonEvent, RoomManagementState> with StreamTransform {
  RoomEditFacilityBloc() : super(const RoomManagementState()) {
    on<Initial>(_onInitial);
    on<Edit>(_onEdit);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<RoomManagementState> emit) async {
    emit(state.copyWith(addressStatus: CommonStatus.initial, status: CommonStatus.initial));
    final themeMap = <String?, List<Facility>?>{};
    final facilityMap = <String?, List<Facility>?>{};
    await RoomUseCase.to.getHostRoomList().then((value) {
      emit(state.copyWith(rooms: value?.data?.items ?? [], pageInfo: value?.pageInfo));
      if (state.rooms.isNotEmpty) {
        add(ChangePickRoom(room: value?.data?.items?.first ?? const Room()));
      }
    });
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
      logger.d(state.room.theme);
      emit(state.copyWith(themes: themeMap, facilities: facilityMap, selectedFacilities: state.room.facility, selectedThemes: state.room.theme));
      logger.d(state.selectedThemes);
    });
  }


  _onError(Error event, Emitter<RoomManagementState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }


  _onEdit(Edit event, Emitter<RoomManagementState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading, room: state.room.copyWith(updateType: event.data?['updateType'])));
    logger.d(state.room.toJson());
    await RoomRepository.to.editRoom(state.room, state.images ?? []).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
  }
}

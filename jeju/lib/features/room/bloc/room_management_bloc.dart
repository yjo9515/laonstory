import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/core/usecases/room_usecase.dart';
import 'package:jeju_host_app/features/room/widget/reorderable_list_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../repository/room_repository.dart';
import '../widget/edit_reorderable_list_widget.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomManagementBloc extends Bloc<CommonEvent, RoomManagementState> with StreamTransform {
  RoomManagementBloc() : super(const RoomManagementState()) {
    on<Initial>(_onInitial);
    on<PageNate>(_onPageNate, transformer: throttleDroppable(duration: const Duration(seconds: 1)));
    on<ChangePickRoom>(_onChangePickRoom);
    on<CheckOwner>(_onCheckOwner);
    on<ChangeRoom>(_onChangeRoom);
    on<SelectFacility>(_onSelectFacility);
    on<CheckPermission>(_onCheckPermission);
    on<PickImage>(_onPickImage);
    on<EditReorder>(_onEditReorder);
    on<Edit>(_onEdit);
    on<EditRemove>(_onEditRemove);
    on<Error>(_onError);
    on<ChangeTab>(_onChangeTab);
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
    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      emit(state.copyWith(status: CommonStatus.initial));
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
    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      emit(state.copyWith(status: CommonStatus.initial));
    });
    try{
      emit(state.copyWith(themes: themeMap, facilities: facilityMap, selectedFacilities: state.room.facility, selectedThemes: state.room.theme, images: state.room.imageList.isNotEmpty ? state.room.imageList.map((e) => FileDTO(networkImagePath: e.path)).toList() : []));

    }catch(e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      emit(state.copyWith(status: CommonStatus.initial));
    }
  }
  _onChangeTab(ChangeTab event, Emitter<RoomManagementState> emit) async {
    logger.d(state.room.id);
    await RoomRepository.to.getHostDetailRoomList(state.room.id.toString()).then((value) {
      logger.d(value);
      emit(state.copyWith(room:Room.fromJson(value)));

      });
  }


  _onChangePickRoom(ChangePickRoom event, Emitter<RoomManagementState> emit) async {
    emit(state.copyWith(room: event.room));
    if ((state.room.facility).isNotEmpty) {
      for (var element in state.room.facility) {
        state.facilities.forEach((key, value) {
          final result = value?.indexWhere((e) => e.contain(element)) ?? -1;
          if (result != -1) {
            value![result].select = true;
          }
        });
      }
    }
    emit(state.copyWith(facilities: state.facilities));

    if ((state.room.theme).isNotEmpty) {
      for (var element in state.room.theme) {
        state.themes.forEach((key, value) {
          final result = value?.indexWhere((e) => e.contain(element)) ?? -1;
          if (result != -1) {
            value![result].select = true;
          }
        });
      }
    }
    emit(state.copyWith(themes: state.themes));
    try{
      emit(state.copyWith(images: state.room.imageList.isNotEmpty ? state.room.imageList.map((e) => FileDTO(networkImagePath: e.path)).toList() : []));
    }catch(e){
      logger.d(e);
      add(Error(LogicalException(message: '숙소 선택에 실패했습니다.',code: e.toString())));
    }
  }

  _onCheckOwner(CheckOwner event, Emitter<RoomManagementState> emit) {
    emit(state.copyWith(owner: event.owner, room: state.room.copyWith(possessionClassification: event.owner == '부동산 명의자에게 임대운영에 동의를 구한 경우' ? 'RENTAL' : 'HOST')));
  }

  _onChangeRoom(ChangeRoom event, Emitter<RoomManagementState> emit) {
    emit(state.copyWith(room: event.room,status: CommonStatus.loading));
  }

  _onSelectFacility(SelectFacility event, Emitter<RoomManagementState> emit) {
    emit(state.copyWith(status: CommonStatus.loading,isInitial: event.isInitial));
    try{
      if (event.facility != null) {
        state.facilities.forEach((key, value) {
          final result = value?.indexWhere((element) => element == event.facility) ?? -1;
          if (result != -1) {
            if (event.select) {
              final room = state.room.copyWith(
                  facility: List.of(state.room.facility)
                    ..add(event.facility!)
                    ..toSet());
              emit(state.copyWith(room: room));
            } else {
              final room = state.room.copyWith(
                  facility: List.of(state.room.facility)
                    ..remove(event.facility!)
                    ..toSet());
              emit(state.copyWith(room: room));
            }
            emit(state.copyWith(
                facilities: state.facilities
                  ..update(key, (value) {
                    value![result].select = event.select;
                    return value;
                  })));
          }
        });
      } else {
        state.themes.forEach((key, value) {
          final result = value?.indexWhere((element) => element == event.theme) ?? -1;
          if (result != -1) {
            if (event.select) {
              final room = state.room.copyWith(
                  theme: List.of(state.room.theme)
                    ..add(event.theme!)
                    ..toSet());
              emit(state.copyWith(room: room));
            } else {
              final room = state.room.copyWith(
                  theme: List.of(state.room.theme)
                    ..remove(event.theme!)
                    ..toSet());
              emit(state.copyWith(room: room));
            }
            emit(state.copyWith(
                themes: state.themes
                  ..update(key, (value) {
                    value![result].select = event.select;
                    return value;
                  })));
          }
        });
      }
    }catch(e){
      add(Error(LogicalException(message: '테마 선택에 오류가 발생했습니다.',code: e.toString())));
    }
  }

  _onCheckPermission(CheckPermission event, Emitter<RoomManagementState> emit) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.camera,
    ].request();

    var camera = statuses[Permission.camera] ?? PermissionStatus.denied;
    var photos = statuses[Permission.photos] ?? PermissionStatus.denied;

    switch ((camera, photos)) {
      case (PermissionStatus.granted, PermissionStatus.granted):
        add(PickImage(source: event.source));
        break;
      case (PermissionStatus.denied, PermissionStatus.granted):
        await Permission.camera.request().then((value) {
          return add(CheckPermission(source: event.source));
        });
        break;
      case (PermissionStatus.granted, PermissionStatus.denied):
        await Permission.photos.request().then((value) {
          return add(CheckPermission(source: event.source));
        });
        break;
      case (PermissionStatus.denied, PermissionStatus.denied):
        break;
      case (_, _):
        openAppSettings();
        break;
    }
  }

  _onPickImage(PickImage event, Emitter<RoomManagementState> emit) async {
    try {
      emit(state.copyWith(status: CommonStatus.loading));

      final ImagePicker picker = ImagePicker();
      var file = <XFile>[];
      if (event.multiImage) {
        file.addAll(await picker.pickMultiImage());
      } else {
        final image = await picker.pickImage(source: event.source);
        if (image != null) {
          file.add(image);
        }
      }

            emit(state.copyWith(status: CommonStatus.initial, images: List.of(state.images ?? [])..addAll([FileDTO(xfile: file.single)])));

    } catch (e) {
      add(const Error(LogicalException(message: '이미지 업로드 오류가 발생했습니다.')));
    }
  }

  Future<PlatformFile?> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: false, withReadStream: true, allowedExtensions: ['jpg', 'png', 'jpeg']);
    return result?.files.first;
  }

  _onError(Error event, Emitter<RoomManagementState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onEditReorder(EditReorder event, Emitter<RoomManagementState> emit) {
    // emit(state.copyWith(images: event.images));
  }

  _onEditRemove(EditRemove event, Emitter<RoomManagementState> emit) {
  try{
    if(event.index != null){
      // state.room.imageList.map((Resource e){
      //   if(e.path == state.images?[event.index!].path)
      //   {
      //     logger.d(e.id);
      //     state.deleteImageIdList?.add(e);
      //
      //   }else{
      //     logger.d(e.path);
      //     logger.d(state.images?[event.index!].path);
      //   }
      // });
      if(state.room.imageList.length >= event.index!){
        if(state.room.imageList[event.index!].path == event.deleteImage?.networkImagePath){
          List<int> r = state.room.deleteImageIdList ?? [];
          r?.insert(0,state.room.imageList[event.index!].id!);
          emit(state.copyWith(room: state.room.copyWith(deleteImageIdList: r),images: event.images));

        }
      }


    }else{
      emit(state.copyWith(images: event.images));
    }
  }catch(e){
    logger.d(e);
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
  }


  }

  _onEdit(Edit event, Emitter<RoomManagementState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading,room: state.room.copyWith(updateType: event.data?['updateType']),themes: state.themes,facilities: state.facilities));
    logger.d(state.room.toJson());
    logger.d(state.images);
    await RoomRepository.to.editRoom(state.room, state.images ??  []).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
  }

  _onPageNate(PageNate event, Emitter<RoomManagementState> emit) async {
    if (!(state.pageInfo?.isLast ?? false)) {
      emit(state.copyWith(status: CommonStatus.loading));
      await RoomUseCase.to.getHostRoomList(page: (state.pageInfo?.page ?? 1) + 1).then((value) {
        emit(state.copyWith(status: CommonStatus.initial, rooms: List.of(state.rooms)..addAll(value?.data?.items ?? []), pageInfo: value?.pageInfo));
      }).catchError((e) {
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      });
    }
  }
}

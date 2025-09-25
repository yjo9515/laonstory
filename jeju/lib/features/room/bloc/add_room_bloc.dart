import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../repository/room_repository.dart';
import 'room_event.dart';
import 'room_state.dart';

class AddRoomBloc extends Bloc<CommonEvent, AddRoomState> {
  AddRoomBloc() : super(const AddRoomState()) {
    on<Initial>(_onInitial);
    on<SearchAddress>(_onSearchAddress);
    on<SelectAddress>(_onSelectAddress);
    on<ReTypeAddress>(_onReTypeAddress);
    on<CheckOwner>(_onCheckOwner);
    on<ChangeRoom>(_onChangeRoom);
    on<SelectFacility>(_onSelectFacility);
    on<CheckPermission>(_onCheckPermission);
    on<PickImage>(_onPickImage);
    on<Reorder>(_onReorder);
    on<Remove>(_onRemove);
    on<Add>(_onAdd);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<AddRoomState> emit) async {
    emit(state.copyWith(addressStatus: CommonStatus.initial, status: CommonStatus.initial));
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
      emit(state.copyWith(themes: themeMap, facilities: facilityMap, room: Room(checkIn: DateTime(2023, 1, 1, 15, 0), checkOut: DateTime(2023, 1, 1, 11, 0))));
    });
  }

  _onSearchAddress(SearchAddress event, Emitter<AddRoomState> emit) async {
    await RoomRepository.to.getGeo(event.address).then((value) {
      emit(state.copyWith(documents: value.documents, addressStatus: CommonStatus.success));
      // return emit(state.copyWith(documents: value.documents, addressStatus: CommonStatus.success));
    }).catchError((e) {
      emit(state.copyWith(addressStatus: CommonStatus.failure));
      add(const Error(NotFoundException(message: '주소를 찾을 수 없습니다.')));
    });
  }

  _onSelectAddress(SelectAddress event, Emitter<AddRoomState> emit) {
    final document = state.documents?[event.index];
    emit(state.copyWith(document: document));
    final room = state.room.copyWith(
      address: Address(
        address: document?.roadAddress?.addressName ?? document?.address?.addressName!,
        code: document?.roadAddress?.zoneNo,
        location: Location(
          latitude: double.parse(document?.y ?? '37.47'),
          longitude: double.parse(document?.x ?? '126.88'),
        ),
      ),
    );
    emit(state.copyWith(room: room, addressStatus: CommonStatus.success));
  }

  _onReTypeAddress(ReTypeAddress event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(addressStatus: CommonStatus.initial, room: state.room.copyWith(address: null), document: null, documents: null));
  }

  _onCheckOwner(CheckOwner event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(owner: event.owner, room: state.room.copyWith(possessionClassification: event.owner == '부동산 명의자에게 임대운영에 동의를 구한 경우' ? 'RENTAL' : 'HOST')));
  }

  _onChangeRoom(ChangeRoom event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(room: event.room));
  }

  _onSelectFacility(SelectFacility event, Emitter<AddRoomState> emit) {
    if (event.facility != null) {
      logger.d(state.facilities);
      state.facilities.forEach((key, value) {
        final result = value?.indexWhere((element) => element == event.facility) ?? -1;
        if (result != -1) {
          if (event.select) {
            final room = state.room.copyWith(
                facility: List.of(state.room.facility)
                  ..add(event.facility!..facilityThemeId = event.facility!.id)
                  ..toSet());
            emit(state.copyWith(room: room));
          } else {
            final room = state.room.copyWith(
                facility: List.of(state.room.facility)
                  ..remove(event.facility!..facilityThemeId = event.facility!.id)
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
                  ..add(event.theme!..facilityThemeId = event.theme!.id)
                  ..toSet());
            emit(state.copyWith(room: room));
          } else {
            final room = state.room.copyWith(
                theme: List.of(state.room.theme)
                  ..remove(event.theme!..facilityThemeId = event.theme!.id)
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
  }

  _onCheckPermission(CheckPermission event, Emitter<AddRoomState> emit) async {
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

  _onPickImage(PickImage event, Emitter<AddRoomState> emit) async {
    try {
      emit(state.copyWith(status: CommonStatus.loading));

      final ImagePicker picker = ImagePicker();
      var file = <XFile>[];
      if (event.multiImage) {
        logger.d('멀티');
        file.addAll(await picker.pickMultiImage());
      } else {
        final image = await picker.pickImage(source: event.source);
        if (image != null) {
          file.add(image);
        }
      }
      if(state.images == null){
        logger.d('ddd');
        emit(state.copyWith(status: CommonStatus.initial, images: List.of(state.images ?? [])..addAll(file)));
      }
      else{
        for(XFile k in state.images!){
          for(XFile e in file){
            if(k.name == e.name){
              add(const Error(LogicalException(message: '중복된 이미지가 존재합니다. 다른 이미지를 선택해주세요.')));
             return;
            }
          }

        }
                   emit(state.copyWith(status: CommonStatus.initial, images: List.of(state.images ?? [])..addAll(file)));
      }
    } catch (e) {
      logger.d(e);
      add(const Error(LogicalException(message: '이미지 업로드 오류가 발생했습니다.')));
    }
  }

  Future<PlatformFile?> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: false, withReadStream: true, allowedExtensions: ['jpg', 'png', 'jpeg']);
    return result?.files.first;
  }

  _onError(Error event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onReorder(Reorder event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(images: event.images));
  }

  _onRemove(Remove event, Emitter<AddRoomState> emit) {
    // emit(state.copyWith(images: event.images));
    emit(state.copyWith(images: event.images));
  }

  _onAdd(Add event, Emitter<AddRoomState> emit) async {
    await RoomRepository.to.addRoom(state.room, state.images ?? []).then((value) => emit(state.copyWith(status: CommonStatus.success))).catchError((e) => add(Error(e)));
  }
}

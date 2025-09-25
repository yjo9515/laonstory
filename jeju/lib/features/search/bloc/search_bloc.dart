import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/search/bloc/search_event.dart';
import 'package:jeju_host_app/features/search/bloc/search_state.dart';
import 'package:jeju_host_app/main.dart';

import '../../../core/core.dart';
import '../../room/repository/room_repository.dart';



class SearchBloc extends Bloc<CommonEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<Initial>(_onInitial);
    on<ChangeRange>((event, emit) => emit(state.copyWith(priceRange: event.range,)));
    on<SelectTheme>(_onSelectTheme);
    on<SelectDate>(_onSelectDate);
    on<SelectAddress>((event, emit) => emit(state.copyWith(address: event.address,)));
    on<SelectRange>(_onSelectRange);
    on<SelectCount>((event, emit) => emit(state.copyWith(people: event.count,)));
    on<SelectFloor>((event, emit) => emit(state.copyWith(floor: event.floor,)));
    on<SearchRoom>(_onSearchRoom);

  }

  _onInitial(Initial event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: CommonStatus.initial));
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
      emit(state.copyWith(themes: themeMap,checkIn:DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), checkOut: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).add(Duration(days: 6))));
      emit(state.copyWith(status: CommonStatus.success));
    });
  }


  _onSelectTheme(SelectTheme event, Emitter<SearchState> emit) async {
    // try{
    //
    //   state.themes.forEach((key, value) {
    //     final result = value?.indexWhere((element) => element == event.theme) ?? -1;
    //     if (result != -1) {
    //       if (event.select) {
    //         final room = state.room.copyWith(
    //             theme: List.of(state.room.theme)
    //               ..add(event.theme!..facilityThemeId = event.theme!.id)
    //               ..toSet());
    //         emit(state.copyWith(room: room));
    //       } else {
    //         final room = state.room.copyWith(
    //             theme: List.of(state.room.theme)
    //               ..remove(event.theme!..facilityThemeId = event.theme!.id)
    //               ..toSet());
    //         emit(state.copyWith(room: room));
    //       }
    //       emit(state.copyWith(
    //           themes: state.themes
    //             ..update(key, (value) {
    //               value![result].select = event.select;
    //               logger.d(value);
    //               return value;
    //             })));
    //     }
    //   });
    // }catch(e){
    //   logger.d(e);
    // }
    logger.d(event.theme?.id);
    emit(state.copyWith(selectTheme: event.theme));
  }
  _onSelectDate(SelectDate event, Emitter<SearchState> emit) async {
    if(event.type == 0){
      emit(state.copyWith(
          // checkIn: DateFormat().format(event.date);
          checkIn: event.date

      ));
    }else{
      emit(state.copyWith(
          checkOut:event.date
      ));
    }
  }

  _onSelectRange(SelectRange event, Emitter<SearchState> emit){
    logger.d(event.range);
    if(event.range == '일주일' || state.range == null){
      if(state.checkIn != null){
        emit(state.copyWith(checkOut: state.checkIn!.add(Duration(days: 6))));
      }

    } else if(event.range == '보름'){
      emit(state.copyWith(checkOut: state.checkIn!.add(Duration(days: 13))));
    } else if(event.range == '한달'){
      emit(state.copyWith(checkOut: state.checkIn!.add(Duration(days: 29))));
    } else if(event.range == '한 달 이상'){
      emit(state.copyWith(checkOut: state.checkIn!.add(Duration(days: 300))));
    }
        emit(state.copyWith(range: event.range,));
  }

  _onSearchRoom(SearchRoom event, Emitter<SearchState> emit) async {
    await RoomRepository.to.getSearch(event.body).then((value) {
      try{
        List<Room> searchList = (value['data']['items'] as List).map((item) => Room.fromJson(item)).toList();
        emit(state.copyWith(status: CommonStatus.route, searchList: searchList));
      }catch(e){
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
        logger.d(e);
      }

      emit(state.copyWith(status: CommonStatus.initial));
    });
  }
}

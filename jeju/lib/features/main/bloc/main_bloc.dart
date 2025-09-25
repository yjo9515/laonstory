import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<IndexChanged>(_onIndexChanged);
    on<PageChanged>(_onPageChanged);
  }



  Future<void> _onIndexChanged(IndexChanged event, Emitter<MainState> emit) async {
    if(event.pageController.hasClients){
      switch (event.index) {
        case 0:
          await event.pageController
              .animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          )
              .then((value) => emit(const MainState(navbarItem: NavbarItem.home, index: 0)));
          break;
        case 1:
          await event.pageController
              .animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          )
              .then((value) => emit(const MainState(navbarItem: NavbarItem.search, index: 1)));
          break;
        case 2:
          await event.pageController
              .animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          )
              .then((value) => emit(const MainState(navbarItem: NavbarItem.book, index: 2)));
          break;
        case 3:
          await event.pageController
              .animateToPage(
            3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          )
              .then((value) => emit(const MainState(navbarItem: NavbarItem.message, index: 3)));
          break;
        case 4:
          await event.pageController
              .animateToPage(
            4,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          )
              .then((value) => emit(const MainState(navbarItem: NavbarItem.myPage, index: 4)));
          break;
      }
    }

  }

  void _onPageChanged(PageChanged event, Emitter<MainState> emit) {
    // switch (event.index) {
    //   case 0:
    //     emit(const MainState(NavbarItem.home, 0));
    //     break;
    //   case 1:
    //     emit(const MainState(NavbarItem.search, 1));
    //     break;
    //   case 2:
    //     emit(const MainState(NavbarItem.book, 2));
    //     break;
    //   case 3:
    //     emit(const MainState(NavbarItem.message, 3));
    //     break;
    //   case 4:
    //     emit(const MainState(NavbarItem.myPage, 4));
    //     break;
    // }
  }
}

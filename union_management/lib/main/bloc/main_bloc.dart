import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'main_event.dart';
part 'main_state.dart';

enum NavbarItem { home, myPage }

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState(NavbarItem.home, 0)) {
    on<IndexChanged>(_onIndexChanged);
    on<PageChanged>(_onPageChanged);
  }


  Future<void> _onIndexChanged(IndexChanged event, Emitter<MainState> emit) async {
    switch (event.index) {
      case 0:
        await event.pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        emit(const MainState(NavbarItem.home, 0));
        break;
      case 1:
        await event.pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        emit(const MainState(NavbarItem.myPage, 1));
        break;
    }
  }

  void _onPageChanged(PageChanged event, Emitter<MainState> emit) {
    switch (event.index) {
      case 0:
        emit(const MainState(NavbarItem.home, 0));
        break;
      case 1:
        emit(const MainState(NavbarItem.myPage, 1));
        break;
    }
  }
}

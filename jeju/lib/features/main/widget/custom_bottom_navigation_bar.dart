import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/main_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: context.colorScheme.bottomNavigationBarSurface,
      ),
      child: Action(pageController: pageController),
    );
  }
}

class Action extends StatelessWidget {
  const Action({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GlobalBloc, GlobalState, SecureModel>(
      selector: (state) => state.secureModel,
      builder: (context, globalState) {
        return BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: context.textTheme.krBottom,
              unselectedLabelStyle: context.textTheme.krBottom,
              onTap: (index) => {HapticFeedback.lightImpact(), context.read<MainBloc>().add(IndexChanged(pageController: pageController, index: index))},
              items: switch (globalState.hostStatus) {
                UserType.guest => [
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_home.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_home.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "홈",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_search.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_search.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "탐색",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_book.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_book.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "나의예약",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_chat.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_chat.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "메시지",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_profile.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_profile.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "마이페이지",
                    ),
                  ],
                UserType.host => [
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_home.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_home.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "홈",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_calander.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_calander.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "예약관리",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_room.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_room.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "숙소관리",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_chat.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_chat.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "메시지",
                    ),
                    BottomNavigationBarItem(
                      tooltip: "",
                      activeIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_profile.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        ),
                      ),
                      icon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: SvgImage(
                          "assets/icons/ic_profile.svg",
                          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        ),
                      ),
                      label: "마이페이지",
                    ),
                  ],
              },
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/main_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: initialIndex);

    return BlocProvider(
      create: (context) => MainBloc()..add(IndexChanged(index: initialIndex, pageController: pageController)),
      child: BlocSelector<MainBloc, MainState, NavbarItem>(
        selector: (state) => state.navbarItem,
        builder: (context, mainState) {
          return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              return state.tokenStatus == TokenStatus.initial
                  ? Container(
                      color: black,
                    )
                  : Scaffold(
                      extendBody: true,
                      body: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) => context.read<MainBloc>().add(PageChanged(index: index)),
                        controller: pageController,
                        children: state.secureModel.hostStatus == UserType.guest
                            ? [
                                const UserHomePage(),
                                SearchPage(),
                                const MyReservationPage(),
                                MessageListPage(index: mainState.index, type: UserType.guest,),
                                const MyPage(),
                              ]
                            : [
                                HostHomePage(
                                  onReservation: () {
                                    context.read<MainBloc>().add(IndexChanged(index: 1, pageController: pageController));
                                  },
                                  onMyRoom: () => context.read<MainBloc>().add(IndexChanged(index: 2, pageController: pageController)),
                                ),
                                ReservationManagementPage(index: mainState.index),
                                RoomManagementPage(index: mainState.index),
                                MessageListPage(index: mainState.index,type: UserType.host,),
                                const MyPage(),
                              ],
                      ),
                      bottomNavigationBar: CustomBottomNavigationBar(pageController: pageController),
                    );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style.dart';
import '../main/bloc/admin_main_bloc.dart';
import '../main/bloc/admin_nav_cubit.dart';

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Theme(
        data: ThemeData(
          navigationRailTheme: const NavigationRailThemeData(
            useIndicator: false,
            selectedIconTheme: IconThemeData(color: black),
            unselectedIconTheme: IconThemeData(color: white),
          ),
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BlocProvider(
          create: (context) => AdminNavCubit(pageController),
          child: BlocBuilder<AdminNavCubit, AdminNavState>(
            builder: (context, state) {
              return LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: BlocSelector<AdminMainBloc, AdminMainState, String?>(
                        selector: (state) => state.adminInfo?.role,
                        builder: (context, mainState) {
                          return NavigationRail(
                            onDestinationSelected: (index) => context.read<AdminNavCubit>().onIndexChanged(index),
                            backgroundColor: black,
                            minWidth: 120,
                            leading: Container(
                                height: 120,
                                margin: const EdgeInsets.only(bottom: 80),
                            ),
                            destinations: navigationRailDestinations(state, mainState),
                            selectedIndex: state.index,
                          );
                        },
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  navigationRailDestinations(AdminNavState state, String? role) {
    if (role == 'ROLE_ADMIN') {
      return <NavigationRailDestination>[
        NavigationRailDestination(
            icon: state.index == 0
                ? Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                    child: const Icon(
                      Icons.bar_chart,
                      size: 32,
                    ),
                  )
                : const Icon(Icons.bar_chart, size: 32),
            label: Container()),
        NavigationRailDestination(
            icon: state.index == 1
                ? Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                    child: const Icon(
                      Icons.person,
                      size: 32,
                    ),
                  )
                : const Icon(Icons.person, size: 32),
            label: Container()),
        NavigationRailDestination(
            icon: state.index == 2
                ? Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                    child: const Icon(
                      Icons.campaign,
                      size: 32,
                    ),
                  )
                : const Icon(Icons.campaign, size: 32),
            label: Container()),
        NavigationRailDestination(
            icon: state.index == 3
                ? Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                    child: const Icon(
                      Icons.settings,
                      size: 32,
                    ),
                  )
                : const Icon(Icons.settings, size: 32),
            label: Container()),
      ];
    }
    else if (role == 'ROLE_MANAGER') {
      return <NavigationRailDestination>[

        NavigationRailDestination(
            icon: state.index == 0
                ? Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
              child: const Icon(
                Icons.person,
                size: 32,
              ),
            )
                : const Icon(Icons.person, size: 32),
            label: Container()),

      ];
    }
    return <NavigationRailDestination>[
      NavigationRailDestination(
          icon: state.index == 0
              ? Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                  child: const Icon(
                    Icons.bar_chart,
                    size: 32,
                  ),
                )
              : const Icon(Icons.bar_chart, size: 32),
          label: Container()),
      NavigationRailDestination(
          icon: state.index == 1
              ? Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
                  child: const Icon(
                    Icons.person,
                    size: 32,
                  ),
                )
              : const Icon(Icons.person, size: 32),
          label: Container()),
      NavigationRailDestination(
          icon: state.index == 2
              ? Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
            child: const Icon(
              Icons.attach_money,
              size: 32,
            ),
          )
              : const Icon(Icons.attach_money, size: 32),
          label: Container()),
      NavigationRailDestination(
          icon: state.index == 3
              ? Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
            child: const Icon(
              Icons.campaign,
              size: 32,
            ),
          )
              : const Icon(Icons.campaign, size: 32),
          label: Container()),
      NavigationRailDestination(
          icon: state.index == 4
              ? Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: white),
            child: const Icon(
              Icons.settings,
              size: 32,
            ),
          )
              : const Icon(Icons.settings, size: 32),
          label: Container()),
    ];
  }
}

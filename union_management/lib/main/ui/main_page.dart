import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_management/login/ui/login_page.dart';

import '../../common/style.dart';
import '../../global/bloc/global_bloc.dart';
import '../../home/ui/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    BlocProvider.of<GlobalBloc>(context).add(InitialToken(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      buildWhen: (prev, state) => prev.tokenStatus != state.tokenStatus,
      builder: (context, state) {
        return AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              const begin = 0.0;
              const end = 1.0;
              final tween = Tween(begin: begin, end: end);
              return FadeTransition(opacity: animation.drive(tween.chain(CurveTween(curve: Curves.easeIn))), child: child);
            },
            duration: const Duration(milliseconds: 500),
            child: state.tokenStatus == TokenStatus.initial
                ? Container(
                    color: primary,
                    child: Center(
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        width: 200,
                      ),
                    ),
                  )
                : state.tokenStatus == TokenStatus.noToken
                    ? const LoginPage()
                    : const Scaffold(
                        backgroundColor: white2,
                        body: HomePage(),
                      ));
      },
    );
  }
}

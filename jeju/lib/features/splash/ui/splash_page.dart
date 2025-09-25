import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: BlocListener<SplashBloc, SplashState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == CommonStatus.success) {
            switch (state.tokenStatus) {
              case TokenStatus.hasToken:
                context.go('/');
                break;
              default:
                context.go('/login/false');
                break;
            }
          }
        },
        child: BlocConsumer<GlobalBloc, GlobalState>(
          buildWhen: (prev, curr) => prev.tokenStatus != curr.tokenStatus,
          listener: (context, globalState) {
            if (globalState.tokenStatus != TokenStatus.initial) {
              context.read<SplashBloc>().add(Initial(data: globalState.tokenStatus));
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: mainJeJuBlue,
              body: Center(
                child: BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/jejusale_splash.json',
                          height: 160,
                          animate: state.status == CommonStatus.loading,
                          repeat: false,
                          onLoaded: (composition) {
                            context.read<GlobalBloc>().add(const Initial());
                          },
                        ),
                        state.done ? Hero(tag: 'logo', child: Image.asset('assets/images/logo_zero_shadow.png', height: 160)) : Container(),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

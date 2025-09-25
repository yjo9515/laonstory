import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.back});

  final bool back;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(const Initial()),
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, globalState) {
          return BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              switch (state.status) {
                case CommonStatus.success:
                  if (back) {
                    context.read<GlobalBloc>().add(const SetData());
                    context.pop();
                  } else {
                    context.go('/');
                  }
                  break;
                case CommonStatus.failure:
                  if (state.errorMessage == null || state.errorMessage!.isEmpty || state.errorMessage!.contains('null') || state.errorMessage!.contains('error')) return;
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text(
                            '알림',
                          ),
                          content: Text(
                            state.errorMessage ?? '',
                          ),
                          actions: <Widget>[
                            adaptiveAction(
                              context: context,
                              onPressed: () => Navigator.pop(context, '확인'),
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      });

                  break;
                default:
                  break;
              }
            },
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: mainJeJuBlue,
                  appBar: back
                      ? CustomAppBar(
                          backButton: true,
                          color: mainJeJuBlue,
                          textTitle: '',
                          leadingAction: InkWell(
                              splashFactory: NoSplash.splashFactory,
                              splashColor: white.withOpacity(0),
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(Icons.arrow_back_ios, color: white)),
                        )
                      : null,
                  body: Center(
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Hero(
                            tag: 'logo',
                            child: Stack(
                              children: [Image.asset('assets/images/logo_image.png', height: 160), Image.asset('assets/images/logo_zero_shadow.png', height: 160)],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.read<LoginBloc>().add(const Login(LoginMethod.kakao));
                            },
                            child: const SvgImage('assets/images/kakao_login.svg'),
                          ),
                          const SizedBox(height: 24),
                          InkWell(
                              onTap: () {
                                context.read<LoginBloc>().add(const Login(LoginMethod.naver));
                              },
                              child: const SvgImage('assets/images/naver_login.svg')),
                          const SizedBox(height: 24),
                          InkWell(
                              onTap: () {
                                context.read<LoginBloc>().add(const Login(LoginMethod.google));
                              },
                              child: const SvgImage('assets/images/google_login.svg')),
                          const SizedBox(height: 24),
                          if (defaultTargetPlatform == TargetPlatform.iOS)
                            InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(const Login(LoginMethod.apple));
                                },
                                child: const SvgImage('assets/images/apple_login.svg')),
                          if (defaultTargetPlatform == TargetPlatform.iOS) const SizedBox(height: 80),
                          if (!back)
                            TextButton(
                              onPressed: () {
                                context.go('/');
                              },
                              child: Text(
                                '로그인 없이 둘러보기',
                                style: context.textTheme.krBody2.copyWith(color: white),
                              ),
                            ),
                          if (back) const SizedBox(height: 48),
                          // const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../../main.dart';
import '../../features.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/guide_bloc.dart';

final guideKey = GlobalKey();

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        backButton: true,
        textTitle: '호스트 등록/호스팅가이드',
      ),
    );
  }
}

class HostGuidePage extends StatelessWidget {
  const HostGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuideBloc(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: context.colorScheme.guideBackground,
        appBar: const CustomAppBar(
          backButton: true,
          textTitle: '호스트 등록/호스팅가이드',
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const HostStepWidget(text: '1'),
                  const HostStepWidget(text: '2'),
                  const HostStepWidget(text: '3'),
                  const HostStepWidget(text: '4'),
                  const SizedBox(height: 16),
                  BlocSelector<GuideBloc, GuideState, bool>(
                    selector: (state) => state.agree,
                    builder: (context, state) {
                      return Container(
                        key: guideKey,
                        child: TermCheckboxWidget(
                          termType: TermType.host,
                          onCheck: (value) {
                            context.read<GuideBloc>().add(Agree(agree: value));
                          },
                          agree: state,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: LargeButton.of(context).floatingActionButtonHeight),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocSelector<GuideBloc, GuideState, bool>(
          selector: (state) => state.agree,
          builder: (context, state) {
            return BlocSelector<GlobalBloc, GlobalState, SecureModel>(
              selector: (state) => state.secureModel,
              builder: (context, globalState) {
                return LargeButton(
                  onTap: () async {
                    if (state) {
                      context.read<GuideBloc>().add(const RegisterHost());
                      await context.read<GuideBloc>().stream.first.then((value) {
                        if (value.status == CommonStatus.success) {
                          AppConfig.to.shared.setBool('host_guide', true);
                          var secureModel = SecureModel(tokenData: TokenData());
                          secureModel.hostStatus = UserType.host;
                          context.read<GlobalBloc>().add(const SetData());
                          context.push('/guide/host/done');
                        } else if (value.status == CommonStatus.failure) {
                          if (value.errorMessage?.contains('호스트가 이미 등록되어있습니다.') ?? false) {
                            AppConfig.to.shared.setBool('host_guide', true);
                            // AppConfig.to.secureModel.hostStatus = UserType.host;
                            var secureModel = SecureModel(tokenData: TokenData());
                            secureModel.hostStatus = UserType.host;
                            context.read<GlobalBloc>().add(const SetData());
                            // context.push('/guide/host/done');
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    title: const Text(
                                      '알림',
                                    ),
                                    content: Text(
                                      value.errorMessage ?? '',
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
                            return;
                          }
                          showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: const Text(
                                    '알림',
                                  ),
                                  content: Text(
                                    value.errorMessage ?? '',
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
                        }
                      });
                    } else {
                      Scrollable.ensureVisible(guideKey.currentContext!, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut, alignment: 0);
                    }
                  },
                  text: state ? '호스트 등록하기' : '다음',
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class HostGuideDonePage extends StatefulWidget {
  const HostGuideDonePage({Key? key}) : super(key: key);

  @override
  State<HostGuideDonePage> createState() => _HostGuideDonePageState();
}

class _HostGuideDonePageState extends State<HostGuideDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to.timer(time: 3).timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.go('/');
      // context.goNamed('hostmain');

      // context.go('/signup/host/1');

    }).listen((event) {
      if (event <= 0) {
        context.go('/');

        // context.go('/signup/host/1');
      }
      setState(() {
        second = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.activeButton,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('', style: context.textTheme.krBody5.copyWith(color: white)),
              const Spacer(),
              ConfettiWidget(
                numberOfParticles: 20,
                emissionFrequency: 0.015,
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 12,
                minBlastForce: 7,
                gravity: 0.3,
                shouldLoop: false,
                colors: const [Colors.green, Colors.greenAccent, Colors.blue, Colors.pink, Colors.blueAccent, Colors.pinkAccent, Colors.orange, Colors.purple],
              ),
              Image.asset('assets/images/popper.webp', width: 40),
              const SizedBox(height: 32),
              Text('축하합니다!', style: context.textTheme.krPoint1.copyWith(color: white)),
              Text('호스트 등록이 완료 되었습니다.', style: context.textTheme.krPoint1.copyWith(color: white)),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('${second}초뒤 호스트 홈으로', style: context.textTheme.krBody5.copyWith(color: white))),
            ],
          ),
        ),
      ),
    );
  }
}

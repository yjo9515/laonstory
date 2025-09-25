import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';

class PaymentDonePage extends StatefulWidget {
  const PaymentDonePage({super.key});

  @override
  State<PaymentDonePage> createState() => _PaymentDonePageState();
}

class _PaymentDonePageState extends State<PaymentDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to.timer(time: 3).timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.goNamed('main', queryParameters: {'index': '2'});
    }).listen((event) {
      if (event <= 0) {
        context.goNamed('main', queryParameters: {'index': '2'});
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
              Text('예약이 완료되었습니다!\n이제 즐거운 여행을 기다려볼까요?', style: context.textTheme.krPoint1.copyWith(color: white), textAlign: TextAlign.center),
              const SizedBox(height: 56),
              Text('예약한 숙소 정보는 [나의 예약]에서 확인해보세요', style: context.textTheme.krBody3.copyWith(color: white)),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('$second초뒤 나의 예약페이지로', style: context.textTheme.krBody5.copyWith(color: white))),
            ],
          ),
        ),
      ),
    );
  }
}

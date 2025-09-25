import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/core.dart';
class ReservationDonePage extends StatefulWidget {
  const ReservationDonePage({Key? key,}) : super(key: key);


  @override
  State<ReservationDonePage> createState() => _ReservationDonePage();
}

class _ReservationDonePage extends State<ReservationDonePage> {
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

      /// todo 상세페이지 라우팅
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('예약 취소가 완료되었어요!', style: context.textTheme.krPoint1.copyWith(color: white)),
              const SizedBox(height: 24),
              Text('영업일 2~3일 내에 환불정책에 따라 환불 될 예정입니다.', style: context.textTheme.krBody1.copyWith(color: white)),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('$second초뒤 나의예약페이지로', style: context.textTheme.krBody5.copyWith(color: white))),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

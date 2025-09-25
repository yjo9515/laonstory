import 'package:flutter/material.dart';

import '../core.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key, required this.begin, required this.end}) : super(key: key);

  final double begin;
  final double end;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: begin,
        end: end,
      ),
      builder: (context, value, _) => LinearProgressIndicator(
        value: value,
        backgroundColor: black6,
        color: mainJeJuBlue,
      ),
    );
  }
}

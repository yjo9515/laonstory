import 'package:flutter/material.dart';

import '../core.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({Key? key, this.theme = ''}) : super(key: key);

  final String theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: mainJeJuBlue, width: 0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        theme,
        style: context.textTheme.krBody1.copyWith(color: mainJeJuBlue),
      ),
    );
  }
}

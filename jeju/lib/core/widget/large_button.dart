import 'package:flutter/material.dart';

import '../core.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({Key? key, this.onTap, this.text, this.centerWidget, this.color, this.margin}) : super(key: key);

  final Function()? onTap;
  final String? text;
  final Widget? centerWidget;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  double get floatingActionButtonHeight => _floatingActionButtonHeight;
  static const double _floatingActionButtonHeight = 120.0;

  static LargeButton of(BuildContext context) => context.findAncestorWidgetOfExactType<LargeButton>() ?? const LargeButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 72),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(border: Border.all(color: black5, width: 0.5), color: color ?? context.colorScheme.activeButton, borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          child: Center(
            child: centerWidget ??
                Text(
                  text ?? '',
                  style: context.textTheme.krButton1.copyWith(color: white),
                ),
          ),
        ),
      ),
    );
  }
}

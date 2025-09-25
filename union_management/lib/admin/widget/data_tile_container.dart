import 'package:flutter/material.dart';

import '../../common/style.dart';

class DataTileContainer extends StatelessWidget {
  const DataTileContainer({Key? key, required this.width, this.height, required this.child, this.minHeight}) : super(key: key);

  final double? width;
  final double? height;
  final double? minHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
        boxShadow: [
          BoxShadow(color: black.withOpacity(0.1), offset: const Offset(-20, -10), spreadRadius: -11, blurRadius: 39),
          BoxShadow(color: black.withOpacity(0.15), offset: const Offset(0, 4), spreadRadius: -13, blurRadius: 41),
        ],
      ),
      child: child,
    );
  }
}

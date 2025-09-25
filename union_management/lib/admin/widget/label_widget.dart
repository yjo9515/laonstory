import 'package:flutter/material.dart';

import '../../common/style.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({Key? key, required this.text, required this.color}) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: textTheme(context).krSubtext1,
        ),
        const SizedBox(width: 4),
        Container(
          width: 16,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
        ),
      ],
    );
  }
}

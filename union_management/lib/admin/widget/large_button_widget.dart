import 'package:flutter/material.dart';

import '../../common/style.dart';

class LargeButtonWidget extends StatelessWidget {
  const LargeButtonWidget({Key? key, required this.text, required this.onClick, this.isEnabled, this.height, this.width}) : super(key: key);

  final String text;
  final Function() onClick;
  final bool? isEnabled;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: isEnabled ?? true
            ? Theme.of(context).elevatedButtonTheme.style
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(gray2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
        onPressed: isEnabled ?? true ? onClick : null,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
              child: Text(
            text,
            style: textTheme(context).krSubtitle1.copyWith(color: white),
          )),
        ));
  }
}

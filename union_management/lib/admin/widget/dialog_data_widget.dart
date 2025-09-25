import 'package:flutter/material.dart';

import '../../common/style.dart';

class DialogDataWidget extends StatelessWidget {
  const DialogDataWidget({Key? key, required this.title, required this.content}) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme(context).krSubtext2,
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: textTheme(context)
                      .krSubtext1
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(width: 24),
            Container(
              width: 1,
              height: 24,
              color: const Color(0xffA6AEBA),
            ),
          ],
        ));
  }
}

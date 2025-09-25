import 'package:flutter/material.dart';

import '../core.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.title, this.go = false, this.onTap, this.room}) : super(key: key);

  final Room? room;
  final String title;
  final bool go;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(title, style: context.textTheme.krSubtitle1),
          const Spacer(),
          if (go)
            InkWell(
              onTap: onTap,
              child: const SvgImage(
                'assets/icons/ic_arrow_right.svg',
                height: 16,
              ),
            ),
        ],
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  const ContentText({Key? key, required this.content, this.go = false, this.onTap}) : super(key: key);

  final String content;
  final bool go;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(content, style: context.textTheme.krBody3),
          const Spacer(),
          if (go)
            InkWell(
              onTap: onTap,
              child: const SvgImage(
                'assets/icons/ic_arrow_right.svg',
                height: 16,
              ),
            ),
        ],
      ),
    );
  }
}

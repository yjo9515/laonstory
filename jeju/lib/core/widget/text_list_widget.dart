import 'package:flutter/material.dart';

import '../core.dart';

class ListTitleButton extends StatelessWidget {
  const ListTitleButton({Key? key, required this.title, this.subtitle}) : super(key: key);

  final String title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: black6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(title, style: context.textTheme.krSubtitle1),
          const Spacer(),
          subtitle ?? Container(),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_outlined, color: black3, size: 16),
        ],
      ),
    );
  }
}

class ListTextButton extends StatelessWidget {
  const ListTextButton({Key? key, required this.text, required this.date}) : super(key: key);

  final String text;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: black6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(child: Text(text, style: context.textTheme.krSubtitle1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          Text(dateDotParser(date), style: context.textTheme.krBody3.copyWith(color: black3)),
        ],
      ),
    );
  }
}

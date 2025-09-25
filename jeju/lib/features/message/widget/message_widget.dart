import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, this.onTap, this.onLongPress, this.message}) : super(key: key);

  final Function()? onTap;
  final Function()? onLongPress;
  final Message? message;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      onLongPress: () {
        onLongPress?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage('https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}'),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('김민경', style: context.textTheme.krBody4),
                      const SizedBox(width: 8),
                      Text('[제주시] 혼자서 하얗게 No.1', style: context.textTheme.krBody1.copyWith(color: black3)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(message?.content ?? '', style: context.textTheme.krBody3, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

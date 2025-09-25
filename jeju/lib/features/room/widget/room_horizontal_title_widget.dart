import 'package:flutter/material.dart';

import '../../../core/core.dart';

class RoomHorizontalTitleWidget extends StatelessWidget {
  const RoomHorizontalTitleWidget({Key? key, this.room}) : super(key: key);

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${room?.name}',
              style: context.textTheme.krSubtitle1,
            ),
          ),
          const Icon(Icons.star, color: pointJeJuYellow, size: 16),
          const SizedBox(width: 8),
          Text('${(room?.score ?? 0)} (${(room?.reviewCount ?? 0)})', style: context.textTheme.krBody1),
        ],
      ),
    );
  }
}

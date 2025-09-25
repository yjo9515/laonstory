import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';

class RoomMinimalWidget extends StatelessWidget {
  const RoomMinimalWidget({super.key, this.room});

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('room', pathParameters: {'path': 'detail'}, queryParameters: {'id': '1'});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        constraints: const BoxConstraints(minWidth: 136, maxWidth: 180),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageBuilder: (context, provider) => AspectRatio(
                aspectRatio: 1,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 136, maxWidth: 180),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image: provider, fit: BoxFit.cover),
                  ),
                ),
              ),
              imageUrl: room == null || room!.imageList.isEmpty || room?.imageList.first.path == null
                  ? 'https://picsum.photos/${Random().nextInt(100) + 200}/${Random().nextInt(100) + 200}'
                  : '$imageUrl${room?.imageList.first.path}',
              placeholder: (context, url) => AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 136, maxWidth: 180),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('${room?.name}', style: context.textTheme.krSubtitle1, textAlign: TextAlign.left, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (room?.disCountPercent != 0) AutoSizeText('${room?.disCountPercent?.toStringAsFixed(0)}%', style: context.textTheme.krBody2.copyWith(color: Colors.red)),
                const SizedBox(width: 8),
                AutoSizeText(numberFormatter(room?.oneDayAmount), style: context.textTheme.krButton1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

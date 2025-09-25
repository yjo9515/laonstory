import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class RoomBigImage extends StatelessWidget {
  const RoomBigImage({super.key, this.room});

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(image:room?.imageList != null && room!.imageList.isNotEmpty ? NetworkImage('$imageUrl${room?.imageList.first.path}') : NetworkImage('https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

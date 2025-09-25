import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jeju_host_app/features/room/widget/add_naver_map_widget.dart';

import '../../../core/core.dart';
import '../../features.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key, this.room}) : super(key: key);

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(title: "숙소 위치"),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text('${room?.address?.address ?? ''} ${room?.address?.addressDetail ?? ''}', style: context.textTheme.krBody3.copyWith(color: black3))),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Platform.isAndroid
                ? GoogleMapWidget(x: room?.address?.location!.longitude, y: room?.address?.location!.latitude)
                : AppleMapWidget(x: room?.address?.location?.longitude, y: room?.address?.location?.latitude),
          ),
        ),
      ],
    );
  }
}

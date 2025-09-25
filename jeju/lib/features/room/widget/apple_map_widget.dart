import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

class AppleMapWidget extends StatelessWidget {
  const AppleMapWidget({super.key, required this.x, required this.y});

  final double? x;
  final double? y;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: AppleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(x ?? 37.47, y ?? 126.88),
          zoom: 18,
        ),
        annotations: {Annotation(annotationId: AnnotationId('1'), position: LatLng(x ?? 37.47, y ?? 126.88), icon: BitmapDescriptor.markerAnnotation)},
      ),
    );
  }
}

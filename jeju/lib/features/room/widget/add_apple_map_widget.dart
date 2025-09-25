import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_room_bloc.dart';
import '../bloc/room_state.dart';

class AddAppleMapWidget extends StatefulWidget {
  const AddAppleMapWidget({super.key});

  @override
  State<AddAppleMapWidget> createState() => _AddAppleMapWidgetState();
}

class _AddAppleMapWidgetState extends State<AddAppleMapWidget> {
  late AppleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomBloc, AddRoomState>(
      listenWhen: (previous, current) => previous.document != current.document,
      listener: (context, state) {
        if (state.document != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')),
            zoom: 18,
          )));
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: AppleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')),
              zoom: 18,
            ),
            annotations: {
              Annotation(
                  annotationId: AnnotationId('1'), position: LatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')), icon: BitmapDescriptor.markerAnnotation)
            },
          ),
        );
      },
    );
  }
}

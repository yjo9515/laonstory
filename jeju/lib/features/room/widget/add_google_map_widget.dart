import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/add_room_bloc.dart';
import '../bloc/room_state.dart';

class AddGoogleMapWidget extends StatefulWidget {
  const AddGoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<AddGoogleMapWidget> createState() => _AddGoogleMapWidgetState();
}

class _AddGoogleMapWidgetState extends State<AddGoogleMapWidget> {

  late GoogleMapController mapController;

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
          child: GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(target: LatLng(double.parse(state.document?.y ?? '37.541'), double.parse(state.document?.x ?? '126.986')), zoom: 15),
            minMaxZoomPreference: const MinMaxZoomPreference(8, 17),
            markers: {
              if (state.document != null)
                Marker(
                  markerId: const MarkerId('1'),
                  position: LatLng(double.parse(state.document?.y ?? '37.541'), double.parse(state.document?.x ?? '126.986')),
                  icon: BitmapDescriptor.defaultMarker,
                )
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/config/logger.dart';
import '../../../core/type/exception.dart';

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({super.key, required this.x, required this.y});

  double? x;
  double? y;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late NaverMapController mapcontroller;
  // late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(32),
    //   child: GoogleMap(
    //     onMapCreated: (controller) => mapController = controller,
    //     initialCameraPosition: CameraPosition(target: LatLng(widget.x ?? 37.47, widget.y ?? 126.88), zoom: 15),
    //     minMaxZoomPreference: const MinMaxZoomPreference(8, 17),
    //     markers: {
    //         Marker(
    //           markerId: const MarkerId('1'),
    //           position: LatLng(widget.x ?? 37.47, widget.y ?? 126.88),
    //           icon: BitmapDescriptor.defaultMarker,
    //         )
    //     },
    //   ),
    // );
    return ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child:
            NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                    // target: NLatLng(widget.y ?? 0,widget.x ?? 0),
                    target : NLatLng(widget.y ?? 37.47, widget.x?? 126.88),
                    zoom: 15,
                    bearing: 0,
                    tilt: 0
                ),
              ), // 지도 옵션을 설정할 수 있습니다.
              forceGesture: false, // 지도에 전달되는 제스처 이벤트의 우선순위를 가장 높게 설정할지 여부를 지정합니다.
              onMapReady: (controller) {
                mapcontroller = controller;
                final marker = NMarker(id: 'test', position: NLatLng(widget.y ?? 37.47, widget.x?? 126.88));
                mapcontroller.updateCamera(NCameraUpdate.scrollAndZoomTo(target: marker.position));
                mapcontroller.addOverlay(marker);
              },
              // onMapTapped: (point, latLng) {
              //   logger.d(latLng);
              // },
              // onSymbolTapped: (symbol) {},
              // onCameraChange: (position, reason) {
              //   logger.d('카메라 이동중');
              // },
              // onCameraIdle: () {
              //   logger.d('카메라 이동끝');
              //
              // },
              // onSelectedIndoorChanged: (indoor) {},
            )
          // GoogleMap(
          //   onMapCreated: (controller) => mapController = controller,
          //   initialCameraPosition: CameraPosition(target: LatLng(double.parse(state.document?.y ?? '37.541'), double.parse(state.document?.x ?? '126.986')), zoom: 15),
          //   minMaxZoomPreference: const MinMaxZoomPreference(8, 17),
          //   markers: {
          //     if (state.document != null)
          //       Marker(
          //         markerId: const MarkerId('1'),
          //         position: LatLng(double.parse(state.document?.y ?? '37.541'), double.parse(state.document?.x ?? '126.986')),
          //         icon: BitmapDescriptor.defaultMarker,
          //       )
          //   },
          // ),
        );
  }
}

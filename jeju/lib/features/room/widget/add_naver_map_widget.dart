import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:jeju_host_app/core/config/logger.dart';

import '../../../core/type/exception.dart';
import '../bloc/add_room_bloc.dart';
import '../bloc/room_state.dart';

class AddNaverMapWidget extends StatefulWidget {
  const AddNaverMapWidget({Key? key}) : super(key: key);
  @override
  State<AddNaverMapWidget> createState() => _AddNaverMapWidgetState();
}

class _AddNaverMapWidgetState extends State<AddNaverMapWidget> {


  // late GoogleMapController mapController;
late NaverMapController mapcontroller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomBloc, AddRoomState>(
      listenWhen: (previous, current) => previous.document != current.document,
      listener: (context, state) {
        // if (state.document != null) {
        //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //     target: LatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')),
        //     zoom: 18,
        //   )));
        // }
        if (state.document != null) {
          logger.d(state.document?.address);
          logger.d(state.document?.x);
          logger.d(state.document?.y);
            mapcontroller.updateCamera(NCameraUpdate.scrollAndZoomTo(target: NLatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')))).catchError(
                    (e) => LogicalException(code: '${e.hashCode}', message: '${e.message}')
            );
          final marker = NMarker(id: 'test', position: NLatLng(double.parse(state.document?.y ?? '37.47'), double.parse(state.document?.x ?? '126.88')));
          mapcontroller.addOverlay(marker);
        }
      },
      builder: (context, state) {
        return
            ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child:
                NaverMap(
                  options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                        target: NLatLng(double.parse(state.document?.y ?? '37.541'), double.parse(state.document?.x ?? '126.986')),
                        zoom: 15,
                        bearing: 0,
                        tilt: 0
                    ),
                  ), // 지도 옵션을 설정할 수 있습니다.
                  forceGesture: true, // 지도에 전달되는 제스처 이벤트의 우선순위를 가장 높게 설정할지 여부를 지정합니다.
                  onMapReady: (controller) {
                    // controller.addOverlay(overlay)
                    logger.d('로드댐');
                    mapcontroller = controller;
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
      },
    );
  }
}

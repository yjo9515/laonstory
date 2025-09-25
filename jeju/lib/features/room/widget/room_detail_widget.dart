import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/features/room/bloc/room_detail_bloc.dart';
import 'package:jeju_host_app/features/room/bloc/room_state.dart';

import '../../../core/core.dart';
import '../../features.dart';
import 'room_widget.dart';

class RoomDetailWidget extends StatelessWidget {
  const RoomDetailWidget({super.key, this.room, this.scrollController, this.calenderKey, this.onDateRangeChanged, this.calenderDate, this.imageList,this.host, this.stopHosting, this.plusPrice});

  final Room? room;
  final ScrollController? scrollController;
  final Key? calenderKey;
  final Function(DateRange?)? onDateRangeChanged;
  final DateTime? calenderDate;
  final List<XFile>? imageList;
  final Profile? host;
  final List<DateTime>? stopHosting;
  final List<DateManagement>? plusPrice;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            SizedBox(height: 480, width: double.infinity, child: RoomImageWidget(room: room, imageList: imageList)),
            Container(
              margin: const EdgeInsets.only(top: 400),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InfoWidget(room: room),
                  if (imageList == null) TitleText(room: room, title: "숙소 일정"),
                  if (imageList == null)
                    SafeArea(
                        key: calenderKey,
                        child: CalenderWidget(
                          plusPrice: plusPrice ?? [],
                          stopHosting:stopHosting ?? [],
                          calenderDate: calenderDate ?? DateTime.now(),
                          onDateRangeChanged: (value) {
                            onDateRangeChanged?.call(value);
                          },
                        )),
                  MapWidget(room: room),
                  if(host != null)TitleText(title: '호스트정보'),
                  if(host != null)ProfileWidget(
                    profile: host,
                    hostStatus: UserType.guest,
                    loginStatus: LoginStatus.login,
                    otherView: true,
                    room:room
                  ),
                  if(host != null)ProfileDataWidget(profile: host),
                  if(imageList == null) const SizedBox(height: kBottomNavigationBarHeight + 80),
                ],
              ),
            ),
          ],
        ),
      );
  }
}

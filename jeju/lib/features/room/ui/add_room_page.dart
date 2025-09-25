import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/features/main/bloc/main_bloc.dart';
import 'package:jeju_host_app/features/room/widget/add_naver_map_widget.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/add_room_bloc.dart';
import '../bloc/room_event.dart';
import '../bloc/room_state.dart';

part '../widget/add_room_done_page.dart';
part '../widget/add_room_eighth_page.dart';
part '../widget/add_room_examine_page.dart';
part '../widget/add_room_fifth_page.dart';
part '../widget/add_room_first_page.dart';
part '../widget/add_room_forth_page.dart';
part '../widget/add_room_second_page.dart';
part '../widget/add_room_seventh_page.dart';
part '../widget/add_room_sixth_page.dart';
part '../widget/add_room_third_page.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({Key? key, required this.step}) : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRoomBloc()..add(const Initial()),
      child: BlocBuilder<AddRoomBloc, AddRoomState>(
        builder: (context, state) {
          return const AddRoomFirstPage();
        },
      ),
    );
  }
}

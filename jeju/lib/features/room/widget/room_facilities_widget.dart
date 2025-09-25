import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/room_event.dart';
import '../bloc/room_management_bloc.dart';
import '../bloc/room_state.dart';
import 'icon_item_widget.dart';

class RoomFacilitiesWidget extends StatelessWidget {
  const RoomFacilitiesWidget({Key? key, required this.bloc}) : super(key: key);

  final RoomManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomManagementBloc, RoomManagementState>(
      bloc: bloc,
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    '숙박업이 아닌 비사업자/임대 사업자의 경우 욕실 용품 제공이 불가합니다 (샴푸, 린스, 화장지, 수건, 칫솔, 비누, 치약, 바디워시 등)',
                    style: context.textTheme.krBody3,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: state.facilities.entries.map((e) {
                    return ['취사', '세탁', '인터넷/TV', '주차', '가구', '냉/난방', '침구', '청소/소모품', '욕실 용품', '보안/안전', '기타'].indexWhere((element) => element == e.key!) != -1
                        ? IconItemWidget(selectedFacilityList: state.selectedFacilities, bloc: bloc, facilityThemeList: e.value, name: e.key ?? '', onSelected: (select, value) => bloc.add(SelectFacility(select, facility: value, isInitial: false)))
                        : Container();
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              LargeButton(text: '저장',onTap: (){
                bloc.add(Edit(data: {'updateType':'FACILITY'}));
              },),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

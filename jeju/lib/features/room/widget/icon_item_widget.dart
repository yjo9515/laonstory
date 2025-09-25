import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../bloc/room_management_bloc.dart';

class IconItemWidget extends StatelessWidget {
  IconItemWidget({Key? key, required this.name, this.facilityThemeList, this.onSelected, this.selectedFacilityList, this.selectedThemeList,this.bloc}) : super(key: key);

  final String name;
  final List<Facility>? facilityThemeList;
  final RoomManagementBloc? bloc;
  final Function(bool, Facility)? onSelected;
  final List<Facility>? selectedFacilityList;
  final List<Facility>? selectedThemeList;

  // bool trigger;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            name,
            style: context.textTheme.krSubtitle1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: facilityThemeList?.length ?? 0,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
              mainAxisSpacing: 8, //수평 Padding
              crossAxisSpacing: 16, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) {
              final facility = facilityThemeList?[index] ?? Facility();
              if(bloc != null){
                for(var r in selectedThemeList ?? []){
                  if(facility.name == r.name && bloc!.state.isInitial == true){
                    facility.select = true;
                  }
                }
              }
              if(bloc != null){
                for(var r in selectedFacilityList ?? []){
                  if(facility.name == r.name && bloc!.state.isInitial == true){
                    facility.select = true;
                  }
                }
              }
              return SizedBox(
                height: 86,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => onSelected?.call(!facility.select, facility),
                        child: Container(
                          decoration: BoxDecoration(
                            border:Border.all(color:const Color.fromARGB(
                                255, 210, 215, 221),width: 0.5)
                            ,borderRadius: BorderRadius.circular(16),
                            color: facility.select ? mainJeJuBlue : context.colorScheme.foregroundIcon,
                            boxShadow: [
                              if (facility.select)
                                BoxShadow(
                                  color: const Color(0xff01021A).withOpacity(0.21),
                                  blurRadius: 11,
                                  offset: const Offset(2, 3),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${facility.name}', style: context.textTheme.krBody1.copyWith(color: facility.select ? mainJeJuBlue : null)),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}



import 'package:flutter/material.dart';

import '../../../core/core.dart';

class PickTileWidget extends StatelessWidget {
  PickTileWidget({super.key, this.name, this.items,this.onSelected, this.facilityThemeList});

  // final String title;
  // final String description;
  final String? name;
  final List<String>? items;
  final Function(bool, Facility)? onSelected;
  final List<Facility>? facilityThemeList;



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: facilityThemeList?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.8,
        ),
        itemBuilder: (context, index) {
          final facility = facilityThemeList?[index] ?? Facility();
          return InkWell(
            onTap: () => onSelected?.call(!facility.select, facility),
            child:Container(
              width: 109,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: black5, width: 0.5),
                  color: facility.select ? mainJeJuBlue : context.colorScheme.foregroundIcon,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('${facility.name}', style: context.textTheme.krBody3.copyWith(color: facility.select ? white : black))),
            ),
          );
        });
  }
}

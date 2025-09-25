import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';

class RangeSliderWidget extends StatelessWidget {
  const RangeSliderWidget({Key? key, required this.currentRangeValues, this.onChanged}) : super(key: key);

  final RangeValues currentRangeValues;
  final Function(RangeValues)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: currentRangeValues,
      max: 1000000,
      divisions: 20,
      labels: RangeLabels(
        '${numberFormatter(currentRangeValues.start.round())} 원',
        currentRangeValues.end == 1000000 ? '제한없음' : '${numberFormatter(currentRangeValues.end.round())} 원',
      ),
      onChanged: (RangeValues values) => onChanged?.call(values),
      activeColor: context.colorScheme.sliderColor,
      overlayColor: MaterialStateProperty.resolveWith((states) {
        return context.colorScheme.sliderColor;
      }),
    );
  }
}

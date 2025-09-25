import 'package:flutter/material.dart';

import '../core.dart';

class DropdownMenuWidget<T> extends StatelessWidget {
  const DropdownMenuWidget(
      {Key? key, required this.dropdownList, required this.onChanged,this.TextAlignment =Alignment.centerRight ,this.value, required this.hint, this.filled = true, this.centerTitle = false, this.alignment = Alignment.centerLeft})
      : super(key: key);

  final List<T> dropdownList;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String hint;
  final bool filled;
  final bool centerTitle;
  final Alignment alignment;
  final Alignment TextAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(border: Border.all(color: black6, width: 1), borderRadius: BorderRadius.circular(16)),
      child: IntrinsicWidth(

        child: DropdownButtonFormField(
          isExpanded: true,
          alignment: alignment,
          icon: Container(
              // margin: const EdgeInsets.only(left: 8),
              child: Icon(Icons.keyboard_arrow_down_outlined, color: filled ? black5 : null)),
          decoration: InputDecoration(
            counterText: "",
            filled: filled,
            hintText: hint,
            contentPadding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
          ),
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          value: value,
          items: dropdownList.map((dynamic item) {
            return DropdownMenuItem<T>(
              alignment: TextAlignment,
              value: item,
              child: Text(
                item,
                style: context.textTheme.krBody3,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}

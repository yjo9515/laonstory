import 'package:flutter/material.dart';

import '../style.dart';

class DropdownMenuWidget<T> extends StatelessWidget {
  const DropdownMenuWidget({Key? key, required this.dropdownList, required this.onChanged, this.value}) : super(key: key);

  final List<T> dropdownList;
  final ValueChanged<T?> onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          focusColor: Colors.white.withOpacity(0),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: false,
        ),
        elevation: 0,
        isExpanded: true,
        borderRadius: BorderRadius.circular(10),
        value: value,
        style: textTheme(context).krBody1.copyWith(color: Theme.of(context).primaryColor),
        items: dropdownList.map((dynamic item) {
          return DropdownMenuItem<T>(
            value: item,
            child: SizedBox(
              child: Text(
                item,
                style: textTheme(context).krBody1,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}

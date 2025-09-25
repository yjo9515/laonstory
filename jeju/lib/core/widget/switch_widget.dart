import 'package:flutter/material.dart';

import '../core.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({Key? key, required this.switches,this.overflow = false, this.value = '', this.onChange}) : super(key: key);

  final List<String> switches;
  final String value;
  final Function(String)? onChange;
  final bool overflow;

  @override
  Widget build(BuildContext context) {
    return overflow ? Wrap(
        spacing: 8,
        runSpacing: 10,
        children: switches
            .asMap()
            .entries
            .map((data) => GestureDetector(

          onTap: () => onChange?.call(data.value),
          child: Container(
            width: 109,
            decoration: BoxDecoration(color: data.value == value ? mainJeJuBlue : Colors.white, border: Border.all(color: black5, width: 1), borderRadius: BorderRadius.circular(16)),
            // constraints: const BoxConstraints(minWidth: 109,maxWidth: 109),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child:  Center(
              child: Text(
                data.value,
                style: context.textTheme.krBody3.copyWith(color: data.value == value ? Colors.white : Colors.black, fontWeight: data.value == value ? FontWeight.bold : FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ))
            .toList()):Row(
        children: switches
            .asMap()
            .entries
            .map((data) => GestureDetector(

                  onTap: () => onChange?.call(data.value),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(color: data.value == value ? mainJeJuBlue : Colors.white, border: Border.all(color: black5, width: 1), borderRadius: BorderRadius.circular(16)),
                    constraints: const BoxConstraints(minWidth: 88),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    child: Center(
                      child: Text(
                        data.value,
                        style: context.textTheme.krBody3.copyWith(color: data.value == value ? Colors.white : Colors.black, fontWeight: data.value == value ? FontWeight.bold : FontWeight.w500),
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}

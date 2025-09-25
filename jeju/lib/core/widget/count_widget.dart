import 'package:flutter/material.dart';

import '../core.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({Key? key, required this.count, required this.onChanged, this.min = 0, this.max = 100, this.controller}) : super(key: key);

  final int count;
  final Function(int) onChanged;
  final int min;
  final int max;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (count > min) {
              onChanged(count - 1);
            }
          },
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: black5, shape: BoxShape.circle),
            child: const Center(
              child: Icon(Icons.remove, color: white, size: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 88,
          child: InputWidget(
            controller: controller ?? TextEditingController(text: count.toString()),
            nonePadding: true,
            textAlign: TextAlign.center,
            format: TextInputType.number,
            helper: false,
            onChange: (value) {
              onChanged(int.parse(value.isEmpty ? '0' : value));
            },
            onFieldSubmitted: (value) {
              onChanged(int.parse(value.isEmpty ? '0' : value));
            },
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            if (count < max) {
              onChanged(count + 1);
            }
          },
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: mainJeJuBlue, shape: BoxShape.circle),
            child: const Center(
              child: Icon(Icons.add, color: white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

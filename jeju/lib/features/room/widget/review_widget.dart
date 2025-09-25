import 'package:flutter/material.dart';

import '../../features.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleText(
          title: "리뷰",
          go: true,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              ReviewTile(width: 320),
              ReviewTile(width: 320),
              ReviewTile(width: 320),
            ],
          ),
        )
      ],
    );
  }
}

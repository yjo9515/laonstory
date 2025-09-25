import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/features.dart';

class MyReviewPage extends StatelessWidget {
  const MyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textTitle: '내가 쓴 리뷰',
        backButton: true,
      ),
      body: ListView(
        children: [ReviewTile()],
      ),
    );
  }
}

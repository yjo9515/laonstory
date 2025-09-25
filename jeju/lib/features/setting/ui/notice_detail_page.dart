import 'package:flutter/material.dart';

import '../../../core/core.dart';

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textTitle: '제주살이 업데이트 안내',
        backButton: true,
      ),
    );
  }
}

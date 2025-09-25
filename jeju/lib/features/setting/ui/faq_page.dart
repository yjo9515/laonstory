import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textTitle: 'FAQ 자주 묻는 질문',
        backButton: true,
      ),
    );
  }
}

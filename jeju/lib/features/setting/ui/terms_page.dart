import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textTitle: '약관 및 정책',
        backButton: true,
      ),
    );
  }
}

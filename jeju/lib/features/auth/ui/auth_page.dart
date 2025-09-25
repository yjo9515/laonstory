import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';

import '../widget/auth_widget.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.path});

  final String? path;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(backButton: true, textTitle: '인증 진행'),
      body: AuthWidget(path: path,),
    );
  }
}


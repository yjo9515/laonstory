import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/custom_app_bar.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        backButton: true,
        textTitle: "권한 설정",
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/custom_app_bar.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        backButton: true,
        textTitle: "FAQ",
      ),
    );
  }
}

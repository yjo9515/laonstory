import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/custom_app_bar.dart';
import '../model/terms.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  String data = '';

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        data = privacy;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onBack: () {
            setState(() {
              data = "";
            });
            context.pop();
          },
          backButton: true,
          textTitle: "개인정보처리방침",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: data.isEmpty
              ? const Center(child: CupertinoActivityIndicator())
              : SingleChildScrollView(
                  child: Html(
                    data: data,
                  ),
                ),
        ));
  }
}

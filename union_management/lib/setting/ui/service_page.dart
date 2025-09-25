import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/custom_app_bar.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  String data = '';

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        data = '';
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
          textTitle: "서비스 이용약관",
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

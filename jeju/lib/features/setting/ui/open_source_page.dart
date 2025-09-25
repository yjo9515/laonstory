import 'package:flutter/material.dart';
import 'package:jeju_host_app/main.dart';

class OpenSourcePage extends StatelessWidget {
  const OpenSourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationVersion: AppConfig.to.shared.getString('app_version'),
      applicationName: '제주살이',
      applicationLegalese: 'ⓒ LAONSTORY ALL RIGHT RESERVED.',
    );
  }
}

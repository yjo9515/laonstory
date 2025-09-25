import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';

class TermPage extends StatelessWidget {
  const TermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        backButton: true,
        textTitle: "이용약관",
      ),
      body: CupertinoListSection.insetGrouped(
        backgroundColor: lightBackground,
        header: Padding(padding: const EdgeInsets.all(8), child: Text("이용약관", style: textTheme(context).krTitle2)),
        children: termList(context),
      ),
    );
  }
}

List<Widget> termList(BuildContext context) => [
      CupertinoListTile.notched(
        onTap: () {
          context.push('/setting/term/privacy');
        },
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.activeGreen,
          ),
          child: const Icon(Icons.person, color: white),
        ),
        title: Text('개인정보처리방침', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
      CupertinoListTile.notched(
        onTap: () {
          context.push('/setting/term/service');
        },
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.activeBlue,
          ),
          child: const Icon(Icons.room_service, color: white),
        ),
        title: Text('서비스 이용약관', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
    ];

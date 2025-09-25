import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';
import '../../global/bloc/global_bloc.dart';
import '../bloc/setting_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        backButton: true,
        textTitle: "설정",
      ),
      body: BlocProvider(
        create: (context) => SettingBloc(),
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: PrimaryScrollController.of(context),
              child: Column(
                children: [
                  // CupertinoListSection.insetGrouped(
                  //   backgroundColor: lightBackground,
                  //   header: Padding(padding: const EdgeInsets.all(8), child: Text("앱 설정", style: textTheme(context).krSubtitle1)),
                  //   children: settingList(context, state),
                  // ),
                  // CupertinoListSection.insetGrouped(
                  //   backgroundColor: lightBackground,
                  //   header: Padding(padding: const EdgeInsets.all(8), child: Text("문의", style: textTheme(context).krSubtitle1)),
                  //   children: helpList(context),
                  // ),
                  CupertinoListSection.insetGrouped(
                    backgroundColor: lightBackground,
                    header: Padding(padding: const EdgeInsets.all(8), child: Text("이용약관", style: textTheme(context).krSubtitle1)),
                    children: termList(context),
                  ),
                  CupertinoListSection.insetGrouped(
                    backgroundColor: lightBackground,
                    header: Padding(padding: const EdgeInsets.all(8), child: Text("개인 설정", style: textTheme(context).krSubtitle1)),
                    children: personalList(context, globalBloc),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: Text(
                      "버전 정보 ${globalBloc.state.appConfig?.version}",
                      style: textTheme(context).krBody2.copyWith(color: gray3, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 32, left: 40, right: 40),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CopyrightⓒLaonstory. All rights reserved.',
                          style: textTheme(context).krSubtext1.copyWith(color: gray3),
                        ),
                        Text(
                          '라온스토리 Laonstory',
                          style: textTheme(context).krSubtext1.copyWith(color: gray3),
                        ),
                        Text(
                          '사업자등록번호  138-81-79397',
                          style: textTheme(context).krSubtext1.copyWith(color: gray3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> settingList(BuildContext context, SettingState state) => [
      CupertinoListTile.notched(
        onTap: () => context.push('/setting/permission'),
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.systemBlue,
          ),
          child: const Icon(Icons.person, color: white),
        ),
        title: Text('권한 설정', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
      CupertinoListTile.notched(
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.activeGreen,
          ),
          child: const Icon(Icons.notifications, color: white),
        ),
        title: Text('알림 설정', style: textTheme(context).krBody1),
        trailing: CupertinoSwitch(
          value: state.permissionNotification == PermissionStatus.granted,
          onChanged: (bool value) {
            BlocProvider.of<SettingBloc>(context).add(ChangePermission(Permission.notification, value));
          },
        ),
      ),
    ];

List<Widget> helpList(BuildContext context) => [
      CupertinoListTile.notched(
        onTap: () => context.push('/setting/faq'),
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.systemPink,
          ),
          child: const Icon(Icons.question_mark, color: white),
        ),
        title: Text('FAQ', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
      CupertinoListTile.notched(
        onTap: () => context.push('/setting/question'),
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.activeGreen,
          ),
          child: const Icon(Icons.question_answer, color: white),
        ),
        title: Text('1:1 문의', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
    ];

List<Widget> termList(BuildContext context) => [
      CupertinoListTile.notched(
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.activeBlue,
          ),
          child: const Icon(Icons.description, color: white),
        ),
        onTap: () {
          context.push('/setting/term');
        },
        title: Text('약관 및 정책', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
      ),
    ];

List<Widget> personalList(BuildContext context, GlobalBloc globalBloc) => [
      CupertinoListTile.notched(
        leading: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.destructiveRed,
          ),
          child: const Icon(Icons.key_off, color: white),
        ),
        onTap: () {
          globalBloc.add(const Logout());
          context.go('/');
        },
        title: Text('로그아웃', style: textTheme(context).krBody1),
        trailing: const CupertinoListTileChevron(),
        additionalInfo: Text('로그인페이지로 이동합니다.', style: textTheme(context).krBody1.copyWith(color: gray3)),
      ),
      // CupertinoListTile.notched(
      //   leading: Container(
      //     width: double.infinity,
      //     height: double.infinity,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(5),
      //       color: CupertinoColors.destructiveRed,
      //     ),
      //     child: const Icon(Icons.group_off, color: white),
      //   ),
      //   onTap: () {},
      //   title: Text('회원탈퇴', style: textTheme(context).krBody1),
      //   trailing: const CupertinoListTileChevron(),
      // ),
    ];

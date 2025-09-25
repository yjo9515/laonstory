import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/global/bloc/global_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.bloc}) : super(key: key);

  final GlobalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backButton: true, textTitle: '설정'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleText(title: '개인'),
            ContentText(content: '내 정보 관리', go: true,
              onTap:(){
                context.push('/setting/info',extra:bloc);
              }
            ,),
            ContentText(content: '로그아웃', go: true,
            onTap: (){
              bloc.add(Logout());
              context.pop();
              context.pushReplacement('/login/false');
              },
            ),
            ContentText(content: '회원탈퇴', go: true,
                onTap:(){context.push('/setting/out/1');}
            ),
            const Divider(height: 32),
            const TitleText(title: '앱 설정'),
            ContentText(content: '권한 설정', go: true,
                onTap:(){
              // context.push('/setting/permission');
                  openAppSettings();
            }
            ),
            ContentText(content: '알림 설정', go: true,
                onTap:(){context.push('/setting/alert');}
            ),
            const Divider(height: 32),
            const TitleText(title: '공지 및 문의'),
            ContentText(content: '공지사항', go: true,
                onTap:(){context.push('/setting/notice');}
            ),
            const ContentText(content: 'FAQ', go: true),
            ContentText(
                content: '1:1 문의', go: true,
                onTap: (){context.push('/setting/question');},
            ),
            const Divider(height: 32),
            const TitleText(title: '서비스 안내'),
            ContentText(content: '약관 및 정책', go: true,
              onTap:(){context.push('/setting/alert');}
            ),
            const ContentText(content: '오픈소스 라이선스', go: true
            ),
            const Divider(height: 32),
            const TitleText(title: '앱정보'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Text('앱버전', style: context.textTheme.krSubtitle1),
                  const Spacer(),
                  Text('jejusale_ver.1.0.0', style: context.textTheme.krBody3),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainJeJuBlue),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Text('업데이트', style: context.textTheme.krBody1.copyWith(color: mainJeJuBlue))),
            ),
            const SizedBox(height: 32),
            const CopyRightWidget(),
          ],
        ),
      ),
    );
  }
}

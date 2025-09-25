import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/mypage/bloc/mypage_bloc.dart';
import 'package:jeju_host_app/main.dart';

import '../../../core/core.dart';
import '../../global/bloc/global_bloc.dart';
import '../widget/profile_data_widget.dart';
import '../widget/profile_widget.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalBloc, GlobalState>(
        listener: (BuildContext context, GlobalState state) {
          if (state.status == CommonStatus.failure) {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text(
                      '알림',
                    ),
                    content: Text(
                      state.errorMessage ?? '오류가 발생했습니다. 다시 시도해주세요.',
                    ),
                    actions: <Widget>[
                      adaptiveAction(
                        context: context,
                        onPressed: () => Navigator.pop(context, '확인'),
                        child: const Text('확인'),
                      ),
                    ],
                  );
                });
            context.read<GlobalBloc>().add(Initial());
            // context.read<GlobalBloc>().emit(state.copyWith(status: CommonStatus.initial));
          }
        },
      builder: (context, globalState) {
        return Scaffold(
          appBar: CustomAppBar(
            color: globalState.secureModel.hostStatus == UserType.host ? mainJeJuBlue : null,
            actions: [
              Row(
                children: [
                  Center(
                      child: Text(globalState.secureModel.hostStatus == UserType.host ? '게스트 전환' : '호스트 전환',
                          style: context.textTheme.krBody1.copyWith(color: globalState.secureModel.hostStatus == UserType.host ? white : Theme.of(context).appBarTheme.iconTheme?.color))),
                  Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                          thumbColor: globalState.secureModel.hostStatus == UserType.host ? mainJeJuBlue : white,
                          activeColor: Colors.white,
                          value: globalState.secureModel.hostStatus == UserType.host,
                          onChanged: (value) async {
                            if (globalState.secureModel.loginStatus != LoginStatus.login) {
                              context.push('/login/true');
                              return;
                            }
                            logger.d(value);
                            context.read<GlobalBloc>().add(SwitchHost(value ? UserType.host : UserType.guest));
                            // if (AppConfig.to.shared.getBool('host_guide') ?? false) {
                            //   context.read<GlobalBloc>().add(SwitchHost(value ? UserType.host : UserType.guest));
                            //   await context.read<GlobalBloc>().stream.first.then((_) => context.go('/'));
                            // } else {
                            //   context.push('/guide/host');
                            // }
                          })),
                ],
              ),
              IconButton(
                  onPressed: () => context.push('/setting', extra: context.read<GlobalBloc>()),
                  icon: Icon(Icons.settings, color: globalState.secureModel.hostStatus == UserType.host ? white : Theme.of(context).appBarTheme.iconTheme?.color)),
              const SizedBox(width: 8),
            ],
            widgetTitle: Container(),
          ),
          body: BlocProvider(
            create: (context) => MypageBloc(globalBloc: context.read<GlobalBloc>())..add(const Initial()),
            child: BlocConsumer<MypageBloc, MypageState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                if (state.status == CommonStatus.failure) {
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text(
                            '알림',
                          ),
                          content: Text(
                            state.errorMessage ?? '오류가 발생했습니다. 다시 시도해주세요.',
                          ),
                          actions: <Widget>[
                            adaptiveAction(
                              context: context,
                              onPressed: () => Navigator.pop(context, '확인'),
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      });
                }
                if (state.status == CommonStatus.success){
                  logger.d(state.images?.single.path);
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text(
                            '알림',
                          ),
                          content: Text(
                            '프로필 사진 변경이 완료되었습니다.',
                          ),
                          actions: <Widget>[
                            adaptiveAction(
                              context: context,
                              onPressed: () => Navigator.pop(context, '확인'),
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      });
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: globalState.secureModel.hostStatus == UserType.host ? mainJeJuBlue : null,
                        child: ProfileWidget(
                          bloc : context.read<MypageBloc>(),
                          profile: globalState.profile,
                          loginStatus: globalState.secureModel.loginStatus,
                          hostStatus: globalState.secureModel.hostStatus,
                        ),
                      ),
                      Container(height: 16, color: globalState.secureModel.hostStatus == UserType.host ? mainJeJuBlue : null),
                      ProfileDataWidget(profile: globalState.profile),
                      // state.rooms.isNotEmpty ?
                      // Padding(
                      //     padding: EdgeInsets.fromLTRB(24,16,24,8),
                      //   child: Container(
                      //     padding: EdgeInsets.fromLTRB(24,0,24,0),
                      //     height: 42,
                      //     decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 247, 250, 252),
                      //       borderRadius: BorderRadius.circular(16.0),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('숙소 신청완료',
                      //             style:state.rooms.first.status == 'WAITING'
                      //                 || state.rooms.first.status== 'ACTIVE'
                      //                 || state.rooms.first.status== 'BLOCKED'
                      //                 || state.rooms.first.status== 'REJECT'
                      //                 || state.rooms.first.status== 'STOP'
                      //                 || state.rooms.first.status== 'DELETED' ? context.textTheme.krSubtext1.copyWith(fontSize: 16) : context.textTheme.krSubtext2.copyWith(color: mainJeJuBlue,fontSize: 16)),
                      //         Icon(Icons.more_horiz),
                      //         Text('숙소 심사중', style:state.rooms.first.status == 'WAITING' ? context.textTheme.krSubtext2.copyWith(color: mainJeJuBlue,fontSize: 16) : context.textTheme.krSubtext1.copyWith(fontSize: 16)),
                      //         Icon(Icons.more_horiz),
                      //         Text('숙소 승인', style:state.rooms.first.status == 'ACTIVE' ? context.textTheme.krSubtext2.copyWith(color: mainJeJuBlue,fontSize: 16) : context.textTheme.krSubtext1.copyWith(fontSize: 16)),
                      //       ],
                      //     ),
                      //   ),
                      //
                      // ) : Container(),
                      // state.rooms.isNotEmpty ?
                      // Padding(
                      //   padding:EdgeInsets.fromLTRB(24,16,24,8),
                      //   child: Text(
                      //     '${state.rooms.first.name}', style: context.textTheme.krBody1.copyWith(color: gray0,fontSize: 16),
                      //   ),
                      // ) : Container(),
                      if (globalState.secureModel.hostStatus == UserType.host)
                        InkWell(
                            onTap: () {
                              context.push('/info/host');
                            },
                            child: const TitleText(title: '호스트정보', go: true)),
                      if (globalState.secureModel.hostStatus == UserType.host)
                        InkWell(
                            onTap: () {
                              context.push('/profit');
                            },
                            child: const TitleText(title: '수익관리', go: true)),
                      if (globalState.secureModel.hostStatus == UserType.guest)
                        InkWell(
                            onTap: () {
                              context.push('/room/recent');
                            },
                            child: const TitleText(title: '최근 본 숙소', go: true)),
                      if (globalState.secureModel.hostStatus == UserType.guest)
                        InkWell(
                            onTap: () {
                              context.push('/room/wish');
                            },
                            child: const TitleText(title: '내 관심 숙소', go: true)),
                      if (globalState.secureModel.hostStatus == UserType.guest)
                        InkWell(
                            onTap: () {
                              context.push('/myReview');
                            },
                            child: const TitleText(title: '내가 남긴 리뷰', go: true)),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

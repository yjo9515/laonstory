import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/features/mypage/bloc/mypage_bloc.dart';

import '../../../core/core.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, this.profile,this.room, this.loginStatus = LoginStatus.logout, required this.hostStatus, this.otherView = false, this.bloc}) : super(key: key);

  final Profile? profile;
  final LoginStatus loginStatus;
  final UserType hostStatus;
  final bool otherView;
  final MypageBloc? bloc;
  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: switch (loginStatus) {
          LoginStatus.logout => Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.foregroundText,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: const Offset(-1, 1),
                        ),
                      ],
                    ),
                    child: const SvgImage('assets/images/default_profile.svg')),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('로그인', style: context.textTheme.krBody5),
                    const SizedBox(height: 8),
                    Text('로그인 후 이용해 주세요.', style: context.textTheme.krBody1),
                  ],
                ),
              ],
            ),
          LoginStatus.login => Row(
              children: [
                otherView?
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageBuilder: (context, provider) => Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        border: Border.all(color: gray5, width: 0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircleAvatar(backgroundImage: provider)),
                  imageUrl: '$imageUrl${profile?.profile?.path ?? ''}',
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.foregroundText,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), spreadRadius: 0, blurRadius: 5, offset: const Offset(-1, 1))]),
                      child: const SvgImage('assets/images/default_profile.svg')),
                  placeholder: (context, url) =>
                      Container(width: 78, height: 78, decoration: BoxDecoration(border: Border.all(color: gray5, width: 0.5), borderRadius: BorderRadius.circular(100)), child: const CircleAvatar()),
                ):
                InkWell(
                  onTap: (){
                    bloc?.add(PickImage(source: ImageSource.gallery,userType: hostStatus));
                  },
                  child:
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageBuilder: (context, provider) => Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(

                          border: Border.all(color: gray5, width: 0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CircleAvatar(backgroundImage: provider,
                            child:
                            Stack(
                              children: [
                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.transparent,Colors.black, Colors.black], // 상단에서는 파란색으로, 하단에서는 투명으로
                                        stops: [0.0, 0.65, 0.65, 1.0], // 각 색상의 위치 설정
                                      ),
                                      color: Colors.black.withOpacity(0.6),
                                      border: Border.all(color: gray5, width: 0.5),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                const Positioned(
                                  left: 1,
                                  right: 1,
                                  bottom: 5,
                                    child: Icon(
                                        Icons.edit_outlined,
                                    size: 20,
                                    color: Colors.white,))

                              ],
                            )

                        )),
                    imageUrl: '$imageUrl${profile?.profile?.path ?? ''}',
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.foregroundText,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), spreadRadius: 0, blurRadius: 5, offset: const Offset(-1, 1))]),
                      child: SvgImage('assets/images/default_profile.svg'),),
                    placeholder: (context, url) =>
                        Container(width: 78, height: 78, decoration: BoxDecoration(border: Border.all(color: gray5, width: 0.5), borderRadius: BorderRadius.circular(100)), child: const CircleAvatar()),
                  ),


                ),
                const SizedBox(width: 24),
                Expanded(
                  child: otherView
                      ? Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Flexible(child: AutoSizeText('${profile?.name}', style: context.textTheme.krBody5, maxLines: 1)),
                                    AutoSizeText('${profile?.name}', style: context.textTheme.krBody5, maxLines: 1),
                                    const SizedBox(width: 8),

                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text('호스트 가입일 : ${monthParserDate(profile?.createdAt)}', style: context.textTheme.krBody1),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                context.push('/message/${profile?.id}',extra: {'profile' : profile, 'room' : room, 'type' : hostStatus});
                              },
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: mainJeJuBlue,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.chat_outlined, size: 20, color: white),
                                      Text('문의', style: context.textTheme.krSubtext1.copyWith(color: white)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    profile?.name ?? '이름이 설정되지 않았습니다.',
                                    style: context.textTheme.krBody5.copyWith(color: hostStatus == UserType.host ? white : null),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Text(profile?.email ?? '', style: context.textTheme.krBody1.copyWith(color: hostStatus == UserType.host ? white : black3)),
                          ],
                        ),
                ),
              ],
            ),
        });
  }
}

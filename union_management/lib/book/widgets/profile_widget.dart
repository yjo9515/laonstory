import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:union_management/common/util/static_logic.dart';
import 'package:union_management/global/model/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/style.dart';
import '../../global/bloc/global_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.onClick}) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GlobalBloc, GlobalState, Profile?>(
      selector: (state) => state.profileModel?.data,
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: ProfileData(
                                  name: '이름', content: state?.name)),
                          const SizedBox(width: 16),
                          Expanded(
                              flex: 1,
                              child: ProfileData(
                                  name: '가입일',
                                  content: dateParser(state?.createdAt, true))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      DocumentWidget(
                        onClick: onClick,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 40),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: ProfileData(
                                  name: '구좌',
                                  content: numberFormatter(state?.account))),
                          const SizedBox(width: 16),
                          Expanded(
                              flex: 1,
                              child: ProfileData(
                                  name: '출자금(원)',
                                  content: numberFormatter(state?.price))),
                          const SizedBox(width: 16),
                          Expanded(
                              flex: 1,
                              child: ProfileData(
                                  name: '포인트',
                                  content: numberFormatter(state?.point))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ProfileData(
                        name: '자택주소',
                        content: state?.address,
                        start: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 40),
                        child: Divider(),
                      ),
                      ProfileData(
                        name: '조합이름',
                        content: state?.union?.name,
                        start: true,
                      ),
                      const SizedBox(height: 24),
                      ProfileData(
                        name: '조합주소',
                        content: state?.union?.address,
                        start: true,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _launchUrl('http://ptsmptsm.or.kr/');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  child: Text(
                                    "조합 홈페이지",
                                    style: textTheme(context)
                                        .krSubtitle1
                                        .copyWith(
                                        color: const Color(0xff4C8DEF)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (await canLaunchUrl(Uri.parse(
                                    'bandapp://www.band.us/n/a4aa9fk1y9d4Z'))) {
                                  _launchUrl(
                                      'bandapp://www.band.us/n/a4aa9fk1y9d4Z');
                                } else {
                                  _launchUrl(
                                      'https://www.band.us/n/a4aa9fk1y9d4Z');
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  child: Text(
                                    "조합 네이버 밴드",
                                    style: textTheme(context)
                                        .krSubtitle1
                                        .copyWith(
                                        color: const Color(0xff4C8DEF)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () {
                          showGeneralDialog(context: context, pageBuilder: (
                              BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return Scaffold(
                              appBar: AppBar(
                                backgroundColor: black,
                                elevation: 0,
                                leading: IconButton(
                                  icon: const Icon(Icons.close, color: white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              body: Center(
                                child: PhotoView(
                                  imageProvider: const AssetImage(
                                      "assets/images/map.png"),
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.asset(
                            'assets/images/map.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData(
      {Key? key, required this.name, this.content, this.start = false})
      : super(key: key);

  final String name;
  final String? content;
  final bool start;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff74ABFF),
                Color(0xff77A8F1),
              ]),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          start ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: textTheme(context).krBody1.copyWith(color: white),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: AutoSizeText(
                content ?? "",
                style: textTheme(context).krSubtitle2.copyWith(color: white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({Key? key, required this.onClick}) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.document_scanner_rounded,
                  color: Color(0xff4C8DEF)),
              const SizedBox(width: 8),
              Text(
                "조합원증",
                style: textTheme(context)
                    .krSubtitle1
                    .copyWith(color: const Color(0xff4C8DEF)),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}

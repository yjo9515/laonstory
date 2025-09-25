import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/style.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/custom_app_bar.dart';
import '../../global/bloc/global_bloc.dart';
import '../../global/model/profile_model.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const Initial()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BlocSelector<GlobalBloc, GlobalState, Profile?>(
            selector: (state) => state.profileModel?.data,
            builder: (context, globalState) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                        primary2,
                        Color(0xff1554B2),
                      ]),
                    ),
                    child: CustomAppBar(
                      divider: false,
                      color: primary.withOpacity(0),
                      leadingAction: IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            context.push('/alert');
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/ic_bell.svg',
                            color: white,
                          )),
                      actions: [
                        IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              context.push('/setting');
                            },
                            icon: const Icon(
                              Icons.settings_outlined,
                              color: white,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 56 + kToolbarHeight),
                    child: SingleChildScrollView(
                      controller: PrimaryScrollController.of(context),
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 135,
                            decoration: BoxDecoration(
                              color: white2,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(offset: const Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: Colors.black.withOpacity(0.25)),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => context.push('/book'),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('${globalState?.name}', style: textTheme(context).krTitle2),
                                            const SizedBox(width: 8),
                                            Text('${positionToString(globalState?.position)}님', style: textTheme(context).krBody1.copyWith(color: gray4)),
                                            const SizedBox(width: 8),
                                            Text('${globalState?.serialNumber}', style: textTheme(context).krBody1.copyWith(color: gray4)),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            // Text('${changeGenderToString(globalState?.gender)}', style: textTheme(context).krBody1),
                                            // Text(' | ', style: textTheme(context).krBody1.copyWith(color: gray6)),
                                            // Text('${changeAgeToString(globalState?.registrationNumber)}', style: textTheme(context).krBody1),
                                            // Text(' | ', style: textTheme(context).krBody1.copyWith(color: gray6)),
                                            Text('${globalState?.phoneNumber}', style: textTheme(context).krBody1),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('보유 포인트', style: textTheme(context).krSubtitle1R),
                                            Text('${numberFormatter(globalState?.point)} P', style: textTheme(context).krTitle1),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if(await canLaunchUrl(Uri.parse('bandapp://www.band.us/n/a4aa9fk1y9d4Z'))) {
                                          _launchUrl('bandapp://www.band.us/n/a4aa9fk1y9d4Z');
                                          } else {
                                          _launchUrl('https://www.band.us/n/a4aa9fk1y9d4Z');

                                          }
                                          // showGeneralDialog(
                                          //   context: context,
                                          //   pageBuilder: (
                                          //     BuildContext context,
                                          //     Animation<double> animation,
                                          //     Animation<double> secondaryAnimation,
                                          //   ) {
                                          //     return Scaffold(
                                          //       backgroundColor: Colors.black.withOpacity(0.85),
                                          //       appBar: CustomAppBar(
                                          //         textTitle: '조합원 인증 QR코드',
                                          //         actions: [
                                          //           IconButton(
                                          //               onPressed: () {
                                          //                 Navigator.of(context).pop();
                                          //               },
                                          //               icon: const Icon(Icons.close)),
                                          //           const SizedBox(width: 4)
                                          //         ],
                                          //       ),
                                          //       body: InkWell(
                                          //         splashFactory: NoSplash.splashFactory,
                                          //         onTap: () {
                                          //           Navigator.of(context).pop();
                                          //         },
                                          //         child: Center(
                                          //           child: Hero(
                                          //             tag: 'QRCode',
                                          //             child: QrImageView(
                                          //               data: globalState?.serialNumber ?? "",
                                          //               backgroundColor: Colors.white,
                                          //               version: QrVersions.auto,
                                          //               size: MediaQuery.of(context).size.width * 0.7,
                                          //               gapless: false,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [BoxShadow(color: Color.fromRGBO(72, 92, 122, 0.25), offset: Offset(0, 2), blurRadius: 10)],
                                          ),
                                          child:
                                              SvgPicture.asset('assets/icons/ic_band.svg'),
                                          // Hero(
                                          //   tag: 'QRCode',
                                          //   child: QrImageView(
                                          //     data: globalState?.serialNumber ?? "",
                                          //     backgroundColor: Colors.white.withOpacity(0),
                                          //     version: QrVersions.auto,
                                          //     size: 88,
                                          //     gapless: false,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text('조합 밴드', style: textTheme(context).krBody1),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            decoration: BoxDecoration(color: white2, borderRadius: BorderRadius.circular(50)),
                            child: Column(
                              children: [
                                const SizedBox(height: 48),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('공지사항', style: textTheme(context).krSubtitle1),
                                      InkWell(
                                        onTap: () => context.push('/notice'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(44)),
                                          child: Text(
                                            '더 보기 +',
                                            style: textTheme(context).krSubtext1.copyWith(color: white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  constraints: const BoxConstraints(minHeight: 200),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: state.notices
                                        .asMap()
                                        .entries
                                        .map((element) => Column(
                                              children: [
                                                const SizedBox(height: 8),
                                                InkWell(
                                                  onTap: () => context.push('/notice/${element.value.id}'),
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 32),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            element.value.title ?? "",
                                                            style: textTheme(context).krBody1.copyWith(color: gray8),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          dateParser(element.value.createdAt, false),
                                                          style: textTheme(context).krBody1.copyWith(color: gray4),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                // if (state.events.length - 1 != element.key)
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('진행중인 행사', style: textTheme(context).krSubtitle1),
                                      InkWell(
                                        onTap: () => context.push('/event'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(44)),
                                          child: Text(
                                            '더 보기 +',
                                            style: textTheme(context).krSubtext1.copyWith(color: white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  constraints: const BoxConstraints(minHeight: 200),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: state.events
                                        .asMap()
                                        .entries
                                        .map((element) => Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        InkWell(
                                          onTap: () => context.push('/event/${element.value.id}'),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 32),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    element.value.title ?? "",
                                                    style: textTheme(context).krBody1.copyWith(color: gray8),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  dateParser(element.value.createdAt, false),
                                                  style: textTheme(context).krBody1.copyWith(color: gray4),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // if (state.events.length - 1 != element.key)
                                          const Divider(
                                            thickness: 1,
                                          ),
                                      ],
                                    ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 48),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

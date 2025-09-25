import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';

class SocietyPage extends StatelessWidget {
  const SocietyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.pop();
        },
        backButton: true,
        textTitle: "평택시민의료소비자생활협동조합",
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () async {
                    const String lat = "36.99549135735833";
                    const String lng = "127.09958910558778";
                    const String androidMap = "geo:$lat,$lng";
                    const String appleMap = 'maps://https://maps.apple.com/?ll=$lat,$lng';
                    if (defaultTargetPlatform == TargetPlatform.android) {
                      await _launchUrl(androidMap);
                    } else {
                      await _launchUrl(appleMap);
                    }
                  },
                  icon: const Icon(Icons.map_outlined)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/brand_image.png', width: 250),
              const SizedBox(height: 24),
              Text('평택시민의료생협 조합원은 "더불어 사는 삶의 기쁨"을지향하며 건강하고 행복한 삶을 만들어갑니다.', style: textTheme(context).krBody1),
              const SizedBox(height: 16),
              Image.asset('assets/images/example_1.png'),
              const SizedBox(height: 16),
              const Text(
                '• 다양한 소모임 활동에 참여할 수 있습니다.\n'
                '• 건강한 지역사회 만들기 사업에 참여할 수 있습니다.\n'
                '• 각종 자원봉사 활동에 참여할 수 있습니다.\n'
                '• 영양구액제, 혈관순환개선제, 태반주사, 골밀도검사 등 비보험 의료비에 대한 다양한 할인 혜택을 받으실 수 있습니다.',
              ),
              const SizedBox(height: 32),
              Text('찾아오시는길', style: textTheme(context).krTitle1),
              const SizedBox(height: 16),
              InkWell(
                  onTap: (){
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
                  child: Image.asset('assets/images/map.png')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

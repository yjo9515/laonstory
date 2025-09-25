import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class HostStepWidget extends StatelessWidget {
  const HostStepWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: switch (text) {
        /// 호스트 등록 가이드 1번 스탭
        '1' => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: black,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(text, style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 16),
              Container(
                width: 136,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const SvgImage('assets/images/host_guide_1.svg'),
              ),
              const SizedBox(height: 16),
              Text('간편한 호스트 등록', style: context.textTheme.krBody5),
              const SizedBox(height: 24),
              Text('호스트 등록 약관에 동의하신 후\n간단하게 호스트 등록 완료!', style: context.textTheme.krBody3, textAlign: TextAlign.center),
            ],
          ),

        /// 호스트 등록 가이드 2번 스탭
        '2' => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: black,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(text, style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 16),
              Container(
                width: 136,
                height: 136,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const SvgImage('assets/images/host_guide_2.svg'),
              ),
              const SizedBox(height: 16),
              Text('숙소 등록하기', style: context.textTheme.krBody5),
              const SizedBox(height: 24),
              Text('올리고 싶은 방을 등록하기 위해\n숙소 정보를 입력합니다.', style: context.textTheme.krBody3, textAlign: TextAlign.center),
            ],
          ),

        /// 호스트 등록 가이드 3번 스탭
        '3' => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: black,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(text, style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 16),
              Container(
                width: 136,
                height: 136,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const SvgImage('assets/images/host_guide_3.svg'),
              ),
              const SizedBox(height: 16),
              Text('등록 완료 호스팅 시작!', style: context.textTheme.krBody5),
              const SizedBox(height: 24),
              Text('숙소 등록이 완료되면\n마음껏 호스팅을 시작해보세요!', style: context.textTheme.krBody3, textAlign: TextAlign.center),
            ],
          ),
        '4' => Column(
            children: [
              const SizedBox(height: 16),
              Text('혹시 호스팅할 공간이 없으신가요?', style: context.textTheme.krSubtitle1),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('1', style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(height: 24),
                      const SvgImage('assets/images/host_guide_4.svg'),
                      const SizedBox(height: 24),
                      AutoSizeText.rich(
                        TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: '모두의 분양',
                              style: context.textTheme.krBody3.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: mainJeJuBlue),
                            ),
                            TextSpan(
                              text: ' 에서 매물을 확인하고\n',
                              style: context.textTheme.krBody3,
                            ),
                            TextSpan(
                              text: '맘에드는 공간을 분양 받아보세요!',
                              style: context.textTheme.krBody3,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: context.textTheme.krBody3,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('2', style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(height: 24),
                      const SvgImage('assets/images/host_guide_5.svg'),
                      const SizedBox(height: 24),
                      AutoSizeText.rich(
                        TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: '공간거래 후 숙소 등록만 승인 후\n숙소 관리도 제주살이에서 알아서!',
                              style: context.textTheme.krBody3,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: context.textTheme.krBody3,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 2.6, bottom: 4),
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('3', style: context.textTheme.krSubtext2.copyWith(color: white, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(height: 24),
                      const SvgImage('assets/images/host_guide_6.svg'),
                      const SizedBox(height: 24),
                      AutoSizeText.rich(
                        TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: '타 브랜드 대비 월등히 낮은 수수료(15%)로\n수익도 쑥쑥 올라요!',
                              style: context.textTheme.krBody3,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: context.textTheme.krBody3,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        String() => Container(),
      },
    );
  }
}

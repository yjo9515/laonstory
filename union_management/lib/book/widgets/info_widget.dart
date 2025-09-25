import 'package:flutter/material.dart';

import '../../common/style.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoBox1(),
              Spacer(),
              InfoBox2(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox1 extends StatelessWidget {
  const InfoBox1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
              color: Color(0xFFB388FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberList(number: 1, data: ' 당뇨병 검사'),
              NumberList(number: 2, data: ' 고지혈 검사 (공복)'),
              NumberList(number: 3, data: ' 간기능 기본검사'),
              NumberList(number: 4, data: ' 류마티스관절염 검사'),
              NumberList(number: 5, data: ' 골밀도 검사'),
              NumberList(number: 6, data: ' 혈액 기본 검사\n (빈혈, 혈액형, 감염증)'),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF6725D5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Text(
            '기본 검사',
            style: textTheme(context).krTitle1.copyWith(color: white),
          ),
        ),
      ],
    );
  }
}

class InfoBox2 extends StatelessWidget {
  const InfoBox2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
              color: Color(0xFF88FFB2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberList(number: 7, data: ' 5대암 - 표지자검사 (5만원)'),
              NumberList(number: 8, data: ' 갑상선 기능검사 (3만원)'),
              NumberList(number: 9, data: ' 간기능 기능검사 (5만원)'),
              NumberList(number: 10, data: ' 췌장 기능검사 (3만원)'),
              NumberList(number: 11, data: ' 혈액종합 정말검사 (15만원'),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF51D525),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Text(
            '추가 검사 (비용부담)',
            style: textTheme(context).krTitle1.copyWith(color: white),
          ),
        ),
      ],
    );
  }
}

class NumberList extends StatelessWidget {
  const NumberList({Key? key, required this.number, required this.data}) : super(key: key);

  final int number;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            textAlign: TextAlign.right,
            ' $number.',
            style: textTheme(context).krTitle1,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            textAlign: TextAlign.left,
            data,
            style: textTheme(context).krTitle1,
          ),
        ),
      ],
    );
  }
}

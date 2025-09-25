import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/style.dart';
import '../../common/util/static_logic.dart';
import '../../global/bloc/global_bloc.dart';
import '../../global/model/profile_model.dart';
import 'curved_text.dart';

class BookTitleWidget extends StatelessWidget {
  const BookTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff253AA9),
      body: BlocSelector<GlobalBloc, GlobalState, Profile?>(
        selector: (state) => state.profileModel?.data,
        builder: (context, globalState) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text(
                  '조합원 건강수첩',
                  style: textTheme(context)
                      .krTitle1
                      .copyWith(color: white, fontSize: 56),
                ),
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 64),
                  decoration:
                      BoxDecoration(border: Border.all(color: black, width: 1)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFF8FC4F5),
                                border: Border.all(color: black, width: 0.5)),
                            child: AutoSizeText(
                              '성        명',
                              textAlign: TextAlign.center,
                              style: textTheme(context).krBody2,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: black, width: 0.5)),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${globalState?.name}',
                                style: textTheme(context).krBody1,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: black, width: 0.5)),
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${changeGenderToString(globalState?.gender)}',
                              style: textTheme(context).krBody2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFF8FC4F5),
                                border: Border.all(color: black, width: 0.5)),
                            child: AutoSizeText(
                              '조합번호',
                              textAlign: TextAlign.center,
                              style: textTheme(context).krBody2,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: black, width: 0.5)),
                              child: Text(
                                '${globalState?.serialNumber}',
                                style: textTheme(context).krBody1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFF8FC4F5),
                                border: Border.all(color: black, width: 0.5)),
                            child: AutoSizeText(
                              '시민의원',
                              textAlign: TextAlign.center,
                              style: textTheme(context).krBody2,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: black, width: 0.5)),
                              child: Text(
                                '2023192201',
                                style: textTheme(context).krBody1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 9),
                            decoration: BoxDecoration(
                                color: const Color(0xFF8FC4F5),
                                border: Border.all(color: black, width: 0.5)),
                            child: AutoSizeText(
                              '123한의원',
                              textAlign: TextAlign.center,
                              style: textTheme(context).krBody2,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: black, width: 0.5)),
                              child: Text(
                                '2023192201',
                                style: textTheme(context).krBody1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(color: Colors.transparent, height: 72),
                Image.asset(
                  'assets/images/brand_icon.png',
                  width: 100,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    color: Colors.transparent,
                    height: 160,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CurvedText(
                      radius: 180,
                      text: '평택시민의료소비자생활협동조합',
                      startAngle: -7.5,
                      textStyle: textTheme(context).krTitle1.copyWith(
                          color: white,
                          fontSize: 32,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                }),
                Text(
                  '조합사무실 : 655-4123',
                  style: textTheme(context).krTitle1.copyWith(color: white),
                ),
                Text(
                  '시민의원 : 655-36777',
                  style: textTheme(context).krTitle1.copyWith(color: white),
                ),
                Text(
                  '평택123한의원 : 654-1075',
                  style: textTheme(context).krTitle1.copyWith(color: white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

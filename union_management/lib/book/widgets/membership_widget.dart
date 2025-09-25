import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_management/common/util/static_logic.dart';

import '../../common/style.dart';
import '../../global/bloc/global_bloc.dart';
import '../../global/model/profile_model.dart';

class MembershipWidget extends StatelessWidget {
  const MembershipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GlobalBloc, GlobalState, Profile?>(
      selector: (state) => state.profileModel?.data,
      builder: (context, globalState) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32, top: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(width: 1.5, color: black)),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '함께가는 미래 "더 큰 행복"',
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  '조 합 원 증',
                  style: textTheme(context).krTitle1.copyWith(fontSize: 40),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      '성              명 : ',
                      style: textTheme(context).krBody1,
                    ),
                    Text('${globalState?.name}', style: textTheme(context).krBody1)
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '조합원  번호 : ',
                      style: textTheme(context).krBody1,
                    ),
                    Text('${globalState?.serialNumber}', style: textTheme(context).krBody1),
                  ],
                ),
                const SizedBox(height: 16),
                if((globalState?.registrationNumber ?? '').contains('-'))Row(
                  children: [
                    Text(
                      '생  년  월  일 : ',
                      style: textTheme(context).krBody1,
                    ),
                    Text('${globalState?.registrationNumber?.split('-').first}', style: textTheme(context).krBody1),
                  ],
                ),
                const Spacer(),
                Text(
                  '  상기인은 평택시민의료소비자생활협동조합 정관 제11조의 규정에 의하여 가입한 조합원임을 증명합니다.',
                  style: textTheme(context).krTitle1,
                ),
                const Spacer(),
                Text(
                  dateParser(globalState?.createdAt, true),
                  style: textTheme(context).krSubtitle1R,
                ),
                const SizedBox(height: 40),
                Text(
                  '평택시민의료소비자생활협동조합',
                  style: textTheme(context).krTitle1,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

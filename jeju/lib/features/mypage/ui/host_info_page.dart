import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/global/bloc/global_bloc.dart';
import 'package:jeju_host_app/features/mypage/bloc/host_info_bloc.dart';

import '../../../core/core.dart';
import '../bloc/host_info_state.dart';

class HostInfoPage extends StatelessWidget {
  const HostInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: const CustomAppBar(
        tag: 'host_info',
        textTitle: '호스트 정보',
        backButton: true,
      ),
      body: BlocProvider(create: (context) => HostInfoBloc()..add(Initial()),
        child: BlocBuilder<HostInfoBloc, HostInfoState>(
          builder:(context, state){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('이름', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.name ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('이메일 주소', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.email ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('휴대폰 번호', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.phone ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('비상연락번호', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.subPhone ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('등록계좌정보', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.bank ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('사업자 구분', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.businessClassification ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('정산 구분', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.calculateClassification ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('숙소 보유 개수', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(state.dto.account ?? '', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(constraints: const BoxConstraints(minWidth: 100), child: Text('첨부파일', style: context.textTheme.krBody4)),
                          const SizedBox(width: 16),
                          Expanded(child: Text('${state.licenseData['originalFileName'] ?? ''}', style: context.textTheme.krBody3))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),),
      floatingActionButton: LargeButton(
        text: '호스트 정보 수정',
        onTap: () {
          context.push('/info/host/edit');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


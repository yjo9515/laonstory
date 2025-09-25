import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeju_host_app/features/mypage/bloc/profit_management_bloc.dart';
import 'package:jeju_host_app/features/mypage/bloc/profit_management_state.dart';

import '../../../core/core.dart';
import '../../features.dart';

class ProfitManagementPage extends StatelessWidget {
  const ProfitManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['수입금 내역', '출금 내역'];
    final tabController = TabController(length: tabs.length, vsync: Scaffold.of(context));
    return BlocProvider(create: (context) => ProfitManagementBloc()..add(Initial()),
      child: BlocBuilder<ProfitManagementBloc, ProfitManagementState>(
        builder: (context, state){
          return DefaultTabController(
            length: tabs.length,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const TitleText(title: "출금 정보"),
                        Container(
                          color: black7,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Align(alignment: Alignment.centerLeft, child: Text('${state.profit.bank ?? '출금정보가 존재하지 않습니다.'}', style: context.textTheme.krBody3)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    Text('출금 가능 수익금', style: context.textTheme.krSubtitle1),
                                    const Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        text: numberFormatter(state.profit.possibleAmount),
                                        style: context.textTheme.krBody3.copyWith(color: black3),
                                        children: const <TextSpan>[
                                          TextSpan(text: ' 원'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    Text('예상 수익금', style: context.textTheme.krSubtitle1),
                                    const Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        text: numberFormatter(state.profit.anticipateAmount),
                                        style: context.textTheme.krBody3.copyWith(color: black3),
                                        children: const <TextSpan>[
                                          TextSpan(text: ' 원'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    Text('출금 완료 수익금', style: context.textTheme.krSubtitle1),
                                    const Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        text: numberFormatter(state.profit.successAmount),
                                        style: context.textTheme.krBody3.copyWith(color: black3),
                                        children: const <TextSpan>[
                                          TextSpan(text: ' 원'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ];
              },
              body: SafeArea(
                child: Column(
                  children: [
                    TabBar(
                        controller: tabController,
                        indicator: const UnderlineTabIndicator(borderSide: BorderSide(width: 2.0, color: mainJeJuBlue), insets: EdgeInsets.symmetric(horizontal: 0.0)),
                        tabs: tabs
                            .map((e) => Tab(
                                height: 56,
                                child: Center(
                                  child: Text(e, style: context.textTheme.krBody3),
                                )))
                            .toList()),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          InputProfitWidget(data:state.profit.reservationList),
                          OutputProfitWidget(data:state.profit.hostCalculateList),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: LargeButton(
                        color: mainJeJuBlue,
                        onTap: () {
                          // context.push('/reservation/cancel/$id');
                        },
                        text: '출금 신청',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );


  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/custom_app_bar.dart';
import '../bloc/alert_bloc.dart';
import '../widget/alert_list_widget.dart';

enum AlertType { notice, event }

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = PrimaryScrollController.of(context);
    return BlocProvider(
      create: (context) => AlertBloc()..add(const Initial()),
      child: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(
              textTitle: '알림',
              backButton: true,
              onBack: () => context.pop(),
            ),
            body: SingleChildScrollView(
              controller: scrollController..addListener(() => _onScroll(context, scrollController)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (var alert in state.alert) AlertListWidget(alert: alert),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onScroll(BuildContext context, ScrollController controller) {
    if (_isBottom(controller)) {
      BlocProvider.of<AlertBloc>(context).add(const ListFetched());
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

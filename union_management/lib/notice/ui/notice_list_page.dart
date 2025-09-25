import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:union_management/common/util/static_logic.dart';
import 'package:union_management/notice/bloc/notice_bloc.dart';

import '../../admin/settings/model/admin_setting_model.dart';
import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';

class NoticeListPage extends StatelessWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = PrimaryScrollController.of(context);

    return BlocProvider(
      create: (context) => NoticeBloc()..add(const Initial()),
      child: BlocBuilder<NoticeBloc, NoticeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(
              textTitle: "공지사항",
              onBack: () => context.pop(),
              backButton: true,
            ),
            body: SingleChildScrollView(
              controller: scrollController..addListener(() => _onScroll(context, scrollController)),
              child: Column(
                children: state.notices
                    .asMap()
                    .entries
                    .map((e) => NoticeListTile(notice: e.value))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onScroll(BuildContext context, ScrollController controller) {
    if (_isBottom(controller)) {
      BlocProvider.of<NoticeBloc>(context).add(const Page());
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class NoticeListTile extends StatelessWidget {
  const NoticeListTile({Key? key, required this.notice}) : super(key: key);

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/notice/${notice.id}'),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            border: Border(
                bottom: BorderSide(width: 1, color: gray1.withOpacity(0.3)))),
        constraints: const BoxConstraints(maxHeight: 100),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: Text("${notice.title}", style: textTheme(context).krSubtitle1R, maxLines: 1, overflow: TextOverflow.ellipsis,)),
            const SizedBox(width: 8),
            Text(dateParser(notice.createdAt, true),
                style: textTheme(context)
                    .krBody1
                    .copyWith(color: const Color(0xff949494))),
          ],
        ),
      ),
    );
  }
}

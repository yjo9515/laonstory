import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../admin/event/model/admin_event_model.dart';
import '../../common/style.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/custom_app_bar.dart';
import '../bloc/event_bloc.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = PrimaryScrollController.of(context);

    return BlocProvider(
      create: (context) => EventBloc()..add(const Initial()),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(
              textTitle: "행사",
              onBack: () => context.pop(),
              backButton: true,
            ),
            body: SingleChildScrollView(
              controller: scrollController..addListener(() => _onScroll(context, scrollController)),
              child: Column(
                children: state.events
                    .asMap()
                    .entries
                    .map((e) => EventListTile(event: e.value))
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
      BlocProvider.of<EventBloc>(context).add(const Page());
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class EventListTile extends StatelessWidget {
  const EventListTile({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/event/${event.id}'),
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
            Expanded(child: Text("${event.title}", style: textTheme(context).krBody1, overflow: TextOverflow.ellipsis,)),
            const SizedBox(width: 8),
            Text(dateParser(event.createdAt, true),
                style: textTheme(context)
                    .krBody1
                    .copyWith(color: const Color(0xff949494))),
          ],
        ),
      ),
    );
  }
}


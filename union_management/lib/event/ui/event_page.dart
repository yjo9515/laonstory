import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/widget/custom_app_bar.dart';
import '../bloc/event_bloc.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc()..add(Detail(id)),
      child: BlocConsumer<EventBloc, EventState>(
        listenWhen: (prev, state) => prev.message != state.message,
        listener: (context, state) {
          if (state.message.isNotEmpty) IconDialog.show(context: context, title: "", iconTitle: true, content: state.message, iconType: AlertIconType.alert);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              onBack: () => context.pop(),
              backButton: true,
              textTitle: "행사",
              actions: [
                if (state.detailEvent.request ?? false)
                  IconButton(
                      onPressed: () {
                        showEventModal(context, onClick: () {
                          context.read<EventBloc>().add(CancelRequest(id));
                        });
                      },
                      icon: const Icon(Icons.more_vert)),
                const SizedBox(width: 4),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.detailEvent.event?.title ?? "", style: textTheme(context).krTitle1),
                      const SizedBox(height: 24),
                      Html(data: state.detailEvent.event?.content ?? ""),
                    ],
                  ),
                ),
              ),
            ),
            // bottomNavigationBar: state.detailEvent.request == null
            //     ? null
            //     : InkWell(
            //         onTap: () {
            //           if (!state.detailEvent.request!) context.read<EventBloc>().add(Request(id));
            //         },
            //         child: Container(
            //           constraints: const BoxConstraints(maxHeight: 80),
            //           padding: const EdgeInsets.only(bottom: 32),
            //           color: state.detailEvent.request! ? gray2 : primary,
            //           alignment: Alignment.bottomCenter,
            //           child: Text(
            //             state.detailEvent.request! ? '신청 완료된 행사' : '행사 신청',
            //             style: textTheme(context).krSubtitle1.copyWith(color: white),
            //           ),
            //         ),
            //       ),
          );
        },
      ),
    );
  }
}

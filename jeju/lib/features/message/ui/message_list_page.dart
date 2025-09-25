import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';
import '../bloc/message_list_bloc.dart';
import '../bloc/message_state.dart';
import '../widget/message_widget.dart';

class MessageListPage extends StatelessWidget {
  const MessageListPage({Key? key, required this.index,required this.type}) : super(key: key);

  final int index;
  final UserType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        textTitle: '메시지',
      ),
      body: index != 3
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const Column(
                children: [
                  MessageWidget(),
                  MessageWidget(),
                ],
              ))
          : BlocProvider(
              create: (context) => MessageListBloc()..add(Initial(data:type)),
              child: BlocBuilder<MessageListBloc, MessageListState>(
                builder: (context, state) {
                  if (state.messageList.isEmpty) {
                    return Center(child: Text('메시지가 없습니다.', style: context.textTheme.krBody3));
                  }
                  return SingleChildScrollView(
                    child:
                    Column(
                      children: state.messageList
                          .map(
                            (message) => MessageWidget(
                              message: message,
                              onTap: () => context.push('/message/${message.id}'),
                            ),
                          )
                          .toList(),
                    )
                  );
                },
              ),
            ),
    );
  }
}

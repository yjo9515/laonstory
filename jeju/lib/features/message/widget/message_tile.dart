import 'package:flutter/material.dart';

import '../../../core/core.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, this.onTap, this.onLongPress, this.own = true}) : super(key: key);

  final Function()? onTap;
  final Function()? onLongPress;

  final bool own;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: own ? 72 : 0, right: own ? 0 : 72),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 307),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(border: Border.all(color: black5, width: own ? 0 : 0.5), borderRadius: BorderRadius.circular(16), color: own ? context.colorScheme.messageBackground : null),
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          onLongPress: () {
            onLongPress?.call();
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Text('안녕하세요! 문의 주셔서 정말 감사드립니다. 저희 [혼자서 하얗게 No.1] 1인 장기투숙을 원하시는 분들께 가장 적합한 서비스를 제공하고자 1인 체험을 다량 보유하고있습니다. 원하신다면 제공 목록을 보내드릴까요?', style: context.textTheme.krBody3),
          ),
        ),
      ),
    );
  }
}

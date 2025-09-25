import 'package:flutter/material.dart';

import '../core.dart';

class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      color: black7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주식회사 라온스토리', style: context.textTheme.krBody2.copyWith(color: black4)),
          const SizedBox(height: 24),
          Text('서울특별시 금천구 가산디지털2로 95, KM타워 1406호', style: context.textTheme.krBody2.copyWith(color: black4)),
          const SizedBox(height: 8),
          Text('Tel. 070-7010-7108  |  Fax. 02-852-1198  |  대표이사  박재홍  ', style: context.textTheme.krBody2.copyWith(color: black4)),
          const SizedBox(height: 8),
          Text('COPYRIGHT © LAONSTORY ALL RIGHT RESERVED.', style: context.textTheme.krBody2.copyWith(color: black4)),
        ],
      ),
    );
  }
}

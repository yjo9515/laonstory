import 'package:flutter/material.dart';
import 'package:jeju_host_app/core/core.dart';

import '../widget/toss_payment_widget.dart';

class PaymentPage extends StatelessWidget {
  // const PaymentPage({super.key, required this.totalAmount, required this.order , required this.name});
  const PaymentPage({required this.list});

  // final int totalAmount;
  // final String order;
  // final String name;
  final list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backButton: true, textTitle: '결제 진행'),
      body: TossPaymentWidget(totalAmount: list['totalAmount'],order: list['order'],name: list['name'],id: list['id'],dateRange: list['dateRange'], guestCount: list['guestCount'],),
    );
  }

}

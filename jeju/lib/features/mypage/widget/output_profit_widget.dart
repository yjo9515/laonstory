import 'package:flutter/material.dart';

import '../../../core/core.dart';

class OutputProfitWidget extends StatelessWidget {
  OutputProfitWidget({super.key, this.data});
  List<HostCalculateList>? data;

  Map<String, List<HostCalculateList>> monthData = {};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children:monthData.entries.map((entry) {
            String date = entry.key;
            List<HostCalculateList> list = entry.value;
            int totalAmount = list.fold(0, (sum, item) => sum + item.completeAmount!);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('$date', style: context.textTheme.krSubtitle1),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          text: numberFormatter(totalAmount),
                          style: context.textTheme.krBody3.copyWith(color: mainJeJuBlue),
                          children: const <TextSpan>[
                            TextSpan(text: ' 원'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: monthData[date]!.map((e) {
                      return Padding(padding: EdgeInsets.symmetric(horizontal:0, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex:6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('2023.07.02  21:39', style: context.textTheme.krBody4),
                                    const SizedBox(height: 16),
                                    // Text('${e.} | 결제금액  :  ${numberFormatter(e.totalAmount)}원', style: context.textTheme.krBody3),
                                  ],
                                ))
                            ,
                            Expanded(
                                flex:4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${numberFormatter(e.completeAmount)}원', style: context.textTheme.krBody5),
                                    const SizedBox(height: 8),
                                    Text('${e.status}', style: context.textTheme.krBody3),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList()
      ),
    );
  }
}

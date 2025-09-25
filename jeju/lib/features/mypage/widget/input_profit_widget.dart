import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';

class InputProfitWidget extends StatelessWidget {
  InputProfitWidget({super.key, this.data});
  List<ReservationList>? data;
  List<ReservationList> data2 = [
    ReservationList(
      id: 19,
      orderNumber: "R17079219461067",
      totalAmount: 103950,
      createdAt: "2024-02-14T14:46:11.769678",
      calculateStatus: "취소 건",
    ),
    ReservationList(
      id: 20,
      orderNumber: "R17079219461068",
      totalAmount: 123450,
      createdAt: "2024-03-21T15:30:00.123456",
      calculateStatus: "완료 건",
    ),
    ReservationList(
      id: 21,
      orderNumber: "R17079219461069",
      totalAmount: 135000,
      createdAt: "2024-02-25T16:20:30.987654",
      calculateStatus: "완료 건",
    ),
  ];



  Map<String, List<ReservationList>> monthData = {};

  @override
  Widget build(BuildContext context) {
    for (var item in data!) {
      DateTime dateTime = DateTime.parse(item.createdAt!);
      String month = DateFormat('yyyy년 MM월').format(dateTime) ;
      if (!monthData.containsKey(month.toString())) {
        monthData[month.toString()] = [];
      }
      monthData[month.toString()]!.add(item);
    }
    return SingleChildScrollView(
      child: Column(
        children:monthData.entries.map((entry) {
          String date = entry.key;
          List<ReservationList> list = entry.value;
          int totalAmount = list.fold(0, (sum, item) => sum + item.totalAmount!);
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
                                    Text('${DateFormat('yyyy.MM.dd  HH:mm').format(DateTime.parse(e.createdAt!))}', style: context.textTheme.krBody4),

                                    const SizedBox(height: 16),
                                    Text('${e.orderNumber} | 결제금액  :  ${numberFormatter(e.totalAmount)}원', style: context.textTheme.krBody3),
                                  ],
                                ))
                            ,
                            Expanded(
                                flex:4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${numberFormatter(e.beforeAmount)}원', style: context.textTheme.krBody5),
                                    const SizedBox(height: 8),
                                    Text('${e.calculateStatus}', style: context.textTheme.krBody3),
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
    ));
  }
}

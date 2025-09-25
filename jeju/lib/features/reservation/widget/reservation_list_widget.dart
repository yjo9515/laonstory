import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/core/config/style.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/core/domain/model/reservation_model.dart';

import '../../../core/domain/api/api_url.dart';
import '../../../core/util/static_logic.dart';

class ReservationListWidget extends StatelessWidget {
  const ReservationListWidget({Key? key, required this.response}) : super(key: key);

  final List<Reservation> response;


  @override
  Widget build(BuildContext context) {
    return Column(
      children:List.generate(
        response.length,
            (index) => ReservationTile(
              data : response[index]
            )
      )
    );
  }
}

class ReservationTile extends StatelessWidget {
  const ReservationTile({Key? key, required this.data}) : super(key: key);
  final Reservation data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: InkWell(
            onTap: (){
              context.push('/reservation/${data.id}');
            },
            child: Container(
                constraints: const BoxConstraints(minHeight: 100, maxHeight: 140),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(image:(data != null && data.image != null && data.image!.path != null && data.image!.path!.isNotEmpty)? NetworkImage('$imageUrl${data?.image?.path}') : NetworkImage('https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}'), fit: BoxFit.cover),
                        ),
                        // child: Text('${data.image?.path ?? 'ddd'}'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data.name}', overflow: TextOverflow.ellipsis, style: context.textTheme.krSubtitle1),
                            const SizedBox(height: 8),
                            Text('${DateFormat('yyyy-MM-dd').format(data.startDate!)} - ${DateFormat('yyyy-MM-dd').format(data.endDate!)}', style: context.textTheme.krBody1.copyWith(color: black3)),
                            const SizedBox(height: 18),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(numberFormatter(data.totalAmount), style: context.textTheme.krBody5),
                                const SizedBox(width: 8),
                                Text('${data.days}박', style: context.textTheme.krBody1.copyWith(color: black3)),
                              ],
                            ),
                          ],
                        ))

                  ],
                )
            ),
          ),
        ),
        (data.status == '취소')?
        Container(
          constraints: const BoxConstraints(maxHeight: 56),
          margin:  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: const EdgeInsets.symmetric( horizontal: 24),
          decoration: BoxDecoration(border: Border.all(color: black5, width: 0.5), color: Color.fromARGB(
              255, 210, 215, 221), borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            child: Center(
              child:
                  Text(
                    '예약 취소 완료',
                    style: context.textTheme.krBody4.copyWith(color: Color.fromARGB(
                        255, 134, 140, 145)),
                  ),
            ),
          ),
        ) : InkWell(onTap: (){
          logger.d(data.room);
          // context.push('/reservation/review', extra: data.room);
        },
        child: Container(
          constraints: const BoxConstraints(maxHeight: 56),
          margin:  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: const EdgeInsets.symmetric( horizontal: 24),
          decoration: BoxDecoration(border: Border.all(color: black5, width: 0.5), color:Colors.white, borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            child: Center(
              child:
              Text(
                '리뷰 남기기',
                style: context.textTheme.krBody4.copyWith(color: Color.fromARGB(
                    255, 87, 88, 97)),
              ),
            ),
          ),
        ),
        ) ,
      ],
    )
     ;
  }
}

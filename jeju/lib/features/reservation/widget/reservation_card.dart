import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/core/config/style.dart';

import '../../../core/config/logger.dart';
import '../../../core/domain/model/reservation_model.dart';
import '../../../core/util/static_logic.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({Key? key,required this.response,}) : super(key: key);

  final Reservation response;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [Colors.black.withOpacity(0), Colors.black, Colors.black],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              '나의 예약',
              style: context.textTheme.krSubtitle1.copyWith(color: white),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/reservation_card.png'), fit: BoxFit.fill),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('예약일', style: context.textTheme.krSubtitle1),
                    const SizedBox(width: 16),
                    Text('${DateFormat('yyyy/MM/dd').format(response.createdAt ?? DateTime.now())}', style: context.textTheme.krBody3),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(onPressed: (){
                  context.push('/reservation/${response.id}');

                }, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Expanded(child: Text('${response.name}', style: context.textTheme.krPoint1, softWrap: true,)),SizedBox(width: 10,),Icon(Icons.arrow_circle_right, color: Colors.blue,size: 30,)],)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '숙박 시작 일',
                          style: context.textTheme.krBody1.copyWith(color: black3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${DateFormat('yyyy/MM/dd').format(response.startDate ?? DateTime.now())}',
                          style: context.textTheme.krSubtitle1,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 16,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFD2D7DC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '퇴실 예정 일',
                          style: context.textTheme.krBody1.copyWith(color: black3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${DateFormat('yyyy/MM/dd').format(response.endDate ?? DateTime.now())}',
                          style: context.textTheme.krSubtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Separator(height: 1, color: Color(0xFFD2D7DC)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('${response.days} 박', style: context.textTheme.krPoint1),
                    const SizedBox(width: 16),
                    Container(
                      width: 1,
                      height: 16,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFD2D7DC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('${response.people}명', style: context.textTheme.krPoint1),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${numberFormatter(response.totalAmount)}',
                      textAlign: TextAlign.right,
                      style: context.textTheme.krPoint1.copyWith(color: white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '원',
                      textAlign: TextAlign.right,
                      style: context.textTheme.krPoint1.copyWith(color: white),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2C2D35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(92),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 5,
                            offset: Offset(3, 2),
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: const Icon(Icons.receipt_long_outlined, color: white),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(92),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 5,
                            offset: Offset(3, 2),
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: const Icon(Icons.chat_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key? key, this.height = 1, this.color = Colors.black}) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

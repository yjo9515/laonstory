import 'dart:math';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../bloc/reservation_state.dart';

/// Custom event widget with rounded borders
class EventWidget extends StatelessWidget {
  const EventWidget({
    required this.drawer,
    super.key,
    this.events = const {},
    required this.controller,
  });

  final EventProperties drawer;
  final Map<String, CalenderEvent> events;
  final CrCalendarController controller;

  @override
  Widget build(BuildContext context) {

    final event = events[drawer.name];
    if (event?.model.name == '0') return Container();
    // if(controller.selectedEvents)
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(48)),
        color: mainJeJuBlue,
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: const Border.fromBorderSide(BorderSide(color: white, width: 2)),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                      event?.imageUrl != null && event!.imageUrl!.isNotEmpty ?
                      NetworkImage(
                        '${event.imageUrl}',
                      ):
                      NetworkImage(
                        'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            drawer.end - drawer.begin == 0 ?
            Container():
            Text(
              event?.guestName ?? '',
              style: context.textTheme.krBottom.copyWith(color: white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            drawer.end - drawer.begin <= 1 ?
            Container():
            Expanded(
              child: Text(
                '${numberFormatter(event?.price)}원',
                style: context.textTheme.krBottom.copyWith(color: white, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

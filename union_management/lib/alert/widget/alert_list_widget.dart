import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_static_utility/flutter_static_utility.dart';
import 'package:go_router/go_router.dart';

import '../../common/enum/enums.dart';
import '../../common/style.dart';
import '../bloc/alert_bloc.dart';
import '../model/alert_model.dart';

class AlertListWidget extends StatelessWidget {
  const AlertListWidget({Key? key, required this.alert}) : super(key: key);

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    AlertType alertType = alertTypeTextToEnum(alert.type ?? "TYPE_NOTICE");
    return InkWell(
      onTap: () {
        BlocProvider.of<AlertBloc>(context).add(Show(alert.id ?? "0"));
        switch (alertType) {
          case AlertType.notice:
            context.push('/setting/notice/${alert.linkId}');
            break;
          case AlertType.needs:
          case AlertType.like:
          case AlertType.comment:
            context.push('/need/detail/${alert.linkId}');
            break;
        }
      },
      child: Container(
        color: alert.view ?? false ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColorDark,
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(alert.title ?? "", style: textTheme(context).krSubtitle2, maxLines: 2),
                      const SizedBox(height: 12),
                      Text(alert.message ?? "", style: textTheme(context).krSubtext2, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(timeAgo(languageCode: 'ko_KR', dateTime: DateTime.parse(alert.createdAt!)), style: textTheme(context).krSubtext1),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  AlertType alertTypeTextToEnum(String alertType) {
    switch (alertType) {
      case 'TYPE_NOTICE':
        return AlertType.notice;
      case 'TYPE_NEEDS':
        return AlertType.needs;
      case 'TYPE_LIKE':
        return AlertType.like;
      case 'TYPE_COMMENT':
        return AlertType.comment;
      default:
        return AlertType.notice;
    }
  }

  String alertTypeToIcon(AlertType alertType) {
    switch (alertType) {
      case AlertType.notice:
        return 'assets/icons/ic_notice.svg';
      case AlertType.needs:
        return 'assets/icons/ic_needs.svg';
      case AlertType.like:
        return 'assets/icons/ic_like.svg';
      case AlertType.comment:
        return 'assets/icons/ic_comment.svg';
    }
  }

  String alertTypeToText(AlertType alertType) {
    switch (alertType) {
      case AlertType.notice:
        return '공지사항 상세보기';
      case AlertType.needs:
      case AlertType.like:
      case AlertType.comment:
        return '니즈 상세보기';
    }
  }
}

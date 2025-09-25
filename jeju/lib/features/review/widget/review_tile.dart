import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, this.width, this.stretched = false, this.review, this.room}) : super(key: key);

  final Review? review;
  final double? width;
  final bool stretched;
  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: black5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://picsum.photos/${Random().nextInt(100) + 500}/${Random().nextInt(100) + 500}',
                        ),
                      ))),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${room != null ? room?.name : ''}',
                      style: context.textTheme.krSubtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(dateParserDate(review?.createdAt), style: context.textTheme.krBody3),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.star, color: pointJeJuYellow, size: 16),
              const SizedBox(width: 8),
              Text('${review?.totalScore}', style: context.textTheme.krBody3.copyWith(color: black3)),
            ],
          ),
          const SizedBox(height: 16),
          Text('${review?.content}', style: context.textTheme.krBody3, maxLines: stretched ? null : 3, overflow: stretched ? null : TextOverflow.ellipsis),
          const SizedBox(height: 16),
          if (!stretched)
            InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text('더보기', style: context.textTheme.krBody2),
                    const SizedBox(width: 8),
                    const SvgImage(
                      'assets/icons/ic_arrow_right.svg',
                      width: 8,
                      color: black2,
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}

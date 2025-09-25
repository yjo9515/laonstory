import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({Key? key, this.profile}) : super(key: key);

  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgImage('assets/icons/ic_home_light.svg', width: 40, color: context.colorScheme.iconColor),
                  const SizedBox(height: 16),
                  Text('총 예약', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${profile?.reservationCount == null || profile?.reservationCount.toString() == '' ? '-' : profile?.reservationCount }', style: context.textTheme.krBody5),
                ],
              ),
              const SizedBox(height: 32, child: VerticalDivider(width: 80, thickness: 2, color: black6)),
              Column(
                children: [
                  SvgImage('assets/icons/ic_star_light.svg', width: 40, color: context.colorScheme.iconColor),
                  const SizedBox(height: 16),
                  Text('총 리뷰', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${profile?.reviewCount == null || profile?.reviewCount == '' ? '-' : profile?.reviewCount}', style: context.textTheme.krBody5),
                ],
              ),
              const SizedBox(height: 32, child: VerticalDivider(width: 80, thickness: 2, color: black6)),
              Column(
                children: [
                  SvgImage('assets/icons/ic_like_light.svg', width: 40, color: context.colorScheme.iconColor),
                  const SizedBox(height: 16),
                  Text('총 관심', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${profile?.accommodationLikeCount == null || profile?.accommodationLikeCount == '' ? '-' : profile?.accommodationLikeCount }', style: context.textTheme.krBody5),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: black6)
      ],
    );
  }
}

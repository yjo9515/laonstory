import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';

class HostInfoWidget extends StatelessWidget {
  const HostInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(title: "호스트 정보"),
        ProfileWidget(
          loginStatus: LoginStatus.login,
          hostStatus: UserType.host,
          profile: Profile(
              createdAt: DateTime.now(),
              profileImage:
                  'https://lh5.googleusercontent.com/7OYo6b-LqSJdpMe0Mx7-wd8IwJcwABuToQnItSlb-13KElyLiNq0kAmnbJ_JRv7D9anmttBXa0hJTRUB0kCrv0AVyvH0c26UP9iUgi5q3ike8LPryTVXd1IjR8YaXgjXjsD5Fa_c',
              name: '배이수'),
          otherView: true,
        ),
        const Divider(),
        const ProfileDataWidget(),
      ],
    );
  }
}

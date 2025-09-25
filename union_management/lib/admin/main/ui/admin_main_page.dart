import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:union_management/admin/main/model/admin_info_model.dart';
import 'package:union_management/admin/user/ui/admin_user_page.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../dashboard/ui/admin_dashboard_page.dart';
import '../../event/ui/admin_event_page.dart';
import '../../pay/ui/admin_pay_page.dart';
import '../../settings/ui/admin_setting_page.dart';
import '../../widget/binding.dart';
import '../bloc/admin_main_bloc.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminMainBloc()..add(const Initial()),
      child: BlocListener<AdminMainBloc, AdminMainState>(
        listenWhen: (prev, state) => prev.tokenStatus != state.tokenStatus,
        listener: (context, state) {
          switch (state.tokenStatus) {
            case CommonStatus.initial:
              break;
            case CommonStatus.success:
              break;
            case CommonStatus.loading:
              break;
            case CommonStatus.failure:
              context.replace('/');
              break;
          }
        },
        child: Scaffold(
            extendBody: true,
            body: Row(
              children: [
                BlocSelector<AdminMainBloc, AdminMainState, AdminData?>(
                  selector: (state) => state.adminInfo,
                  builder: (context, state) {
                    if (state?.role == 'ROLE_ADMIN' ||
                        state?.role == 'ROLE_UNION') {
                      return NavigationRailWidget(pageController: _pageController);
                    }
                    return Container(color: black, width: 120);
                  },
                ),
                Column(
                  children: [
                    BlocSelector<AdminMainBloc, AdminMainState, AdminData?>(
                      selector: (state) => state.adminInfo,
                      builder: (context, state) {
                        return Container(
                          height: 120,
                          color: white,
                          width: MediaQuery.of(context).size.width - 120,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('온라인 조합원 관리 서비스 플랫폼',
                                    style: textTheme(context).krTitle2),
                                const Spacer(),
                                Text('${state?.name}',
                                    style: textTheme(context).krSubtitle1),
                                const SizedBox(width: 24),
                                InkWell(
                                    onTap: () {
                                      BlocProvider.of<AdminMainBloc>(context)
                                          .add(const LogOut());
                                    },
                                    child: SvgPicture.asset(
                                        'assets/icons/ic_admin_logout.svg')),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    BlocSelector<AdminMainBloc, AdminMainState, AdminData?>(
                      selector: (state) => state.adminInfo,
                      builder: (context, state) {
                        return Flexible(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              children: [
                                if (state?.role == 'ROLE_ADMIN' ||
                                    state?.role == 'ROLE_UNION')
                                  AdminDashboardPage(),
                                AdminUserPage(),
                                if (state?.role == 'ROLE_ADMIN' ||
                                    state?.role == 'ROLE_UNION')
                                  AdminPayPage(),
                                if (state?.role == 'ROLE_ADMIN' ||
                                    state?.role == 'ROLE_UNION')
                                  AdminEventPage(),
                                if (state?.role == 'ROLE_ADMIN' ||
                                    state?.role == 'ROLE_UNION')
                                  AdminSettingPage(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

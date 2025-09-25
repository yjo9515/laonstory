import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_management/admin/login/ui/admin_login_page.dart';
import 'package:union_management/login/ui/login_page.dart';

import '../../admin/login/ui/admin_sign_up_page.dart';
import '../../admin/main/ui/admin_main_page.dart';
import '../../alert/ui/alert_page.dart';
import '../../book/ui/book_page.dart';
import '../../event/ui/event_list_page.dart';
import '../../event/ui/event_page.dart';
import '../../home/ui/society_page.dart';
import '../../main/ui/error_page.dart';
import '../../main/ui/main_page.dart';
import '../../notice/ui/notice_list_page.dart';
import '../../notice/ui/notice_page.dart';
import '../../setting/ui/faq_page.dart';
import '../../setting/ui/permission_page.dart';
import '../../setting/ui/privacy_page.dart';
import '../../setting/ui/question_page.dart';
import '../../setting/ui/service_page.dart';
import '../../setting/ui/setting_page.dart';
import '../../setting/ui/term_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter setRouter = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    initialLocation: '/',
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MainPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'alert',
            builder: (BuildContext context, GoRouterState state) {
              return const AlertPage();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'book',
            builder: (BuildContext context, GoRouterState state) {
              return const BookPage();
            },
          ),
          GoRoute(
              path: 'event',
              builder: (BuildContext context, GoRouterState state) {
                return const EventListPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (BuildContext context, GoRouterState state) {
                    if (state.params['id'] != null || state.params['id'] != '') {
                      return EventPage(id: state.params['id']!);
                    } else {
                      return const ErrorPage();
                    }
                  },
                ),
              ]),
          GoRoute(
              path: 'notice',
              builder: (BuildContext context, GoRouterState state) {
                return const NoticeListPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (BuildContext context, GoRouterState state) {
                    if (state.params['id'] != null || state.params['id'] != '') {
                      return NoticePage(id: state.params['id']!);
                    } else {
                      return const ErrorPage();
                    }
                  },
                ),
              ]),
          GoRoute(
            path: 'society',
            builder: (BuildContext context, GoRouterState state) {
              return const SocietyPage();
            },
          ),
          GoRoute(
            path: 'setting',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingPage();
            },
            routes: [
              GoRoute(
                path: 'permission',
                builder: (BuildContext context, GoRouterState state) {
                  return const PermissionPage();
                },
              ),
              GoRoute(
                path: 'faq',
                builder: (BuildContext context, GoRouterState state) {
                  return const FaqPage();
                },
              ),
              GoRoute(
                path: 'question',
                builder: (BuildContext context, GoRouterState state) {
                  return const QuestionPage();
                },
              ),
              GoRoute(
                  path: 'term',
                  builder: (BuildContext context, GoRouterState state) {
                    return const TermPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'privacy',
                      builder: (BuildContext context, GoRouterState state) {
                        return const PrivacyPage();
                      },
                    ),
                    GoRoute(
                      path: 'service',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ServicePage();
                      },
                    ),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );

  final GoRouter setDesktopRouter = GoRouter(
    errorBuilder: (context, state) => const ErrorPage(),
    initialLocation: '/',
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: AdminLoginPage());
        },
        routes: [
          GoRoute(
            path: 'admin',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: AdminMainPage());
            },
            routes: const [],
          ),GoRoute(
            path: 'signUp',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                      child: child,
                    );
                  },
                  child: const AdminSignUpPage());
            },
          ),
        ],

      ),

    ],
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/features/reservation/ui/reservation_cancel_page.dart';
import 'package:jeju_host_app/features/reservation/ui/reservation_detail_page.dart';
import 'package:jeju_host_app/features/review/ui/add_review_page.dart';
import 'package:jeju_host_app/features/review/ui/my_review_page.dart';
import 'package:jeju_host_app/features/search/ui/search_detail_page.dart';
import 'package:jeju_host_app/features/setting/ui/question_write_page.dart';

import '../../features/auth/ui/auth_page.dart';
import '../../features/features.dart';
import '../../features/global/bloc/global_bloc.dart';
import '../../features/reservation/ui/host_management_page.dart';
import '../../features/reservation/ui/host_reservation_detail_page.dart';
import '../../features/reservation/ui/reservation_done_page.dart';
import '../../features/room/bloc/add_room_bloc.dart';
import '../core.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter setRouter = GoRouter(

    errorBuilder: (context, state) {
      logger.e(state.error?.message);

      return const ErrorPage();
    },
    initialLocation: '/splash',
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          name: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return MainPage(
              key: UniqueKey(),
                initialIndex: state.queryParameters['index'] != null
                    ? int.parse(state.queryParameters['index']!)
                    : 0);
          },
          routes: [
            GoRoute(
              path: 'splash',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: SplashPage());
              },
            ),
            GoRoute(
              path: 'login/:back',
              pageBuilder: (BuildContext context, GoRouterState state) {
                if (state.pathParameters['back'] != null &&
                    state.pathParameters['back'] != '') {
                  return CustomTransitionPage(
                    child:
                        LoginPage(back: state.pathParameters['back'] == 'true'),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                } else {
                  return CustomTransitionPage(
                    child: const LoginPage(back: false),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                }
              },
            ),
            GoRoute(
                name: 'guide',
                path: 'guide',
                builder: (BuildContext context, GoRouterState state) {
                  return const HostGuidePage();
                },
                routes: [
                  GoRoute(
                      path: 'host',
                      builder: (BuildContext context, GoRouterState state) {
                        return const HostGuidePage();
                      },
                      routes: [
                        GoRoute(
                          path: 'done',
                          builder: (BuildContext context, GoRouterState state) {
                            return const HostGuideDonePage();
                          },
                        ),
                      ]),
                  GoRoute(
                    path: 'user',
                    builder: (BuildContext context, GoRouterState state) {
                      return const UserGuidePage();
                    },
                  ),
                ]),
            GoRoute(
              path: 'signup/host/:id',
              pageBuilder: (BuildContext context, GoRouterState state) {
                switch (state.pathParameters['id']) {
                  case '1':
                    return const CupertinoPage(child: HostSignupPageFirst());
                  case '2':
                    return const NoTransitionPage(
                        child: HostSignupPageSecond());
                  case 'done':
                    return CustomTransitionPage(
                        child: const HostSignUpDonePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                  position: offsetAnimation, child: child));
                        });
                  default:
                    return const CupertinoPage(child: HostSignupPageFirst());
                }
              },
            ),
            GoRoute(
                path: 'search',
                builder: (BuildContext context, GoRouterState state) {
                  final roomsMap = state.extra as List<Room>;
                  return SearchDetailPage(state: roomsMap);
                }
            ),
            GoRoute(
                path: 'room/:path',
                name: 'room',
                builder: (BuildContext context, GoRouterState state) {
                  if (state.pathParameters['path'] != null &&
                      state.pathParameters['path'] == '') {
                    logger.e('path is null');
                    return const ErrorPage();
                  } else {
                    switch (state.pathParameters['path']) {
                      case 'wish':
                        return const WishRoomPage();
                      case 'list':
                        return RoomListPage(
                            query: state.queryParameters['query']);
                      case 'recent':
                        return const RecentRoomPage();
                      case 'add':
                        final step = state.queryParameters['step'] ?? '1';
                        late final AddRoomBloc bloc;
                        if (step != '1') {
                          bloc = state.extra as AddRoomBloc;
                        }
                        return switch (step) {
                          '1' => const AddRoomPage(step: '1'),
                          '2' => AddRoomSecondPage(bloc: bloc),
                          '3' => AddRoomThirdPage(bloc: bloc),
                          '4' => AddRoomForthPage(bloc: bloc),
                          '5' => AddRoomFifthPage(bloc: bloc),
                          '6' => AddRoomSixthPage(bloc: bloc),
                          '7' => AddRoomSeventhPage(bloc: bloc),
                          '8' => AddRoomEighthPage(bloc: bloc),
                          '9' => AddRoomExaminePage(bloc: bloc),
                          'done' => AddRoomDonePage(bloc: bloc),
                          _ => const AddRoomPage(step: '1'),
                        };
                      case 'detail':
                        return RoomPage(id: state.queryParameters['id'] ?? '');
                      default:
                        return const ErrorPage();
                    }
                  }
                },
                routes: []),
            GoRoute(
                path: 'message/:id',
                builder: (BuildContext context, GoRouterState state) {
                  return MessageDetailPage(
                      // id: state.pathParameters['id'] ?? ''
                      profile: (state.extra
                      as Map<String, Object?>)['profile'] as Profile,
                      room: (state.extra
                      as Map<String, Object?>)['room'] as Room,
                      type: (state.extra
                      as Map<String, Object?>)['type'] as UserType,
                  );
                }),
            GoRoute(
                path: 'info/host',
                builder: (BuildContext context, GoRouterState state) {
                  return const HostInfoPage();
                },
                routes: [
                  GoRoute(
                      path: 'edit',
                      builder: (BuildContext context, GoRouterState state) {
                        return const HostInfoEditPage();
                      },
                      routes: [
                        GoRoute(
                            path: 'done',
                            builder: (BuildContext context, GoRouterState state) {
                              return const HostInfoEditDonePage();
                            },
                        ),
                      ]
                      ),

                ]),
            GoRoute(
                path: 'setting',
                builder: (BuildContext context, GoRouterState state) {
                  return  SettingPage(bloc: state.extra as GlobalBloc,);
                },
                routes: [
                  GoRoute(
                      path: 'notice',
                      builder: (BuildContext context, GoRouterState state) {
                        return const NoticeListPage();
                      },
                      routes: [
                        GoRoute(
                          path: ':id',
                          builder: (BuildContext context, GoRouterState state) {
                            if (state.pathParameters['id'] != null ||
                                state.pathParameters['id'] != '') {
                              return NoticeDetailPage(
                                  id: state.pathParameters['id']!);
                            } else {
                              return const ErrorPage();
                            }
                          },
                        ),
                      ]),
                  GoRoute(
                    path: 'info',
                    builder: (BuildContext context, GoRouterState state) {
                      return EditInfoPage(bloc: state.extra as GlobalBloc);
                    },
                  ),
                  GoRoute(
                    path: 'out/:id',
                    builder: (BuildContext context, GoRouterState state) {
                      switch (state.pathParameters['id']) {
                        case '1':
                          return const OutPageFirst();
                        case '2':
                          return const OutPageSecond();
                        default:
                          return const OutPageFirst();
                      }
                    },
                  ),
                  // GoRoute(
                  //   path: 'permission',
                  //   builder: (BuildContext context, GoRouterState state) {
                  //     return const PermissionPage();
                  //   },
                  // ),
                  GoRoute(
                    path: 'alert',
                    builder: (BuildContext context, GoRouterState state) {
                      return const AlertPage();
                    },
                  ),
                  GoRoute(
                    path: 'faq',
                    builder: (BuildContext context, GoRouterState state) {
                      return const FaqPage();
                    },
                  ),
                  GoRoute(
                    path: 'opensource',
                    builder: (BuildContext context, GoRouterState state) {
                      return const OpenSourcePage();
                    },
                  ),
                  GoRoute(
                    path: 'question',
                    builder: (BuildContext context, GoRouterState state) {
                      return  QuestionPage();
                    },
                    routes: [
                      GoRoute(
                          path: 'write',
                          builder: (BuildContext context, GoRouterState state){
                            return QuestionWritePage();
                          }
                      )
                    ]
                  ),
                  GoRoute(
                    path: 'term',
                    builder: (BuildContext context, GoRouterState state) {
                      return const TermsPage();
                    },
                  ),
                ]),
            GoRoute(
                path: 'reservation',
                builder: (BuildContext context, GoRouterState state) {
                  /// {'room' : state.room, 'dateRange' : state.dateRange, 'guestCount' : state.guestCount}
                  return ReservationPage(
                    room: (state.extra as Map<String, Object?>)['room'] as Room,
                    dateRange: (state.extra
                        as Map<String, Object?>)['dateRange'] as DateRange,
                    guestCount: (state.extra
                        as Map<String, Object?>)['guestCount'] as int,
                    guestPlus: (state.extra
                    as Map<String, Object?>)['guestPlus'] as int,
                    totalAmount:(state.extra
                    as Map<String, Object?>)['totalAmount'] as int,
                    discount:(state.extra
                    as Map<String, Object?>)['discount'] as int,
                    plusPrice:(state.extra
                    as Map<String, Object?>)['plusPrice'] as int,

                    // room: state.queryParameters['room'],
                  );
                },
                routes: [
                  GoRoute(
                      path: 'review',
                      builder:(BuildContext context, GoRouterState state) {
                        return AddReviewPage(
                          room: state.extra as Room,
                        );
                      },
                      routes:[
                        GoRoute(
                            path: 'done',
                            builder: (BuildContext context, GoRouterState state) {
                              return const ReservationDonePage();
                            }
                        ),
                      ]
                  ),
                  GoRoute(
                    path: 'host',
                    builder: (BuildContext context, GoRouterState state) {
                      return HostReservationDetailPage(
                        reservation: state.extra as Reservation,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'management',
                        builder: (BuildContext context, GoRouterState state) {
                          return HostManagementPage(
                             id: (state.extra as Map<String, Object?>)['id'] as int,
                            date: (state.extra as Map<String, Object?>)['date'] as DateTime,

                          );
                        },
                      ),
                    ]
                  ),
                  GoRoute(
                      path: 'done',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ReservationDonePage();
                      }
                  ),
                  GoRoute(
                      path: ':id',
                      builder: (BuildContext context, GoRouterState state) {
                        return ReservationDetailPage(
                            id: state.pathParameters['id'] ?? '',

                        );
                      },
                      ),
                  GoRoute(
                      path: 'cancel/:id',
                      builder: (BuildContext context, GoRouterState state) {
                        return ReservationCancelPage(
                            id: state.pathParameters['id'] ?? ''
                        );
                      },
                  ),

                ]),
            GoRoute(
                path: 'pay',
                builder: (BuildContext context, GoRouterState state) {
                  final extraData = state.extra as Map<String, dynamic>;
                  // return PaymentPage(totalAmount: extraData['totalAmount']!,order : extraData['order']! , name: extraData['name']!,);
                  return PaymentPage(list: extraData,);
                },
                routes: [
                  GoRoute(
                      path: 'done',
                      builder: (BuildContext context, GoRouterState state) {
                        return const PaymentDonePage();
                      }),
                ]),
            GoRoute(
                path: 'auth',
                builder: (BuildContext context, GoRouterState state) {
                  return AuthPage(
                    path: state.queryParameters['path']
                  );
                },
                // routes: [
                //   GoRoute(
                //       path: 'done',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return const PaymentDonePage();
                //       }),
                // ]
            ),
            GoRoute(
                path: 'profit',
                builder: (BuildContext context, GoRouterState state) {
                  return const Scaffold(
                      appBar: CustomAppBar(
                        textTitle: '수익관리',
                        backButton: true,
                      ),
                      body: ProfitManagementPage());
                }),
            GoRoute(
              path: 'myReview',
              builder: (BuildContext context, GoRouterState state) {
                return const MyReviewPage();
              },
            ),
          ]),
      GoRoute(
        path: '/host',
        name: 'hostmain',
        builder: (BuildContext context, GoRouterState state) {
          return HostHomePage(
            onReservation: () {},
            onMyRoom: () {},
          );
        },
      )
    ],
  );
}

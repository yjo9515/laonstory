import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/core.dart';
import 'features/global/bloc/global_bloc.dart';

int id = 0;

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

String? selectedNotificationPayload;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.input?.isNotEmpty ?? false) {
    if (kDebugMode) {
      logger.d('notification action tapped with input: ${notificationResponse.input}');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d('백그라운드');
  logger.d(message.data);
  showNotification(id, Notification.fromJson(message.data));
  // await Firebase.initializeApp();
  // if (AppConfig.to.shared.getBool("TYPE_NEED") ?? false) {
  //   switch (message.data["type"]) {
  //     case "TYPE_LIKE" || "TYPE_COMMENT" || "TYPE_NEED":
  //       showNotification(id, Notification.fromJson(message.data));
  //       break;
  //     default:
  //       break;
  //   }
  // }
}

final router = AppRouter();

Future<void> main() async {
  AppConfig.init(
    callback: () async {
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      // PlatformDispatcher.instance.onError = (error, stack) {
      //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      //   return true;
      // };
      if (kIsWeb) {
        runApp(const Web());
      }
      if (Platform.isAndroid) {
        var androidInfo = await AppConfig.to.deviceInfoPlugin.androidInfo;
        await AppConfig.to.storage.write(key: "deviceId", value: androidInfo.id);
      } else if (Platform.isIOS) {
        var iosInfo = await AppConfig.to.deviceInfoPlugin.iosInfo;
        await AppConfig.to.storage.write(key: "deviceId", value: iosInfo.identifierForVendor);
      }
      runApp(const App());
      return;
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '제주살이',
          darkTheme: darkTheme,
          theme: lightTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          locale: const Locale('ko', 'KR'),
          routerConfig: router.setRouter,
          builder: (context, child) => child!,
        ),
      ),
    );
  }
}

class Web extends StatelessWidget {
  const Web({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: BlocProvider(
        create: (context) => GlobalBloc(),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp.router(

              debugShowCheckedModeBanner: false,
              title: '제주살이',
              darkTheme: darkTheme,
              theme: lightTheme,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ko', 'KR'),
              ],
              locale: const Locale('ko', 'KR'),
              routerConfig: router.setRouter,
              builder: (context, child) {
                ErrorWidget.builder = (errorData) {
                  Widget error = Text('$errorData');
                  if (child is Scaffold || child is Navigator) {
                    error = Scaffold(body: SafeArea(child: error));
                  }
                  return error;
                };
                return child!;
              }),
        ),
      ),
    );
  }
}

class AppConfig {
  static AppConfig get to => AppConfig();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final FirebaseMessaging? _messaging = kIsWeb ? null : FirebaseMessaging.instance;
  static final FirebasePerformance performance = FirebasePerformance.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static late final SharedPreferences _shared;
  static late SecureModel _secureModel;

  FlutterSecureStorage get storage => _storage;

  SharedPreferences get shared => _shared;

  DeviceInfoPlugin get deviceInfoPlugin => _deviceInfoPlugin;

  FirebaseMessaging? get messaging => _messaging;

  SecureModel get secureModel => _secureModel;

  set secureModel(SecureModel secureModel) => {_secureModel = secureModel};

  static Future init({required VoidCallback callback}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }
    setPathUrlStrategy();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if ((await _storage.read(key: 'time_installed')) == null) {
      _storage.write(key: 'time_installed', value: '${DateTime.now().millisecondsSinceEpoch}');
    }
    if (!kIsWeb && _messaging != null) {
      setToken(_messaging!, _storage);
    }
    _shared = await SharedPreferences.getInstance();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    var message = AndroidNotificationChannel(
      'message', // 채널 ID
      '메세지', // 채널 이름
      importance: Importance.max, // 알림 중요도 설정
    );
    var reservation = AndroidNotificationChannel(
      'reservation', // 채널 ID
      '예약', // 채널 이름
      importance: Importance.max, // 알림 중요도 설정
    );
    var question = AndroidNotificationChannel(
      'question', // 채널 ID
      '1:1문의', // 채널 이름
      importance: Importance.max, // 알림 중요도 설정
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(message);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(reservation);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(question);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('백그');
      showNotification(id, Notification.fromJson(message.data));
      switch (message.data["type"]) {
        case "TYPE_NOTICE":
          navigatorKey.currentContext!.push('/setting/notice/${message.data["id"]}');
          break;
        case "TYPE_EVENT":
          navigatorKey.currentContext!.push('/event/${message.data["id"]}');
          break;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.d('포그라운드');
      logger.d(message.data);
      logger.d(message.notification?.title);
      logger.d(message.notification?.body);
        switch (message.data["type"]) {
          case "TYPE_QUESTION" || "TYPE_RESERVATION" || "TYPE_MESSAGE":
            showNotification(id, Notification.fromJson(message.data));
            break;
          default:
            break;
        }
      // if (AppConfig.to.shared.getBool("TYPE_NEED") ?? false) {
      //   switch (message.data["type"]) {
      //     case "TYPE_LIKE" || "TYPE_COMMENT":
      //       showNotification(id, Notification.fromJson(message.data));
      //       break;
      //     default:
      //       break;
      //   }
      // }
    });
    KakaoSdk.init(nativeAppKey: '46bc4f64e5379d343a451d4c6797b855', javaScriptAppKey: '92c79a92685edf13626cec7027a7eea4');
    if (!kIsWeb) {
      await NaverMapSdk.instance.initialize(clientId: "0gntezwy34",onAuthFailed: (ex) {
        logger.d("********* 네이버맵 인증오류 : $ex *********");
      });
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await _shared.setString('app_version', packageInfo.version);
    callback();
  }
}

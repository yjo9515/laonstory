import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/style.dart';
import 'common/util/firebase_options.dart';
import 'common/util/routes.dart';
import 'global/bloc/global_bloc.dart';

int id = 0;

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

String? selectedNotificationPayload;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.input?.isNotEmpty ?? false) {
    if (kDebugMode) {
      print('notification action tapped with input: ${notificationResponse.input}');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    showNotification(message, id++);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb && (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows)) {
    setPathUrlStrategy();
    runApp(DesktopWeb());
    return;
  }
  AppConfig.init(
    () async {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      if (kIsWeb) {
        var webBrowserInfo = await AppConfig.to.deviceInfoPlugin.webBrowserInfo;
        var deviceIdentifier = "${webBrowserInfo.vendor}${webBrowserInfo.userAgent}${webBrowserInfo.hardwareConcurrency}";
        await AppConfig.to.storage.write(key: "deviceId", value: deviceIdentifier.trim());
        runApp(Web());
      } else {
        if (Platform.isAndroid) {
          var androidInfo = await AppConfig.to.deviceInfoPlugin.androidInfo;
          await AppConfig.to.storage.write(key: "deviceId", value: androidInfo.id);
        } else if (Platform.isIOS) {
          var iosInfo = await AppConfig.to.deviceInfoPlugin.iosInfo;
          await AppConfig.to.storage.write(key: "deviceId", value: iosInfo.identifierForVendor);
        }
        runApp(App());
      }
    },
  );
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalBloc()..add(const InitialConfig()),
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '협동조합',
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
          themeMode: ThemeMode.light,
          routerConfig: _router.setRouter,
          builder: (context, child) => ResponsiveWrapper.builder(child,
              minWidth: 428,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.resize(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
        ),
      ),
    );
  }
}

class Web extends StatelessWidget {
  Web({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: BlocProvider(
        create: (context) => GlobalBloc()..add(const InitialConfig()),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: '협동조합',
            darkTheme: lightTheme,
            theme: lightTheme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ko', 'KR'),
            ],
            locale: const Locale('ko', 'KR'),
            themeMode: ThemeMode.light,
            routerConfig: _router.setRouter,
            builder: (context, child) => ResponsiveWrapper.builder(child,
                maxWidth: (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows) ? 720 : null,
                minWidth: 428,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(480, name: MOBILE),
                  const ResponsiveBreakpoint.resize(800, name: TABLET),
                ],
                background: Container(color: const Color(0xFFF5F5F5))),
          ),
        ),
      ),
    );
  }
}

class DesktopWeb extends StatelessWidget {
  DesktopWeb({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '조합원 관리 시스템',
          darkTheme: lightTheme,
          theme: lightTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          locale: const Locale('ko', 'KR'),
          themeMode: ThemeMode.system,
          routerConfig: _router.setDesktopRouter,
          builder: (context, child) => ResponsiveWrapper.builder(child,
              defaultScale: true,
              minWidth: 0,
              breakpoints: [
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP, scaleFactor: 1.0),
                const ResponsiveBreakpoint.autoScale(600, name: TABLET, scaleFactor: 0.5),
                const ResponsiveBreakpoint.autoScale(480, name: MOBILE, scaleFactor: 0.4),
                const ResponsiveBreakpoint.autoScale(428, name: MOBILE, scaleFactor: 0.35),
                const ResponsiveBreakpoint.autoScaleDown(240, name: MOBILE, scaleFactor: 0.2),
                const ResponsiveBreakpoint.autoScaleDown(10, name: MOBILE, scaleFactor: 0.1),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
        ),
      ),
    );
  }
}

class AppConfig {
  static AppConfig get to => AppConfig();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebasePerformance performance = FirebasePerformance.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  get storage => _storage;

  get deviceInfoPlugin => _deviceInfoPlugin;

  get messaging => _messaging;

  static Future init(VoidCallback callback) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setToken(_messaging, _storage);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    // await flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings,
    //   onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
    //     switch (notificationResponse.notificationResponseType) {
    //       case NotificationResponseType.selectedNotification:
    //         selectNotificationStream.add(notificationResponse.payload);
    //         break;
    //       case NotificationResponseType.selectedNotificationAction:
    //         if (notificationResponse.actionId == navigationActionId) {
    //           selectNotificationStream.add(notificationResponse.payload);
    //         }
    //         break;
    //     }
    //   },
    //   onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    // );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        showNotification(message, id);
      }
    });

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_version', packageInfo.version);

    callback();
  }
}

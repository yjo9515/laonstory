import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/core.dart';
import 'features/features.dart';

Future<void> main() async {
  AppConfig.init(
    callback: () async {
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      runApp(const App());
      return;
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
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
        builder: (context, child) => child!,
        home: PaymentDonePage(),
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
  static late final SharedPreferences _shared;

  FlutterSecureStorage get storage => _storage;

  SharedPreferences get shared => _shared;

  DeviceInfoPlugin get deviceInfoPlugin => _deviceInfoPlugin;

  FirebaseMessaging get messaging => _messaging;

  static Future init({required VoidCallback callback}) async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    callback();
  }
}

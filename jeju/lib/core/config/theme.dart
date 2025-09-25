import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

var lightTheme = ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    ColorTheme.light,
    KRTextTheme.light,
  ],
  brightness: Brightness.light,
  dividerColor: gray6,
  textTheme: const TextTheme(
    titleSmall: TextStyle(fontFamily: krFontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: black),
    bodyLarge: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: black),
    bodyMedium: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: gray1),
    bodySmall: TextStyle(fontFamily: krFontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: gray1),
  ).apply(bodyColor: black),
  scaffoldBackgroundColor: MyColors.light.background,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: white),
  appBarTheme: const AppBarTheme(backgroundColor: lightBackground, foregroundColor: black1, systemOverlayStyle: SystemUiOverlayStyle.dark, iconTheme: IconThemeData(color: black3)),
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(insets: EdgeInsets.only(left: 24.0, right: 24.0, top: 16), borderSide: BorderSide(width: 2, color: black)),
    labelColor: black,
    unselectedLabelColor: black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: black6,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color(0xffD2D7DD), width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    contentPadding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
    hintStyle: KRTextTheme.light.krBody3.copyWith(color: black4),
    counterStyle: KRTextTheme.light.krBody3.copyWith(color: black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: white.withOpacity(0),
    elevation: 0,
    selectedItemColor: mainJeJuBlue,
    unselectedItemColor: gray3,
  ),
  dialogBackgroundColor: white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(black),
      foregroundColor: MaterialStateProperty.all<Color>(white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),
  primaryColor: black,
  primaryColorLight: blue1,
  primaryColorDark: white,
);

var darkTheme = ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    ColorTheme.dark,
    KRTextTheme.dark,
  ],
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.dark.background,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: black),
  dividerColor: black,
  textTheme: const TextTheme(
    titleSmall: TextStyle(fontFamily: krFontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: white),
    bodyLarge: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: white),
    bodyMedium: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: white),
    bodySmall: TextStyle(fontFamily: krFontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: white),
  ).apply(bodyColor: white),
  appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: black3), backgroundColor: black, foregroundColor: white, systemOverlayStyle: SystemUiOverlayStyle.light),
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(insets: EdgeInsets.only(left: 24.0, right: 24.0, top: 16), borderSide: BorderSide(width: 2, color: white)),
    labelColor: white,
    unselectedLabelColor: white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: const Color(0x0DFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color(0xffD2D7DD), width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: const Color(0xffD2D7DD).withOpacity(0), width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    contentPadding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
    hintStyle: KRTextTheme.light.krBody3.copyWith(color: black4),
    counterStyle: KRTextTheme.light.krBody3.copyWith(color: black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: black.withOpacity(0),
    elevation: 0,
    selectedItemColor: white,
    unselectedItemColor: gray1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(black),
      foregroundColor: MaterialStateProperty.all<Color>(white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),
  dialogBackgroundColor: black,
  primaryColor: white,
  primaryColorLight: black,
  primaryColorDark: gray0,
);

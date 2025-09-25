import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const enFontFamily = "CabinetGrotesk";
const krFontFamily = "LINESeedKR";

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

extension CustomTextTheme on TextTheme {
  TextStyle get enTitle1 => const TextStyle(fontFamily: enFontFamily, fontSize: 24, fontWeight: FontWeight.w800);

  TextStyle get enTitle2 => const TextStyle(fontFamily: enFontFamily, fontSize: 20, fontWeight: FontWeight.w800);

  TextStyle get enTitle2M => const TextStyle(fontFamily: enFontFamily, fontSize: 20, fontWeight: FontWeight.w500);

  TextStyle get enSubtitle1 => const TextStyle(fontFamily: enFontFamily, fontSize: 18, fontWeight: FontWeight.w800);

  TextStyle get enSubtitle1M => const TextStyle(fontFamily: enFontFamily, fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle get enSubtitle2 => const TextStyle(fontFamily: enFontFamily, fontSize: 16, fontWeight: FontWeight.w800);

  TextStyle get enBody1 => const TextStyle(fontFamily: enFontFamily, fontSize: 16, fontWeight: FontWeight.w700);

  TextStyle get enBody1M => const TextStyle(fontFamily: enFontFamily, fontSize: 16, fontWeight: FontWeight.w500);

  TextStyle get enSubtext1 => const TextStyle(fontFamily: enFontFamily, fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get enSubtext2 => const TextStyle(fontFamily: enFontFamily, fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle get krTitle1 => const TextStyle(fontFamily: krFontFamily, fontSize: 24, fontWeight: FontWeight.w700);

  TextStyle get krTitle2 => const TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w700);

  TextStyle get krTitle2R => const TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w400);

  TextStyle get krSubtitle1 => const TextStyle(fontFamily: krFontFamily, fontSize: 18, fontWeight: FontWeight.w700);

  TextStyle get krSubtitle1R => const TextStyle(fontFamily: krFontFamily, fontSize: 18, fontWeight: FontWeight.w400);

  TextStyle get krSubtitle2 => const TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w700);

  TextStyle get krBody1 => const TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle get krBody2 => const TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w700);

  TextStyle get krSubtext1 => const TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w400);

  TextStyle get krSubtext1B => const TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w700);

  TextStyle get krSubtext2 => const TextStyle(fontFamily: krFontFamily, fontSize: 12, fontWeight: FontWeight.w400);
}

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.background,
    required this.loginTextColor,
  });

  final Color? background;
  final Color? loginTextColor;

  @override
  ThemeExtension<MyColors> copyWith({Color? background, Color? loginTextColor}) {
    return MyColors(
      background: background ?? this.background,
      loginTextColor: loginTextColor ?? this.loginTextColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(background: Color.lerp(background, other.background, t), loginTextColor: Color.lerp(loginTextColor, other.loginTextColor, t));
  }

  static const light = MyColors(
    background: lightBackground,
    loginTextColor: gray1,
  );

  static const dark = MyColors(
    background: black2,
    loginTextColor: white,
  );
}

const lightBackground = Color(0xffF8F9FB);
const black = Colors.black;
const black2 = Color(0xff1E1E1E);
const gray0 = Color(0xff2e2e2f);
const gray1 = Color(0xff4F4F4F);
const gray2 = Color(0xff828282);
const gray3 = Color(0xffBDBDBD);
const gray4 = Color(0xff7E7E7E);
const gray5 = Color(0xffDDDDDD);
const gray6 = Color(0xffE1E1E1);
const gray7 = Color(0xffF0F0F0);
const gray8 = Color(0xff5C5C5C);
const gray9 = Color(0xffFBFBFB);
const white = Colors.white;
const white2 = Color(0xffFCFCFC);
const primary = Color(0xff2C68C1);
const primary2 = Color(0xff6DA4F6);
const green = Color(0xff53FF9A);
const borderColor = Color(0xffFEFEFE);
final dropShadowColor_1 = const Color(0xff5C4D4D).withOpacity(0.25);
final dropShadowColor_2 = black.withOpacity(0.05);
final dropShadowColor_3 = const Color(0xff000000).withOpacity(0.20);
final dropShadowColor_4 = black.withOpacity(0.4);

var lightTheme = ThemeData(
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
  appBarTheme: const AppBarTheme(backgroundColor: lightBackground, foregroundColor: black, systemOverlayStyle: SystemUiOverlayStyle.dark, iconTheme: IconThemeData(color: black)),
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(insets: EdgeInsets.only(left: 24.0, right: 24.0, top: 16), borderSide: BorderSide(width: 2, color: black)),
    labelColor: black,
    unselectedLabelColor: black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: white,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 2.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 22.5, bottom: 22.5),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: white.withOpacity(0),
    elevation: 0,
    selectedItemColor: black,
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
  primaryColorLight: green,
  primaryColorDark: white,
);

var darkTheme = ThemeData(
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
  appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: white), backgroundColor: black, foregroundColor: white, systemOverlayStyle: SystemUiOverlayStyle.light),
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(insets: EdgeInsets.only(left: 24.0, right: 24.0, top: 16), borderSide: BorderSide(width: 2, color: white)),
    labelColor: white,
    unselectedLabelColor: white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 2.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: gray7, width: 1.0),
    ),
    contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 22.5, bottom: 22.5),
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

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    if (hexColor != null) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return int.parse(hexColor, radix: 16);
    } else {
      return int.parse("FF000000", radix: 16);
    }
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}

class ColorHex extends StringBuffer {
  static String _getHexFromColor(Color? color) {
    if (color != null) {
      var colorText = color.toString().replaceAll('Color(', '').replaceAll(')', '').replaceAll('0xff', '').toUpperCase();
      return colorText;
    } else {
      return "000000";
    }
  }

  ColorHex(final Color? hexColor) : super(_getHexFromColor(hexColor));
}

class TextColor extends Color {
  static int _getTextColor(String bgColor) => HexColor(bgColor).computeLuminance() > 0.5 ? black.value : white.value;

  TextColor(final String? bgColor) : super(_getTextColor(bgColor ?? ""));
}

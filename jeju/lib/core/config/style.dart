import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'generated/style.g.dart';

const enFontFamily = "CabinetGrotesk";
const krFontFamily = "LINESeedKR";
const lightBackground = Color(0xffFFFFFF);
const darkBackground = Color(0xff171717);
const darkForeground = Color(0xff262626);
const borderColor = Color(0xffFEFEFE);
const dropShadowColor_1 = Color.fromRGBO(92, 77, 77, 0.25);
const dropShadowColor_2 = Color.fromRGBO(0, 0, 0, 0.05);
const dropShadowColor_3 = Color.fromRGBO(0, 0, 0, 0.2);
const dropShadowColor_4 = Color.fromRGBO(0, 0, 0, 0.4);
const lightSurfaceColor = Color.fromRGBO(255, 255, 255, 0.9);
const darkSurfaceColor = Color.fromRGBO(60, 60, 60, 0.7);
const black = Colors.black;
const black1 = Color(0xff2D2D35);
const black2 = Color(0xff1E1E1E);
const black3 = Color(0xff868C91);
const black4 = Color(0xffAAB0B6);
const black5 = Color(0xffD2D7DD);
const black6 = Color(0xffEDF1F6);
const black7 = Color(0xffF7FAFC);
const gray0 = Color(0xffADADAD);
const gray1 = Color(0xffEFF1F6);
const gray2 = Color(0xff888888);
const gray3 = Color(0xffBDBDBD);
const gray4 = Color(0xffCECECE);
const gray5 = Color(0xffDDDDDD);
const gray6 = Color(0xffE8E8E8);
const gray7 = Color(0xffF0F0F0);
const gray8 = Color(0xffF6F6F6);
const gray9 = Color(0xffFBFBFB);
const white = Colors.white;
const blue1 = Color(0xff2F80ED);
const secondColor = Color(0xff7BFF5A);
const mainJeJuBlue = Color(0xff2A4BD2);
const pointJeJuYellow = Color(0xffFFC839);
const green3 = Color(0xff6FCF97);

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  KRTextTheme get textTheme => (theme.extension<KRTextTheme>() ?? const KRTextTheme());

  ColorTheme get colorScheme => (theme.extension<ColorTheme>() ?? const ColorTheme());
}

@immutable
@CopyWith()
class ColorTheme extends ThemeExtension<ColorTheme> {
  const ColorTheme({
    this.primary = black,
    this.background = black,
    this.foreground = black,
    this.foregroundText = white,
    this.active = black,
    this.border = black,
    this.bottomNavigationBarSurface = black,
    this.activeButton = black,
    this.disableButton = black,
    this.activeTextColor = black,
    this.disableTextColor = black,
    this.primarySecond = white,
    this.titleText = black,
    this.guideBackground = black7,
    this.iconColor = black2,
    this.foregroundIcon = white,
    this.messageBackground = black6,
    this.sliderColor = mainJeJuBlue,
  });

  final Color primary;
  final Color background;
  final Color foreground;
  final Color foregroundText;
  final Color active;
  final Color border;
  final Color bottomNavigationBarSurface;
  final Color activeButton;
  final Color disableButton;
  final Color activeTextColor;
  final Color disableTextColor;
  final Color primarySecond;
  final Color titleText;
  final Color guideBackground;
  final Color iconColor;
  final Color foregroundIcon;
  final Color messageBackground;
  final Color sliderColor;

  @override
  ThemeExtension<ColorTheme> lerp(ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) {
      return this;
    }
    return ColorTheme(background: Color.lerp(background, other.background, t) ?? background);
  }

  @override
  ThemeExtension<ColorTheme> copyWith() => $ColorThemeCopyWith(this).copyWith();

  static const light = ColorTheme(
    primary: blue1,
    background: lightBackground,
    foreground: blue1,
    foregroundText: white,
    border: gray7,
    bottomNavigationBarSurface: lightSurfaceColor,
    active: blue1,
    activeButton: mainJeJuBlue,
    disableButton: Color(0xffDCE3E6),
    activeTextColor: white,
    disableTextColor: Color(0xff7B878D),
    primarySecond: secondColor,
    titleText: black,
    guideBackground: black7,
    iconColor: black2,
    foregroundIcon: white,
    messageBackground: black6,
    sliderColor: mainJeJuBlue,
  );

  static const dark = ColorTheme(
    primary: white,
    background: darkBackground,
    foreground: darkForeground,
    foregroundText: black2,
    titleText: white,
    border: black2,
    bottomNavigationBarSurface: darkSurfaceColor,
    active: white,
    activeButton: black2,
    disableButton: black,
    guideBackground: darkBackground,
    iconColor: white,
    foregroundIcon: black2,
    messageBackground: black3,
    sliderColor: white,
  );
}

@immutable
@CopyWith()
class KRTextTheme extends ThemeExtension<KRTextTheme> {
  const KRTextTheme({
    this.krPoint1 = const TextStyle(),
    this.krButton1 = const TextStyle(),
    this.krSubtitle1 = const TextStyle(),
    this.krBody1 = const TextStyle(),
    this.krBody2 = const TextStyle(),
    this.krBody3 = const TextStyle(),
    this.krBody4 = const TextStyle(),
    this.krBody5 = const TextStyle(),
    this.krSubtext1 = const TextStyle(),
    this.krSubtext2 = const TextStyle(),
    this.krBottom = const TextStyle(),
  });

  final TextStyle krPoint1;
  final TextStyle krButton1;
  final TextStyle krSubtitle1;
  final TextStyle krBody1;
  final TextStyle krBody2;
  final TextStyle krBody3;
  final TextStyle krBody4;
  final TextStyle krBody5;
  final TextStyle krSubtext1;
  final TextStyle krSubtext2;
  final TextStyle krBottom;

  @override
  ThemeExtension<KRTextTheme> copyWith() => $KRTextThemeCopyWith(this).copyWith();

  @override
  ThemeExtension<KRTextTheme> lerp(ThemeExtension<KRTextTheme>? other, double t) {
    if (other is! KRTextTheme) {
      return this;
    }
    return const KRTextTheme();
  }

  static const light = KRTextTheme(
    krPoint1: TextStyle(fontFamily: krFontFamily, fontSize: 24, fontWeight: FontWeight.w700, color: black1),
    krButton1: TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: black1),
    krSubtitle1: TextStyle(fontFamily: krFontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: black1),
    krBody1: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: black1),
    krBody2: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w700, color: black1),
    krBody3: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: black1),
    krBody4: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: black1),
    krBody5: TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: black1),
    krSubtext1: TextStyle(fontFamily: krFontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: black1),
    krSubtext2: TextStyle(fontFamily: krFontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: black1),
    krBottom: TextStyle(fontFamily: krFontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: black1),
  );

  static const dark = KRTextTheme(
    krPoint1: TextStyle(fontFamily: krFontFamily, fontSize: 24, fontWeight: FontWeight.w700, color: white),
    krButton1: TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: white),
    krSubtitle1: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: white),
    krBody1: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: white),
    krBody2: TextStyle(fontFamily: krFontFamily, fontSize: 14, fontWeight: FontWeight.w700, color: white),
    krBody3: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: white),
    krBody4: TextStyle(fontFamily: krFontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: white),
    krBody5: TextStyle(fontFamily: krFontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: white),
    krSubtext1: TextStyle(fontFamily: krFontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: white),
    krSubtext2: TextStyle(fontFamily: krFontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: white),
    krBottom: TextStyle(fontFamily: krFontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: white),
  );
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle _baseTextStyle = GoogleFonts.comfortaa();
TextStyle _headerTextStyle = GoogleFonts.architectsDaughter();

TextStyle _w400head = _headerTextStyle.copyWith(
  fontWeight: FontWeight.w400,
);

TextStyle _w600head = _headerTextStyle.copyWith(
  fontWeight: FontWeight.w600,
);

TextStyle _w400 = _baseTextStyle.copyWith(
  fontWeight: FontWeight.w300,
);

TextStyle _w500 = _baseTextStyle.copyWith(
  fontWeight: FontWeight.w600,
);
TextStyle _w600 = _baseTextStyle.copyWith(
  fontWeight: FontWeight.w600,
);

const double _letterSpacing = .5;
const double _bigLetterSpacing = 2.5;
const double _height130 = 1.3;
const double _height150 = 1.5;

@Deprecated('Use AppTextStyle class instead')
class AppTextTheme {
  static TextTheme appTextTheme = TextTheme(
    headline1: _w600head.copyWith(
      height: _height150,
      letterSpacing: _letterSpacing,
      fontSize: 16,
    ),
    headline2: _w400head.copyWith(
      height: _height150,
      letterSpacing: _letterSpacing,
      fontSize: 16,
    ),
    headline3: _w400.copyWith(
      fontSize: 24,
      height: _height130,
      letterSpacing: _letterSpacing,
    ),
    headline4: _w400.copyWith(
      fontSize: 20,
      height: _height150,
      letterSpacing: _letterSpacing,
    ),
    headline5: _w400.copyWith(
      fontSize: 18,
      height: _height150,
      letterSpacing: _letterSpacing,
    ),
    headline6: _w400.copyWith(
      fontSize: 16,
      height: _height150,
      letterSpacing: _letterSpacing,
    ),
    bodyText1: _w500.copyWith(
      fontSize: 14,
      height: _height150,
      letterSpacing: _letterSpacing,
    ),
    bodyText2: _w400.copyWith(
      fontSize: 14,
      height: _height150,
      letterSpacing: _letterSpacing,
    ),
    button: _w600.copyWith(
      fontSize: 16,
    ),
    subtitle1: _w400.copyWith(
      fontSize: 7,
      letterSpacing: _letterSpacing,
    ),
  );
}

extension CustomTextStyles on TextTheme {
  TextStyle get headline1Bold => Get.textTheme.headline1!.merge(_w600);

  TextStyle get headline2Bold => Get.textTheme.headline2!.merge(_w600);

  TextStyle get headline3Bold => Get.textTheme.headline3!.merge(_w600);

  TextStyle get headline4Bold => Get.textTheme.headline4!.merge(_w600);

  TextStyle get headline5Bold => Get.textTheme.headline5!.merge(_w600);

  TextStyle get headline6Bold => Get.textTheme.headline6!.merge(_w600);

  TextStyle get bodyText1Bold => Get.textTheme.bodyText1!.merge(_w600);

  TextStyle get bodyText2Bold => Get.textTheme.bodyText2!.merge(_w600);
}

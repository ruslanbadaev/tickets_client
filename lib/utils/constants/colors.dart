// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static final Color PRIMARY = _factoryColor(0xff333333);
  static final Color PRIMARY_DARK = _factoryColor(0xff222222);
  static final Color PRIMARY_LIGHT = _factoryColor(0xFF525252);
  static final Color SECONDARY = _factoryColor(0xFFE4E2F0);
  static final Color YELLOW = _factoryColor(0xffFFD700);
  static final Color BLUE = _factoryColor(0xFF4189DA);

  static final Color PURPLE = _factoryColor(0xffbaaafe);
  static final Color PINK = _factoryColor(0xfffdbbe4);
  static final Color ORANGE = _factoryColor(0xfff9bdb4);

  static const Color BLACK = Colors.black;

  static final MaterialColor LIGHT = _factoryColor(0xffffffff);

  static final MaterialColor LIGHT_GREY = _factoryColor(0xffc0c5d4);

  static final MaterialColor DARK = _factoryColor(0xff3a3a3a);

  static const MaterialColor RED = Colors.red;

  static final Color GOLD = Colors.yellow[700]!;

  static final MaterialColor WHITE = _factoryColor(0xffffffff);

  static final MaterialColor GREEN = _factoryColor(0xff349e40);

  static final MaterialColor LIGHT_GREEN = _factoryColor(0xff3AB54A);

  static final MaterialColor SHADOW = _factoryColor(0xffE7EAF0);

  static MaterialColor hex(String hex) => AppColors._factoryColor(AppColors._getColorHexFromStr(hex));

  static final LinearGradient PRIMARY_GRADIENT = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.BLUE,
      AppColors.PURPLE,
      AppColors.PINK,
      AppColors.ORANGE,
    ],
  );
  static LinearGradient getShuffledGradient() {
    List<Color> primaryColors = [
      AppColors.BLUE,
      AppColors.PURPLE,
      AppColors.PINK,
      AppColors.ORANGE,
    ];
    primaryColors.shuffle();
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
      colors: primaryColors,
    );
  }

  static MaterialColor _factoryColor(int color) {
    return MaterialColor(color, <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(color),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    });
  }

  static int _getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        val = 0xFFFFFFFF;
      }
    }
    return val;
  }
}

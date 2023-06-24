import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.WHITE,
    accentColor: AppColors.PRIMARY,
    iconTheme: IconThemeData(color: AppColors.PRIMARY),
    backgroundColor: AppColors.WHITE,
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.PRIMARY.withOpacity(.1),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.WHITE,
    ),
    cardColor: AppColors.WHITE,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.PRIMARY,
    accentColor: AppColors.WHITE,
    iconTheme: IconThemeData(color: AppColors.WHITE),
    backgroundColor: AppColors.PRIMARY_DARK,
    textTheme: AppTextTheme.appTextTheme,
    bottomAppBarColor: AppColors.PRIMARY,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.PRIMARY,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.PRIMARY,
    ),
    cardColor: AppColors.PRIMARY,
  );
}

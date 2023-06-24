import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

import 'constants/colors.dart';

class AppSnackbar {
  static void showDevelopmentSnackbar() {
    Get.snackbar(
      'We apologize',
      'The functionality is still under development',
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        FontAwesome5.dev,
      ),
      colorText: AppColors.DARK,
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      backgroundColor: AppColors.WHITE,
    );
  }
}

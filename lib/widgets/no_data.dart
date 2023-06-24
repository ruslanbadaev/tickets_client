import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tickets/utils/constants/strings.dart';

import '../utils/constants/animations.dart';
import '../utils/constants/colors.dart';

class NoDataWidget extends StatelessWidget {
  final double? height;
  final Function? onPressed;

  const NoDataWidget({
    Key? key,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        overlayColor: MaterialStateProperty.all(AppColors.DARK),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAnimations.cat1),
            Text(
              AppStrings.noData.tr,
              style: Get.textTheme.headline1!.copyWith(color: Get.theme.accentColor),
            ),
          ],
        ),
      ),
    );
  }
}

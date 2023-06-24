import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants/animations.dart';
import '../utils/constants/strings.dart';

class LoadingScreen extends StatelessWidget {
  final Function? onPressed;

  const LoadingScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAnimations.lama),
            Text(
              '${AppStrings.loading.tr}...',
              style: Get.textTheme.headline1!.copyWith(color: Get.theme.accentColor),
            ),
          ],
        ),
      ),
    );
  }
}

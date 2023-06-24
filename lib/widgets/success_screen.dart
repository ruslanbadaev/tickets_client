import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants/animations.dart';
import '../utils/constants/strings.dart';
import 'button.dart';
import 'custom_scaffold.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String body;
  final Function? onPressed;

  const SuccessScreen({
    Key? key,
    required this.title,
    required this.body,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppAnimations.catRock),
              Text(
                title,
                style: Get.textTheme.headline1!.copyWith(color: Get.theme.accentColor),
              ),
              Text(
                body,
                style: Get.textTheme.headline2!.copyWith(color: Get.theme.accentColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              ButtonWidget(
                title: AppStrings.close.tr,
                onPressed: () {
                  (onPressed ?? Get.back)();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

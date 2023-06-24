import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Color? color;
  final Color? background;
  final bool? boldFont;
  final Function onPressed;

  const ButtonWidget({
    super.key,
    this.title,
    this.titleWidget,
    this.color,
    this.background,
    this.boldFont,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: background ?? Get.theme.accentColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.PRIMARY_LIGHT.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: titleWidget ??
            Text(
              title ?? '',
              style: Get.textTheme.headline1!.copyWith(color: color ?? Get.theme.primaryColor),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}

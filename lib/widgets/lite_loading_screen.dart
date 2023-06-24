import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../utils/constants/strings.dart';

class LiteLoadingScreen extends StatelessWidget {
  final Function? onPressed;

  const LiteLoadingScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Get.theme.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitSpinningLines(
              size: 128,
              color: Get.theme.accentColor,
            ),
            const SizedBox(height: 36),
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

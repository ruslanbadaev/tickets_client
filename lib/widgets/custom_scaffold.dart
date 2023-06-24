import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  const CustomScaffold({
    Key? key,
    this.body,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Get.isDarkMode
              ? [
                  Get.theme.backgroundColor,
                  Get.theme.backgroundColor,
                  Get.theme.backgroundColor,
                ]
              : [
                  AppColors.WHITE.withOpacity(1),
                  AppColors.WHITE.withOpacity(.1),
                  AppColors.PINK.withOpacity(.01),
                ],
        ),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: appBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: body,
          backgroundColor: backgroundColor,
          bottomSheet: bottomSheet,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: NoScalingAnimation(),
        ),
      ),
    );
  }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({Offset? begin, Offset? end, double? progress}) {
    return end ?? const Offset(1, 1);
  }

  @override
  Animation<double> getRotationAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent ?? const AlwaysStoppedAnimation<double>(1));
  }

  @override
  Animation<double> getScaleAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent ?? const AlwaysStoppedAnimation<double>(1));
  }
}

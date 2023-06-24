import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import '../mixins/utils.dart';
import '../utils/constants/animations.dart';
import '../utils/constants/colors.dart';
import 'button.dart';

class NoInternetConnectionWidget extends StatefulWidget {
  final double? height;
  final Function? onPressed;
  const NoInternetConnectionWidget({
    Key? key,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  State<NoInternetConnectionWidget> createState() => _NoInternetConnectionWidgetState();
}

class _NoInternetConnectionWidgetState extends State<NoInternetConnectionWidget> with Utils {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {},
        overlayColor: MaterialStateProperty.all(AppColors.DARK),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SpinKitRipple(
                color: AppColors.DARK,
                size: 256.0,
              )
            else
              Lottie.asset(
                AppAnimations.catWalk,
                width: 256,
              ),
            const SizedBox(height: 24),
            Text(
              'No internet connection',
              style: GoogleFonts.architectsDaughter(
                textStyle: Get.theme.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Get.theme.accentColor,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
                title: 'Try again',
                onPressed: () {
                  checkInternetConnection();
                }),
            const SizedBox(height: 8),
            ButtonWidget(
                title: 'Close',
                onPressed: () {
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }

  void checkInternetConnection() async {
    startLoading();
    setState(() {});
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (hasConnection) {
      endLoading();
      Get.back();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    endLoading();
    setState(() {});
  }
}

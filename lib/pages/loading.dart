import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/session_controller.dart';
import '../utils/constants/colors.dart';
import '../widgets/custom_scaffold.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> with TickerProviderStateMixin {
  final SessionController sessionController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: double.infinity,
            color: AppColors.LIGHT_GREY,
            child: Image.network(
              '',
              color: Colors.white.withOpacity(1),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: const SpinKitRipple(
                    color: Colors.white,
                    size: 250.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

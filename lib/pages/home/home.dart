import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xl/xl.dart';

import '../../controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;
  int currSeconds = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                backgroundColor: AppColors.WHITE,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 72),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

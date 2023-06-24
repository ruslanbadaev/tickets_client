import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller.dart';
import '../../models/option.dart';
import '../../utils/constants/colors.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    Key? key,
  }) : super(key: key);

  @override
  GalleryScreenState createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> with TickerProviderStateMixin {
  final AppController appController = Get.find();
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;
  int currSeconds = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  List<Color> cardColors = [
    AppColors.BLUE,
    AppColors.ORANGE,
    AppColors.PINK,
    AppColors.PURPLE,
  ];

  OptionModel? _selectedOption;

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<GalleryScreenController>(
      init: GalleryScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                backgroundColor: AppColors.WHITE,
                body: SizedBox(),
              );
      },
    );
  }
}

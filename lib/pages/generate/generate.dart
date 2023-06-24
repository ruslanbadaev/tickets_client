import 'package:tickets/pages/ad/ad.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controller.dart';
import '../../models/pack.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class GenerateScreen extends StatefulWidget {
  final PackType type;
  const GenerateScreen({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  GenerateScreenState createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> with TickerProviderStateMixin {
  final AppController appController = Get.find();
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;

  static const AdRequest request = AdRequest(
      // keywords: <String>['foo', 'bar'],
      // contentUrl: 'http://foo.com/bar.html',
      // nonPersonalizedAds: true,
      );

  int maxFailedLoadAttempts = 3;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);
  }

  List<String> emojiImages = [
    AppImages.smiles,
    AppImages.smiles1,
    AppImages.smiles2,
    AppImages.smiles3,
    AppImages.smiles4,
    AppImages.smiles5,
    AppImages.smiles6,
  ];
  List<String> stickerImages = [
    AppImages.sticker,
    AppImages.sticker1,
    AppImages.sticker2,
    AppImages.sticker3,
    AppImages.sticker4,
    AppImages.sticker5,
    AppImages.sticker6,
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<GenerateScreenController>(
      init: GenerateScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                appBar: AppBar(
                  title: Text(
                    'Generate art',
                    style: context.textTheme.headline1!.copyWith(
                      color: Get.theme.accentColor,
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        Text(
                          '8',
                          style: context.textTheme.headline1!.copyWith(
                            color: Get.theme.accentColor,
                          ),
                        ),
                        Icon(
                          Icons.credit_score,
                          color: AppColors.GOLD,
                        ),
                      ],
                    ),
                  ],
                  backgroundColor: AppColors.WHITE,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: RotatedBox(
                      quarterTurns: 90,
                      child: Image.asset(AppImages.arrow2),
                    ),
                  ),
                ),
                backgroundColor: AppColors.WHITE,
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        maxLines: 10,
                        style: context.textTheme.headline2!.copyWith(
                          color: Get.theme.accentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ButtonWidget(
                      titleWidget: Row(
                        children: [
                          Text(
                            'Generate ( -1 GenCoin )',
                            style: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    ButtonWidget(
                      titleWidget: Row(
                        children: [
                          Text(
                            'Watch ad ( +1 GenCoin )',
                            style: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Get.to(AdScreen(type: PackType.art));
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}

import 'dart:io';

import 'package:tickets/widgets/button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controller.dart';
import '../../models/pack.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/ids.dart';
import '../../utils/constants/images.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class AdScreen extends StatefulWidget {
  final PackType type;
  const AdScreen({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  AdScreenState createState() => AdScreenState();
}

class AdScreenState extends State<AdScreen> with TickerProviderStateMixin {
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

    _createRewardedAd();
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

  bool _showRewardButton = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AdScreenController>(
      init: AdScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                // appBar: AppBar(
                //   title: Text(
                //     'Generate ${widget.type.name}',
                //     style: context.textTheme.headline1!.copyWith(
                //       color: Get.theme.accentColor,
                //     ),
                //   ),
                //   backgroundColor: AppColors.WHITE,
                //   leading: InkWell(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: RotatedBox(
                //       quarterTurns: 90,
                //       child: Image.asset(AppImages.arrow2),
                //     ),
                //   ),
                // ),
                backgroundColor: AppColors.WHITE,
                body: Column(
                  children: [
                    SizedBox(height: 64),
                    if (_showRewardButton)
                      ButtonWidget(
                        titleWidget: Row(
                          children: [
                            Text(
                              'Get reward +1 GenCoin',
                              style: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                  ],
                ),
              );
      },
    );
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid ? AppIds.adMobAppId : AppIds.adMobAppId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
            _showRewardedAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        _showRewardButton = true;
        setState(() {});
        // Get.back();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
    // Get.back();
  }
}

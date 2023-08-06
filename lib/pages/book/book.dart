import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickets/utils/theme/app_text_theme.dart';

import '../../models/concert.dart';
import '../../models/marker.dart';
import '../../utils/constants/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class BookScreen extends StatefulWidget {
  final ConcertModel selectedConcert;
  final List<MarkerModel> selectedMarkers;

  const BookScreen({
    Key? key,
    required this.selectedConcert,
    required this.selectedMarkers,
  }) : super(key: key);

  @override
  BookScreenState createState() => BookScreenState();
}

class BookScreenState extends State<BookScreen> with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;
  int currSeconds = 0;
  bool edition = false;

  double _currentPrice = 0;
  final List<MarkerModel> _selectedHereMarkers = [];

  BookScreenController controller = Get.put(BookScreenController());

  @override
  void initState() {
    edition = true;
    super.initState();
    _selectedHereMarkers.addAll(widget.selectedMarkers);

    animationController = AnimationController(vsync: this);
    calculatePrice();
  }

  double? tryParse(String price) {
    double? parsedPrice;
    log(price.replaceAll(RegExp(r'[^0-9\.]'), ''), name: 'replaced()()()');
    parsedPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9\.]'), ''));
    return parsedPrice;
  }

  void calculatePrice() async {
    _currentPrice = 0;
    for (MarkerModel? ticket in _selectedHereMarkers) {
      double? parsedPrice = double.tryParse(ticket!.price!);

      parsedPrice ??= tryParse(ticket.price!);

      _currentPrice = _currentPrice + (parsedPrice ?? 0);
      // _currentPrice = _currentPrice + (double.tryParse(ticket.price!) ?? 0);
      // await Future.delayed(const Duration(milliseconds: 50));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<BookScreenController>(
      init: BookScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : GestureDetector(
                child: CustomScaffold(
                  appBar: CustomAppBar(
                    titleString:
                        '${widget.selectedConcert.name} - ${widget.selectedConcert.createdAt} (${widget.selectedConcert.place})',
                  ),
                  // backgroundColor: AppColors.WHITE,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 24),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12,
                                      offset: const Offset(5, 7),
                                      color: AppColors.DARK.withOpacity(.1),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: 460,
                                    // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
                                    decoration: BoxDecoration(
                                      color: AppColors.LIGHT,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 32),
                                        Text(
                                          'Оплата',
                                          style: Get.textTheme.headline2Bold.copyWith(
                                            // color: _currentPrice == price ? price.color : AppColors.DARK,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        for (MarkerModel? ticket in widget.selectedMarkers)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${ticket?.name} - ',
                                                    style: Get.textTheme.bodyText1!.copyWith(),
                                                  ),
                                                  Text(
                                                    '${ticket?.price}',
                                                    style: Get.textTheme.bodyText1Bold.copyWith(
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                widget.selectedMarkers.last == ticket ? '=' : '+',
                                                style: Get.textTheme.bodyText1Bold.copyWith(
                                                  fontWeight: widget.selectedMarkers.last == ticket
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 24),
                                        Text(
                                          'К оплате: $_currentPrice',
                                          style: Get.textTheme.bodyText1!.copyWith(
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        SizedBox(height: 32),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 64,
                                            color: AppColors.DARK,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Оплатить PayPal',
                                                  style: Get.textTheme.bodyText1!.copyWith(color: AppColors.WHITE),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 72,
                                            color: AppColors.WHITE,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Оплатить перевом на карту',
                                                  style: Get.textTheme.bodyText1!.copyWith(
                                                    color: AppColors.DARK,
                                                    fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 128),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

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

  MarkerModel? _currentPrice;
  final List<MarkerModel> _selectedHereMarkers = [];

  BookScreenController controller = Get.put(BookScreenController());

  @override
  void initState() {
    edition = true;
    super.initState();
    _selectedHereMarkers.addAll(widget.selectedMarkers);
    animationController = AnimationController(vsync: this);
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
                          '${widget.selectedConcert.name} - ${widget.selectedConcert.createdAt} (${widget.selectedConcert.place})'),
                  backgroundColor: AppColors.WHITE,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),
                              for (MarkerModel? ticket in widget.selectedMarkers)
                                FadeInLeft(
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    // padding: EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    width: 280,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: AppColors.WHITE,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: _selectedHereMarkers.contains(ticket) ? 2 : 1,
                                        color: ticket?.color ?? AppColors.DARK,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            ticket?.name ?? '?',
                                            style: Get.textTheme.bodyText1Bold.copyWith(
                                              // color: _currentPrice == price ? price.color : AppColors.DARK,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'цена: (${ticket?.price ?? '?'})',
                                            style: Get.textTheme.bodyText1Bold.copyWith(
                                              // color: _currentPrice == price ? price.color : AppColors.DARK,
                                              fontWeight: _currentPrice?.name == ticket?.name
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            'ряд: ${((ticket?.x ?? 0) + 1)}',
                                            style: Get.textTheme.bodyText1Bold.copyWith(
                                              // color: _currentPrice == price ? price.color : AppColors.DARK,
                                              fontWeight: _currentPrice?.name == ticket?.name
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'место: ${((ticket?.y ?? 0) + 1)}',
                                            style: Get.textTheme.bodyText1Bold.copyWith(
                                              // color: _currentPrice == price ? price.color : AppColors.DARK,
                                              fontWeight: _currentPrice?.name == ticket?.name
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          if (_selectedHereMarkers.contains(ticket)) {
                                            _selectedHereMarkers.remove(ticket);
                                          } else {
                                            _selectedHereMarkers.add(ticket!);
                                          }

                                          setState(() {});
                                        },
                                        child: _selectedHereMarkers.contains(ticket)
                                            ? const Icon(
                                                Icons.delete_rounded,
                                                color: AppColors.RED,
                                              )
                                            : Icon(
                                                Icons.add_rounded,
                                                color: AppColors.GREEN,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.LIGHT,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 24),
                                Text(
                                  'место:',
                                  style: Get.textTheme.bodyText1Bold.copyWith(
                                    // color: _currentPrice == price ? price.color : AppColors.DARK,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
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

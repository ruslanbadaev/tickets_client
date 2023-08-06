import 'dart:developer';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickets/models/concert.dart';
import 'package:tickets/pages/book/book.dart';

import '../../models/marker.dart';
import '../../utils/constants/colors.dart';
import '../../utils/theme/app_text_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class CreationScreen extends StatefulWidget {
  final ConcertModel concert;
  // final String id;
  // final String name;
  // final String date;
  // final String place;
  // final int rows;
  // final int columns;

  const CreationScreen({
    Key? key,
    // required this.id,
    // required this.name,
    // required this.date,
    // required this.place,
    // required this.rows,
    // required this.columns,
    required this.concert,
  }) : super(key: key);

  @override
  CreationScreenState createState() => CreationScreenState();
}

class CreationScreenState extends State<CreationScreen> with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;
  int currSeconds = 0;
  bool edition = false;
  bool _showPlaces = false;

  MarkerModel? _currentPrice;
  final List<MarkerModel> _selectedMarkers = [];
  ScrollController _scrollController = ScrollController();
  CreationScreenController controller = Get.put(CreationScreenController());

  @override
  void initState() {
    edition = true;
    super.initState();
    initGrid();
    controller.getAllMarkersByConcertId(widget.concert.id);
    controller.getGridByConcertId(widget.concert.id);
    animationController = AnimationController(vsync: this);
  }

  void initGrid() {
    controller.generateGrid(widget.concert.grid?.length ?? 0, widget.concert.grid?[0].length ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<CreationScreenController>(
      init: CreationScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : GestureDetector(
                child: CustomScaffold(
                  appBar: CustomAppBar(
                      titleString: '${widget.concert.name} - ${widget.concert.createdAt} (${widget.concert.place})'),
                  backgroundColor: AppColors.WHITE,
                  body: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (MarkerModel price in controller.prices)
                                  if (price.type == PointType.object)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: FloatingActionButton.extended(
                                        backgroundColor: AppColors.LIGHT.withOpacity(1),
                                        onPressed: () {
                                          if (_currentPrice == price) {
                                            _currentPrice = null;
                                          } else {
                                            _currentPrice = price;
                                          }
                                          setState(() {});
                                        },
                                        label: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: price.color,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              price.name,
                                              style: Get.textTheme.bodyText1Bold.copyWith(
                                                color: AppColors.PRIMARY.withOpacity(1),
                                                fontWeight: _currentPrice == price ? FontWeight.w700 : FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: FloatingActionButton.extended(
                                        backgroundColor: AppColors.WHITE,
                                        onPressed: () {
                                          if (_currentPrice == price) {
                                            _currentPrice = null;
                                          } else {
                                            _currentPrice = price;
                                          }
                                          setState(() {});
                                        },
                                        label: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: price.color,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              price.price ?? '?',
                                              style: Get.textTheme.bodyText1Bold.copyWith(
                                                // color: _currentPrice == price ? price.color : AppColors.DARK,
                                                fontWeight: _currentPrice == price ? FontWeight.w700 : FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                            Container(
                              // width: 520,
                              // height: 520,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const SizedBox(height: 0),
                                    // for (List<MarkerModel?> x in controller.grid)

                                    for (var incrX = 0; incrX < controller.grid.length; incrX++)
                                      Column(
                                        children: [
                                          // for (MarkerModel? y in x)
                                          for (var incrY = 0; incrY < controller.grid[incrX].length; incrY++)
                                            if (_currentPrice == null)
                                              PlaceWidget(
                                                showPlace: _showPlaces,
                                                editing: edition && controller.selectedPrice != null,
                                                onHover: (marker) {
                                                  controller.hoverItem(marker);
                                                },
                                                onSelect: (marker) {
                                                  if (controller.grid[incrX][incrY].type == PointType.sit) {
                                                    if (_selectedMarkers.contains(controller.grid[incrX][incrY])) {
                                                      _selectedMarkers.remove(controller.grid[incrX][incrY]);
                                                    } else {
                                                      _selectedMarkers.add(controller.grid[incrX][incrY]);
                                                    }
                                                  } else if (controller.grid[incrX][incrY].type == PointType.sector) {
                                                    _selectedMarkers.add(controller.grid[incrX][incrY]);
                                                  }
                                                  setState(() {});
                                                  // log((marker?.row).toString());
                                                },
                                                currentMarker: controller.grid[incrX][incrY],
                                                marker: controller.selectedPrice,
                                                x: controller.grid[incrX][incrY].x ?? 0,
                                                y: controller.grid[incrX][incrY].y ?? 0,
                                                selected: _selectedMarkers.contains(controller.grid[incrX][incrY]),
                                                booked: false,
                                              )
                                            else
                                              PlaceWidget(
                                                showPlace: _showPlaces,
                                                editing: edition && controller.selectedPrice != null,
                                                onHover: (marker) {
                                                  controller.hoverItem(marker);
                                                },
                                                onSelect: (marker) {
                                                  // controller.setGridElement(se
                                                  //   incrX,
                                                  //   incrY,
                                                  //   marker,
                                                  // );
                                                  if (controller.grid[incrX][incrY].type == PointType.sit) {
                                                    if (_selectedMarkers.contains(controller.grid[incrX][incrY])) {
                                                      _selectedMarkers.remove(controller.grid[incrX][incrY]);
                                                    } else {
                                                      _selectedMarkers.add(controller.grid[incrX][incrY]);
                                                    }
                                                  } else if (controller.grid[incrX][incrY].type == PointType.sector) {
                                                    _selectedMarkers.add(controller.grid[incrX][incrY]);
                                                  }
                                                  setState(() {});
                                                },
                                                currentMarker: _currentPrice?.name != controller.grid[incrX][incrY].name
                                                    ? null
                                                    : controller.grid[incrX][incrY],
                                                marker: controller.selectedPrice,
                                                x: controller.grid[incrX][incrY].x ?? 0,
                                                y: controller.grid[incrX][incrY].y ?? 0,
                                                selected: _selectedMarkers.contains(controller.grid[incrX][incrY]),
                                                booked: false,
                                              )
                                        ],
                                      ),

                                    const SizedBox(height: 72),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 64),
                          ],
                        )),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 24),
                          FloatingActionButton.extended(
                            backgroundColor: AppColors.WHITE,
                            onPressed: () {
                              _showPlaces = !_showPlaces;
                              setState(() {});
                            },
                            label: Row(
                              children: [
                                Text(
                                  _showPlaces ? 'Скрыть места' : 'Показать места',
                                  style: Get.textTheme.bodyText1Bold.copyWith(
                                    color: AppColors.DARK,
                                    // color: _currentPrice == price ? price.color : AppColors.DARK,
                                    fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (_selectedMarkers.isNotEmpty)
                            FloatingActionButton.extended(
                              backgroundColor: AppColors.WHITE,
                              onPressed: () {
                                showRemoveDialog();
                              },
                              label: Row(
                                children: [
                                  Text(
                                    'Изменить',
                                    style: Get.textTheme.bodyText1Bold.copyWith(
                                      color: AppColors.DARK,
                                      fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(width: 12),
                          if (_selectedMarkers.isNotEmpty)
                            FloatingActionButton.extended(
                              onPressed: () {
                                Get.to(
                                  BookScreen(
                                    selectedConcert: widget.concert,
                                    selectedMarkers: _selectedMarkers,
                                  ),
                                );
                              },
                              label: Row(
                                children: [
                                  Text(
                                    'Забронировать (${_selectedMarkers.length})',
                                    style: Get.textTheme.bodyText1Bold.copyWith(
                                      color: AppColors.WHITE,
                                      // color: _currentPrice == price ? price.color : AppColors.DARK,
                                      fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void showRemoveDialog() {
    Get.defaultDialog(
      title: 'Билеты в корзине',
      content: Column(
        children: [
          for (MarkerModel? ticket in _selectedMarkers)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        ticket?.name ?? '?',
                        style: Get.textTheme.bodyText1Bold.copyWith(
                          color: AppColors.DARK,
                          fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'x:${(ticket?.x ?? 0) + 1}  ',
                        style: Get.textTheme.bodyText1Bold.copyWith(
                          color: AppColors.DARK.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'y:${(ticket?.y ?? 0) + 1}  ',
                        style: Get.textTheme.bodyText1Bold.copyWith(
                          color: AppColors.DARK.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ' (${ticket?.price ?? '?'}) ',
                        style: Get.textTheme.bodyText1Bold.copyWith(
                          color: AppColors.DARK,
                          fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          _selectedMarkers.remove(ticket);
                          setState(() {});
                          Get.back();
                          if (_selectedMarkers.isNotEmpty) {
                            showRemoveDialog();
                          }
                        },
                        child: const Icon(
                          Icons.delete_rounded,
                          color: AppColors.RED,
                        ),
                      ),
                    ],
                  ),
                  if (_selectedMarkers.last != ticket) const Divider(),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class PlaceWidget extends StatefulWidget {
  final Function(MarkerModel?) onHover;
  final Function(MarkerModel?) onSelect;
  final MarkerModel? marker;
  final MarkerModel? currentMarker;
  final bool editing;
  final int x;
  final int y;
  final bool selected;
  final bool booked;
  final bool showPlace;

  const PlaceWidget({
    required this.editing,
    required this.onHover,
    required this.onSelect,
    required this.x,
    required this.y,
    required this.selected,
    required this.booked,
    required this.showPlace,
    this.marker,
    this.currentMarker,
    Key? key,
  }) : super(key: key);
  @override
  State<PlaceWidget> createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log(widget.currentMarker?.name ?? '??', name: 'widget.currentMarker before');
        if (widget.currentMarker == null) {
          //!
        } else {
          log(widget.currentMarker?.name ?? '??', name: 'widget.currentMarker');
          widget.onSelect(widget.currentMarker);
          setState(() {});
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: Stack(
          children: [
            Container(
              height: 25,
              width: 25,
              // margin: EdgeInsets.all(0),
              child: (widget.showPlace)
                  ? Container(
                      decoration: BoxDecoration(
                        // color: widget.currentMarker?.color ?? Colors.grey,

                        border: Border.all(
                          width: widget.selected ? 2 : .5,
                          color: widget.currentMarker?.color ?? Colors.grey,
                        ),

                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'x:${(widget.currentMarker?.x ?? 0) + 1}',
                            style: Get.textTheme.bodyText1Bold.copyWith(
                              color: AppColors.DARK,
                              fontWeight: FontWeight.w300,
                              fontSize: 6,
                            ),
                          ),
                          Text(
                            'y:${(widget.currentMarker?.y ?? 0) + 1}',
                            style: Get.textTheme.bodyText1Bold.copyWith(
                              color: AppColors.DARK,
                              fontWeight: FontWeight.w300,
                              fontSize: 6,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.currentMarker?.type == null)
                          Container(
                            alignment: Alignment.center,
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              color: widget.currentMarker?.color ?? Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        else
                          widget.currentMarker?.type == PointType.sit
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: widget.currentMarker?.color ?? Colors.grey,
                                    borderRadius: BorderRadius.circular(100),
                                    border: widget.selected ? Border.all(width: 2) : null,
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: widget.currentMarker?.color ?? Colors.grey,
                                    // borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

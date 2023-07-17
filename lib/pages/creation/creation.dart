import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/utils.dart';
import '../../models/marker.dart';
import '../../utils/constants/colors.dart';
import '../../utils/theme/app_text_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class CreationScreen extends StatefulWidget {
  final String id;
  final String name;
  final String date;
  final String place;
  final int rows;
  final int columns;

  const CreationScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.date,
    required this.place,
    required this.rows,
    required this.columns,
  }) : super(key: key);

  @override
  CreationScreenState createState() => CreationScreenState();
}

class CreationScreenState extends State<CreationScreen> with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  AnimationController? animationController;
  int currSeconds = 0;
  bool edition = false;

  MarkerModel? _currentPrice;
  final List<MarkerModel> _selectedMarkers = [];

  CreationScreenController controller = Get.put(CreationScreenController());

  @override
  void initState() {
    edition = true;
    super.initState();
    initGrid();
    controller.getAllMarkersByConcertId(widget.id);
    controller.getGridByConcertId(widget.id);
    animationController = AnimationController(vsync: this);
  }

  void initGrid() {
    controller.generateGrid(widget.rows, widget.columns);
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
                // onLongPressStart: (_) {
                //   log('llklklkl1');
                //   setState(() {
                //     edition = true;
                //   });
                // },
                // onLongPressEnd: (_) {
                //   setState(() {
                //     edition = false;
                //   });
                // },
                child: CustomScaffold(
                  appBar: CustomAppBar(titleString: '${widget.name} - ${widget.date} (${widget.place})'),
                  backgroundColor: AppColors.WHITE,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_selectedMarkers.isNotEmpty)
                            FadeInLeft(
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                // height: 200,
                                // width: 200,
                                // color: AppColors.GREEN,
                                child: Column(
                                  children: [
                                    for (MarkerModel? ticket in _selectedMarkers)
                                      FadeInLeft(
                                        duration: const Duration(milliseconds: 300),
                                        child: Container(
                                          width: 140,
                                          height: 48,
                                          child: Row(
                                            children: [
                                              Text(
                                                ticket?.name ?? '?',
                                                style: Get.textTheme.bodyText1Bold.copyWith(
                                                  // color: _currentPrice == price ? price.color : AppColors.DARK,
                                                  fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '(${ticket?.price ?? '?'})',
                                                style: Get.textTheme.bodyText1Bold.copyWith(
                                                  // color: _currentPrice == price ? price.color : AppColors.DARK,
                                                  fontWeight: _currentPrice == null ? FontWeight.w700 : FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),
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
                                                  color: AppColors.LIGHT_GREY.withOpacity(1),
                                                  fontWeight:
                                                      _currentPrice == price ? FontWeight.w700 : FontWeight.w400,
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
                                                  fontWeight:
                                                      _currentPrice == price ? FontWeight.w700 : FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                ],
                              ),
                              const SizedBox(height: 36),
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
                                                  editing: edition && controller.selectedPrice != null,
                                                  onHover: (marker) {
                                                    controller.hoverItem(marker);
                                                  },
                                                  onSelect: (marker) {
                                                    if (_selectedMarkers.contains(controller.grid[incrX][incrY])) {
                                                      _selectedMarkers.remove(controller.grid[incrX][incrY]);
                                                    } else {
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
                                                  editing: edition && controller.selectedPrice != null,
                                                  onHover: (marker) {
                                                    controller.hoverItem(marker);
                                                  },
                                                  onSelect: (marker) {
                                                    // controller.setGridElement(
                                                    //   incrX,
                                                    //   incrY,
                                                    //   marker,
                                                    // );

                                                    if (_selectedMarkers.contains(controller.grid[incrX][incrY])) {
                                                      _selectedMarkers.remove(controller.grid[incrX][incrY]);
                                                    } else {
                                                      _selectedMarkers.add(controller.grid[incrX][incrY]);
                                                    }
                                                    setState(() {});
                                                  },
                                                  currentMarker:
                                                      _currentPrice?.name != controller.grid[incrX][incrY].name
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
                              const SizedBox(height: 12),
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

  const PlaceWidget({
    required this.editing,
    required this.onHover,
    required this.onSelect,
    required this.x,
    required this.y,
    required this.selected,
    required this.booked,
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
              child: Row(
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

class PlaceWidgetController extends GetxController with Utils {}

// class _PlaceWidgetState extends State<PlaceWidget> {
//   MarkerModel? currentMarker;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: MouseRegion(
//         onEnter: (event) {
//           if (widget.editing) {
//             setState(() {
//               currentMarker = widget.marker;
//             });
//           } else {
//             widget.onHover(currentMarker);
//           }
//         },
//         onHover: (event) {},
//         cursor: SystemMouseCursors.grab,
//         child: widget.editing
//             ? SizedBox(
//                 height: 25,
//                 width: 25,
//                 // margin: EdgeInsets.all(0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (currentMarker == null)
//                       Container(
//                         alignment: Alignment.center,
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       )
//                     else
//                       Container(
//                         alignment: Alignment.center,
//                         height: 15,
//                         width: 15,
//                         decoration: BoxDecoration(
//                           color: currentMarker?.color ?? Colors.grey,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                       ),
//                   ],
//                 ),
//               )
//             : SizedBox(
//                 height: 25,
//                 width: 25,
//                 // margin: EdgeInsets.all(0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (currentMarker == null)
//                       Container(
//                         alignment: Alignment.center,
//                         height: 7,
//                         width: 7,
//                         decoration: BoxDecoration(
//                           color: currentMarker?.color ?? Colors.grey,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                       )
//                     else
//                       currentMarker?.type == PointType.sit
//                           ? Container(
//                               alignment: Alignment.center,
//                               height: 15,
//                               width: 15,
//                               decoration: BoxDecoration(
//                                 color: currentMarker?.color ?? Colors.grey,
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                             )
//                           : Container(
//                               alignment: Alignment.center,
//                               height: 25,
//                               width: 25,
//                               decoration: BoxDecoration(
//                                 color: currentMarker?.color ?? Colors.grey,
//                                 // borderRadius: BorderRadius.circular(100),
//                               ),
//                             ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

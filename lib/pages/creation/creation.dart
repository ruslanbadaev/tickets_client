import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/utils.dart';
import '../../models/marker.dart';
import '../../utils/constants/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';
import 'widgets/creation_dialog.dart';
import 'widgets/price_card.dart';

class CreationScreen extends StatefulWidget {
  final String name;
  final String date;
  final String place;
  final int rows;
  final int columns;

  const CreationScreen({
    Key? key,
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

  CreationScreenController controller = Get.put(CreationScreenController());

  @override
  void initState() {
    edition = false;
    super.initState();
    initGrid();

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
                onLongPressStart: (_) {
                  log('llklklkl1');
                  setState(() {
                    edition = true;
                  });
                },
                onLongPressEnd: (_) {
                  setState(() {
                    edition = false;
                  });
                },
                child: CustomScaffold(
                  appBar: CustomAppBar(titleString: '${widget.name} - ${widget.date} (${widget.place})'),
                  backgroundColor: AppColors.WHITE,
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 24),
                                Text(
                                  'Цены:',
                                  style: Get.textTheme.bodyText1,
                                ),
                                const SizedBox(height: 16),
                                Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '  Cоздать метку:',
                                              style: Get.textTheme.bodyText2,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 36),
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                              title: '  Создание метки  ',
                                              titleStyle: Get.textTheme.bodyText1,
                                              content: const CreationDialogWidget(),
                                            );
                                          },
                                          child: const Card(
                                            color: Colors.greenAccent,
                                            child: SizedBox(
                                              height: 48,
                                              width: 48,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                for (MarkerModel price in controller.prices)
                                  PriceCardWidget(
                                    price: price,
                                    selectedPrice: controller.selectedPrice,
                                    selectPrice: (price) => controller.selectPrice(price),
                                    onDeletePrice: (price) => controller.removePrice(price),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 24),
                      Column(
                        children: [
                          SizedBox(height: 24),
                          Card(
                            child: Container(
                              width: 220,
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              // color: AppColors.LIGHT_GREY,
                              child: Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text(controller.selectedPrice.toString(), style: Get.textTheme.bodyText1),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text('id:', style: Get.textTheme.bodyText1),
                                      Text(controller.hoveredPrice?.id ?? '---', style: Get.textTheme.bodyText2),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Имя:', style: Get.textTheme.bodyText1),
                                      Text(controller.hoveredPrice?.name ?? '---', style: Get.textTheme.bodyText2),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Цена:', style: Get.textTheme.bodyText1),
                                      Text(controller.hoveredPrice?.price ?? '---', style: Get.textTheme.bodyText2),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('X: ', style: Get.textTheme.bodyText1),
                                      Text(
                                        controller.hoveredPrice?.row.toString() ?? '---',
                                        style: Get.textTheme.bodyText2,
                                      ),
                                      Text('  Y:', style: Get.textTheme.bodyText1),
                                      Text(
                                        controller.hoveredPrice?.column.toString() ?? '---',
                                        style: Get.textTheme.bodyText2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SingleChildScrollView(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 0),
                                    // for (List<MarkerModel?> x in controller.grid)
                                    for (var incrX = 0; incrX < controller.grid.length; incrX++)
                                      Row(
                                        children: [
                                          // for (MarkerModel? y in x)
                                          for (var incrY = 0; incrY < controller.grid[incrX].length; incrY++)
                                            PlaceWidget(
                                              editing: edition && controller.selectedPrice != null,
                                              onHover: (marker) {
                                                controller.hoverItem(marker);
                                              },
                                              onSelect: (marker) {
                                                controller.setGridElement(
                                                  incrX,
                                                  incrY,
                                                  marker,
                                                );

                                                // log((marker?.row).toString());
                                              },
                                              currentMarker: controller.grid[incrX][incrY],
                                              marker: controller.selectedPrice,
                                              x: controller.grid[incrX][incrY]?.row ?? 0,
                                              y: controller.grid[incrX][incrY]?.column ?? 0,
                                            ),
                                        ],
                                      ),
                                    const SizedBox(height: 72),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
  const PlaceWidget({
    required this.editing,
    required this.onHover,
    required this.onSelect,
    required this.x,
    required this.y,
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
        if (widget.marker == null) {
          Get.snackbar('Внимание', 'Создай метку слева');
        } else {
          widget.onSelect(widget.marker);
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          if (widget.editing) {
            if (widget.marker == null) {
              Get.snackbar('Внимание', 'Создай метку слева');
            } else {
              widget.onSelect(widget.marker);
            }
            // setState(() {
            //   currentMarker = widget.marker;
            // });
          } else {
            widget.onHover(widget.currentMarker);
          }
        },
        // onHover: (event) {

        //   widget.onHover(widget.marker);
        // },
        cursor: SystemMouseCursors.grab,
        child: widget.editing
            ? SizedBox(
                height: 25,
                width: 25,
                // margin: EdgeInsets.all(0),
                child: Stack(
                  alignment: Alignment.center,
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
                      Container(
                        alignment: Alignment.center,
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: widget.currentMarker?.color ?? Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: AppColors.DARK,
                    //     width: 2,
                    //   ),
                    // ),
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

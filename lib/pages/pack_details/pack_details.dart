import 'dart:convert';
import 'dart:math';

import 'package:tickets/models/pack.dart';
import 'package:tickets/pages/image_editor/image_editor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xl/xl.dart';

import '../../controller.dart';
import '../../models/option.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class PackDetailsScreen extends StatefulWidget {
  final PackModel pack;
  const PackDetailsScreen({
    Key? key,
    required this.pack,
  }) : super(key: key);

  @override
  PackDetailsScreenState createState() => PackDetailsScreenState();
}

class PackDetailsScreenState extends State<PackDetailsScreen> with TickerProviderStateMixin {
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

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<PackDetailsScreenController>(
      init: PackDetailsScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                appBar: AppBar(
                  title: Text(
                    widget.pack.description,
                    style: context.textTheme.headline1!.copyWith(
                      color: Get.theme.accentColor,
                    ),
                  ),
                  backgroundColor: AppColors.WHITE,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Image.asset(AppImages.arrow),
                    ),
                  ),
                ),
                backgroundColor: AppColors.WHITE,
                body: XL(
                  sharesPointer: true,
                  sharesSensors: true,
                  layers: [
                    XLayer(
                      xRotation: .1,
                      yRotation: .1,
                      xOffset: 20,
                      yOffset: 20,
                      child: Container(
                        // height: screenHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12),

                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              AppImages.back3,
                            ),
                            opacity: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GridView.custom(
                          gridDelegate: SliverWovenGridDelegate.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            pattern: [
                              const WovenGridTile(1),
                              const WovenGridTile(1),
                              // const WovenGridTile(
                              //   5 / 7,
                              //   crossAxisRatio: 0.9,
                              //   alignment: AlignmentDirectional.centerEnd,
                              // ),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            childCount: widget.pack.pictures.length,
                            (context, index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.WHITE,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ImageEditorScreen(pack: widget.pack, currentIndex: index));
                                },
                                child: XL(
                                  sharesPointer: true,
                                  sharesSensors: true,
                                  layers: [
                                    XLayer(
                                      xRotation: .5,
                                      yRotation: .5,
                                      xOffset: 20,
                                      yOffset: 20,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(

                                            // top: (index == 0 || index == 1) ? 24 : 8,
                                            // bottom: (index == widget.pack.pictures.length ||
                                            //         index == widget.pack.pictures.length - 1)
                                            //     ? 24
                                            //     : 8
                                            ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            decoration: BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                blurRadius: 12,
                                                offset: const Offset(5, 7),
                                                color: AppColors.DARK.withOpacity(.4),
                                              ),
                                            ]),
                                            child: Image.memory(
                                              base64.decode(
                                                widget.pack.pictures[index].replaceAll(RegExp(r'\s+'), ''),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

// floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// floatingActionButton: Container(
//   width: double.infinity,
//   height: 56,
//   margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
//   decoration: BoxDecoration(
//     color: AppColors.DARK,
//     borderRadius: BorderRadius.circular(16),
//   ),
//   child: Center(
//     child: Text(
//       'Generate',
//       style: Get.textTheme.bodyText2!.copyWith(
//         color: AppColors.WHITE,
//       ),
//     ),
//   ),
// ),
// CarouselSlider(
//   options: CarouselOptions(
//     onPageChanged: (index, reason) {
//       _selectedOption = options[index];
//       // options[index].helpers.first.examples.shuffle();
//       setState(() {});
//     },
//     viewportFraction: .8,
//   ),
//   items: options.map((option) {
//     return Builder(
//       builder: (BuildContext context) {
//         return Container(
//           width: screenWidth,
//           margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
//           decoration: BoxDecoration(
//             color: AppColors.WHITE,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 12,
//                 offset: const Offset(5, 7),
//                 color: AppColors.DARK.withOpacity(.1),
//               ),
//             ],
//             borderRadius: BorderRadius.circular(
//               24,
//             ),
//           ),
//           child: Center(
//             child: Text(
//               'Generate ${option.name}',
//               style: Get.textTheme.headline1!.copyWith(),
//             ),
//           ),
//         );
//       },
//     );
//   }).toList(),
// ),
// for (HelperModel helper in _selectedOption?.helpers ?? [])
//   /*    FadeInDown(
//     controller: (controller) => animationController = controller,
//     child: */
//   Container(
//     decoration: BoxDecoration(
//       color: Colors.pink[50],
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 12,
//           offset: const Offset(5, 7),
//           color: AppColors.DARK.withOpacity(.1),
//         ),
//       ],
//       borderRadius: BorderRadius.circular(
//         24,
//       ),
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 24),
//     margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//     child: Column(
//       children: [
//         const SizedBox(height: 24),
//         Text(
//           helper.title,
//           style: Get.textTheme.bodyText1!.copyWith(
//             color: AppColors.DARK,
//           ),
//         ),
//         const SizedBox(height: 12),
//         TextField(
//           style: Get.textTheme.bodyText2!.copyWith(
//             color: AppColors.DARK,
//           ),
//           decoration: InputDecoration(
//             hintText: helper.examples.first,
//             hintMaxLines: 3,
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     ),
//   ),
// ),

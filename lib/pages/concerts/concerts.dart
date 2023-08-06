import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickets/utils/formatters/date_formatter.dart';
import 'package:tickets/utils/theme/app_text_theme.dart';

import '../../mixins/utils.dart';
import '../../models/concert.dart';
import '../../utils/constants/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import '../creation/creation.dart';
import 'controller.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConcertsScreenState createState() => ConcertsScreenState();
}

class ConcertsScreenState extends State<ConcertsScreen> with TickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    dateController = TextEditingController(text: DateTime.now().toString());
// _scrollController
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ConcertsScreenController>(
      init: ConcertsScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                appBar: const CustomAppBar(
                  titleString: 'Концерты',
                  isShowBack: false,
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: screenWidth,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (ConcertModel concert in controller.allConcerts)
                          Container(
                            margin: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12,
                                  offset: const Offset(5, 7),
                                  color: AppColors.DARK.withOpacity(.1),
                                ),
                              ],
                            ),
                            width: 420,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.WHITE,
                                ),
                                width: 420,
                                child: Column(
                                  children: [
                                    SizedBox(height: 24),
                                    Text(
                                      concert.name,
                                      style: Get.textTheme.bodyText1Bold,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      DateFormatter.formattedDateTime(concert.createdAt!, pattern: 'dd.MM.yyyy hh:mm'),
                                      style: Get.textTheme.bodyText1,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      concert.place.toString(),
                                      style: Get.textTheme.bodyText1Bold,
                                    ),
                                    SizedBox(height: 24),
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          CreationScreen(
                                            concert: concert,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: AppColors.DARK,
                                        width: screenWidth,
                                        height: 56,
                                        child: Center(
                                          child: Text(
                                            'Купить',
                                            style: Get.textTheme.bodyText1Bold.copyWith(color: AppColors.WHITE),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // AdaptiveScrollbar(
                //   width: 200,
                //   controller: _scrollController,
                //   child: SingleChildScrollView(
                //     controller: _scrollController,
                //     scrollDirection: Axis.horizontal,
                //     child: Container(
                //       width: screenWidth,
                //       height: screenHeight,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const SizedBox(height: 24),
                //               SizedBox(
                //                 width: screenWidth,
                //                 child: Container(
                //                   padding: const EdgeInsets.symmetric(horizontal: 18),
                //                   alignment: Alignment.center,
                //                   height: 64,
                //                   width: 940,
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       SizedBox(
                //                         width: 260,
                //                         child: Text(
                //                           'Название',
                //                           style: Get.textTheme.bodyText1Bold,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         width: 250,
                //                         child: Text(
                //                           'Дата/Время',
                //                           style: Get.textTheme.bodyText1Bold,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         width: 260,
                //                         child: Text(
                //                           'Место',
                //                           style: Get.textTheme.bodyText1Bold,
                //                         ),
                //                       ),
                //                       // SizedBox(
                //                       //   width: 90,
                //                       //   child: Text(
                //                       //     'Время',
                //                       //     style: Get.textTheme.bodyText1Bold,
                //                       //   ),
                //                       // ),
                //                       SizedBox(width: 123),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               for (ConcertModel concert in controller.allConcerts)
                //                 SizedBox(
                //                   width: screenWidth,
                //                   child: Wrap(
                //                     children: [
                //                       InkWell(
                //                         onTap: () {
                //                           Get.to(
                //                             CreationScreen(
                //                               concert: concert,
                //                               // id: concert.id,
                //                               // name: concert.name,
                //                               // date: concert.createdAt.toString(),
                //                               // place: concert.place,
                //                               // rows: int.tryParse(concert.row ?? '') ?? 10,
                //                               // columns: int.tryParse(concert.column ?? '') ?? 10,
                //                             ),
                //                           );
                //                         },
                //                         child: Card(
                //                           margin: const EdgeInsets.symmetric(vertical: 6),
                //                           color: AppColors.WHITE,
                //                           child: Container(
                //                             padding: const EdgeInsets.symmetric(horizontal: 18),
                //                             alignment: Alignment.center,
                //                             height: 96,
                //                             width: 940,
                //                             child: Row(
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 SizedBox(
                //                                   width: 260,
                //                                   child: Text(
                //                                     concert.name,
                //                                     style: Get.textTheme.bodyText1Bold,
                //                                   ),
                //                                 ),
                //                                 SizedBox(
                //                                   width: 250,
                //                                   child: Text(
                //                                     DateFormatter.formattedDateTime(concert.createdAt!,
                //                                         pattern: 'dd.MM.yyyy hh:mm'),
                //                                     style: Get.textTheme.bodyText1,
                //                                   ),
                //                                 ),
                //                                 SizedBox(
                //                                   width: 260,
                //                                   child: Text(
                //                                     concert.place.toString(),
                //                                     style: Get.textTheme.bodyText1Bold,
                //                                   ),
                //                                 ),
                //                                 // SizedBox(
                //                                 //   width: 90,
                //                                 //   child: Text(
                //                                 //     DateFormatter.formattedDateTime(concert.createdAt!, pattern: 'hh:mm'),
                //                                 //     style: Get.textTheme.bodyText1Bold,
                //                                 //   ),
                //                                 // ),
                //                                 Card(
                //                                   color: AppColors.DARK,
                //                                   child: SizedBox(
                //                                     width: 120,
                //                                     height: 48,
                //                                     child: Center(
                //                                       child: Text(
                //                                         'Купить',
                //                                         style: Get.textTheme.bodyText2Bold.copyWith(
                //                                           color: AppColors.WHITE,
                //                                         ),
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              );
      },
    );
  }
}

class PlaceWidgetController extends GetxController with Utils {}

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

  @override
  void initState() {
    dateController = TextEditingController(text: DateTime.now().toString());

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
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
                          height: 64,
                          width: 800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  'Название',
                                  style: Get.textTheme.bodyText1Bold,
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  'Дата',
                                  style: Get.textTheme.bodyText1Bold,
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  'Место',
                                  style: Get.textTheme.bodyText1Bold,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  'Время',
                                  style: Get.textTheme.bodyText1Bold,
                                ),
                              ),
                              SizedBox(width: 128),
                            ],
                          ),
                        ),
                        for (ConcertModel concert in controller.allConcerts)
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    CreationScreen(
                                      name: concert.name,
                                      date: concert.createdAt.toString(),
                                      place: concert.place,
                                      rows: int.tryParse(concert.row ?? '') ?? 10,
                                      columns: int.tryParse(concert.column ?? '') ?? 10,
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  color: AppColors.WHITE,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.center,
                                    height: 64,
                                    width: 800,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            concert.name,
                                            style: Get.textTheme.bodyText1Bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            DateFormatter.formattedDateTime(concert.createdAt!, pattern: 'dd.MM.yyyy'),
                                            style: Get.textTheme.bodyText1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            concert.place.toString(),
                                            style: Get.textTheme.bodyText1Bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 90,
                                          child: Text(
                                            DateFormatter.formattedDateTime(concert.createdAt!, pattern: 'hh:mm'),
                                            style: Get.textTheme.bodyText1Bold,
                                          ),
                                        ),
                                        Card(
                                          color: AppColors.LIGHT_GREEN,
                                          child: SizedBox(
                                            width: 120,
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                'Купить',
                                                style: Get.textTheme.bodyText2Bold.copyWith(
                                                  color: AppColors.WHITE,
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
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class PlaceWidgetController extends GetxController with Utils {}

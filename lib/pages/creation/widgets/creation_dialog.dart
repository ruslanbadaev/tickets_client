import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../models/marker.dart';
import '../../../models/price.dart';
import '../controller.dart';

class CreationDialogWidget extends StatefulWidget {
  const CreationDialogWidget({super.key});

  @override
  State<CreationDialogWidget> createState() => _CreationDialogWidgetState();
}

class _CreationDialogWidgetState extends State<CreationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreationScreenController>(
      init: CreationScreenController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: TextField(
                controller: controller.nameController,
                style: Get.textTheme.bodyText2,
                decoration: const InputDecoration(
                  labelText: 'Название:',
                ),
                onChanged: (_) {
                  controller.update();
                },
              ),
            ),
            if (controller.nameController.text.isNotEmpty)
              FadeInDown(
                child: Column(
                  children: [
                    const SizedBox(height: 21),
                    Text(
                      'Тип:',
                      style: Get.textTheme.bodyText2,
                    ),
                    const SizedBox(height: 21),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectPointType(PointType.sit);
                          },
                          child: Card(
                            color: Colors.blueAccent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                children: [
                                  Text(
                                    'Сидячий билет',
                                    style: Get.textTheme.bodyText2!.copyWith(
                                      fontWeight:
                                          controller.pointType == PointType.sit ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectPointType(PointType.sector);
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                children: [
                                  Text(
                                    'Секторальный',
                                    style: Get.textTheme.bodyText2!.copyWith(
                                      fontWeight:
                                          controller.pointType == PointType.sector ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        controller.selectPointType(PointType.object);
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Сцена или другой объект',
                                style: Get.textTheme.bodyText2!.copyWith(
                                  fontWeight:
                                      controller.pointType == PointType.sector ? FontWeight.w700 : FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.pointType != null && controller.pointType != PointType.object)
              FadeInDown(
                child: TextField(
                  controller: controller.priceController,
                  style: Get.textTheme.bodyText2,
                  decoration: const InputDecoration(
                    labelText: 'Цена:',
                  ),
                  onChanged: (_) {
                    controller.update();
                  },
                ),
              ),
            if (controller.priceController.text.isNotEmpty || controller.pointType == PointType.object)
              FadeInDown(
                child: MaterialPicker(
                  pickerColor: Colors.red,
                  onColorChanged: (color) {
                    var rng = Random();
                    controller.createPrice(
                      MarkerModel(
                        id: (rng.nextInt(100)).toString(),
                        name: controller.nameController.text,
                        price: controller.priceController.text,
                        type: controller.pointType!,
                        color: color,
                      ),
                    );
                    Get.back();
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

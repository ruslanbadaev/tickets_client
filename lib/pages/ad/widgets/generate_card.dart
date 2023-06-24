import 'package:tickets/pages/generate/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xl/xl.dart';

import '../../../utils/constants/colors.dart';

class GenerateCardWidget extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final Function onPressed;
  const GenerateCardWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GenerateScreenController appController = Get.find();
    return Container(
      width: width,
      height: 600,
      child: XL(
        sharesPointer: true,
        sharesSensors: true,
        layers: [
          XLayer(
            xRotation: .5,
            yRotation: 1,
            xOffset: 20,
            yOffset: 20,
            child: InkWell(
              onTap: () {
                onPressed();
              },
              child: Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    width: width,
                    height: 600,
                    decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: const Offset(5, 7),
                          color: AppColors.DARK.withOpacity(.4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 48),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Description:',
                            style: TextStyle(
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: appController.descriptionController,
                            style: const TextStyle(
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'add a description in English here',
                            ),
                            maxLength: 128,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Style:',
                            style: TextStyle(
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: appController.styleController,
                            style: const TextStyle(
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'add a style in English here',
                            ),
                            maxLength: 64,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

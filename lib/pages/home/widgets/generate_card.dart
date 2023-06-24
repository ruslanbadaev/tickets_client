import 'package:flutter/material.dart';
import 'package:xl/xl.dart';

import '../../../utils/constants/colors.dart';

class GenerateCardWidget extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final String imagePath;
  final Function onPressed;
  const GenerateCardWidget({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 312,
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
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    width: width,
                    height: 312,
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

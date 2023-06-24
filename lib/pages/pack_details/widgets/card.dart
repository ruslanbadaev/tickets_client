import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CardWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Function onPressed;
  const CardWidget({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(5, 7),
              color: AppColors.DARK.withOpacity(.1),
            ),
          ],
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget icon;
  final Function onPressed;
  const IconButtonWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          onPressed();
        },
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                icon,
                Text(
                  title,
                  style: Get.textTheme.bodyText1!.copyWith(),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Get.textTheme.bodyText2!.copyWith(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

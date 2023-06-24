import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/colors.dart';

class CustomListTileWidget extends StatelessWidget {
  final String? emoji;
  final String title;
  final String? subtitle;
  final Widget? marker;
  final Widget? leading;
  final double? width;
  final Function onPressed;

  const CustomListTileWidget({
    Key? key,
    this.emoji,
    required this.title,
    this.subtitle,
    this.marker,
    this.leading,
    this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Get.theme.backgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          onPressed();
        },
        leading: emoji == null && leading == null
            ? null
            : leading ??
                CircleAvatar(
                  backgroundColor: AppColors.SECONDARY,
                  child: Text(
                    emoji ?? '-',
                    style: Get.textTheme.bodyText1,
                  ),
                ),
        title: Text(
          title,
          style: GoogleFonts.comfortaa(
            textStyle: Get.theme.textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w600,
              color: Get.theme.accentColor,
              fontSize: 18,
            ),
          ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: GoogleFonts.comfortaa(
                  textStyle: Get.theme.textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Get.theme.accentColor,
                    fontSize: 14,
                  ),
                ),
              ),
        trailing: marker,
      ),
    );
  }
}

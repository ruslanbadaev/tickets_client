import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickets/utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleString;
  final Widget? titleWidget;
  final bool centerTitle;
  final double? elevation;
  final Color? titleColor;
  final bool isShowBack;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final String? backIconPath;
  final Color? backIconColor;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.titleString,
    this.titleWidget,
    this.centerTitle = true,
    this.elevation,
    this.titleColor,
    this.isShowBack = true,
    this.leading,
    this.backgroundColor,
    this.toolbarHeight,
    this.backIconPath,
    this.backIconColor,
    this.onBackPress,
    this.actions,
    this.bottom,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(titleWidget == null || titleString == null,
            '\n\nCannot provide both a titleWidget and a titleString.\nUse only one option\n'),
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(
            titleString ?? '',
            style: Get.textTheme.headline2!.copyWith(
              color: Get.theme.accentColor,
            ),
          ),
      leading: isShowBack
          ? Center(
              child: InkWell(
                onTap: () {
                  if (onBackPress == null) {
                    Get.back();
                  } else {
                    onBackPress!();
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.DARK,
                ),
              ),
            )
          : null,
      actions: actions,
      backgroundColor: Get.theme.backgroundColor,
    );
  }
}

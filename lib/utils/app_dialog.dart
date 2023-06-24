import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_list_tile.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';

class AppDialog {
  static void getErrorDialog(String text) {
    Get.defaultDialog(
      title: AppStrings.error.tr,
      titlePadding: const EdgeInsets.only(top: 24, bottom: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Get.textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          CustomListTileWidget(
            title: AppStrings.close.tr,
            leading: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  static void getSuccessDialog({
    required String title,
    String? buttonText,
    required Widget content,
    Widget? leading,
    Function? onPressed,
    bool? barrierDismissible,
    bool? showBack,
  }) {
    Get.defaultDialog(
      title: title,
      titlePadding: const EdgeInsets.only(top: 24, bottom: 0),
      barrierDismissible: barrierDismissible ?? true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          content,
          const SizedBox(height: 12),
          if (onPressed != null)
            CustomListTileWidget(
              title: title,
              leading: leading,
              onPressed: () => onPressed(),
            ),
          if (showBack ?? true)
            CustomListTileWidget(
              title: AppStrings.cancel.tr,
              leading: const Icon(Icons.close),
              onPressed: () => Get.back(),
            ),
        ],
      ),
    );
  }

  static void getConfirmationDialog(
      {String? title, required String body, required Function onSuccess, Function? onCancel}) {
    Get.defaultDialog(
      title: title ?? 'Select',
      titleStyle: Get.textTheme.bodyText1,
      titlePadding: const EdgeInsets.only(top: 24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.WHITE,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          Text(
            body,
            style: Get.textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.DARK.withOpacity(.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => (onCancel ?? Get.back)(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                  child: Text(
                    AppStrings.close.tr,
                    style: Get.textTheme.bodyText2,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onSuccess(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                  child: Text(
                    AppStrings.confirm.tr,
                    style: Get.textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      radius: 10.0,
    );
  }

  static void getInfoDialog({String? title, required String body, Function? onPressed}) {
    Get.defaultDialog(
      title: title ?? 'Info',
      titleStyle: Get.textTheme.bodyText1,
      titlePadding: const EdgeInsets.only(top: 24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.WHITE,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          Text(
            body,
            style: Get.textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.PINK.withOpacity(.5)),
          InkWell(
            onTap: () {
              if (onPressed != null) {
                onPressed();
              } else {
                Get.back();
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Text(
                AppStrings.confirm.tr,
                style: Get.textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
      radius: 10.0,
    );
  }
}

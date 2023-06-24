import 'dart:developer';

import 'package:tickets/models/pack.dart';
import 'package:get/get.dart';

import '../../controller.dart';
import '../../mixins/utils.dart';

class ImageEditorScreenController extends GetxController with Utils {
  final AppController appController = Get.find();
  RxList items = [].obs;

  @override
  void onInit() {
    getAllItems();
    super.onInit();
  }

  void getAllItems() {
    items.value.clear();
    items.value.addAll(PackModel.getAll());
    // for (var item in items.value) {
    //   // log(item.pictures.toString());
    // }

    update();
  }
}

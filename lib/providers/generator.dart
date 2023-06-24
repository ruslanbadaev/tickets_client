import 'dart:developer';

import 'package:tickets/pages/gallery/controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../controller.dart';
import '../models/pack.dart';

class GeneratorProvider extends GetxController {
  final dio = Dio();

  final AppController appController = Get.find();
  final GalleryScreenController galleryController = Get.put(GalleryScreenController());

  RxBool loading = false.obs;

  Future<Response?> generateImages(PackModel pack) async {
    try {
      loading.value = true;
      appController.startLoading();
      update();
      log("prompt: ${pack.request}");

      log('lol ${loading.value}');
      final response = await dio.post(
        'https://backend.craiyon.com/generate',
        data: {"prompt": pack.request},
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      if (response.data != null) {
        PackModel.write(
          PackModel(
            id: pack.id,
            description: pack.description,
            style: pack.style,
            request: pack.request,
            type: pack.type,
            status: GenerationStatus.success,
            pictures: response.data['images'] as List,
            createdAt: pack.createdAt,
          ),
        );
        Get.snackbar('Congratulations', '${pack.description} successfully generated');
        galleryController.getAllItems();
        appController.endLoading();
      }
    } catch (e) {
      Get.snackbar('Error', '${pack.description} not generated');
      log(e.toString());
      appController.endLoading();
    }
    loading.value = false;
    appController.endLoading();

    update();
    return null;
  }
}

import 'dart:developer';

import 'package:tickets/models/pack.dart';
import 'package:tickets/providers/generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../controller.dart';
import '../../mixins/utils.dart';

class GenerateScreenController extends GetxController with Utils {
  GeneratorProvider provider = GeneratorProvider();

  final AppController appController = Get.find();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController styleController = TextEditingController();

  void generate({
    required String description,
    required String style,
    required PackType type,
  }) {
    String styleString = style.replaceAll(' ', '').isNotEmpty ? 'in $style style' : '';
    provider.generateImages(
      PackModel(
        id: const Uuid().v4(),
        description: description,
        style: style,
        request:
            '$description ${type.name} $styleString ${type == PackType.emoji || type == PackType.sticker ? 'on the white background' : ''}',
        type: type,
        status: GenerationStatus.waiting,
        pictures: [],
        createdAt: DateTime.now(),
      ),
    );

    // log('$description | $style');
  }
}

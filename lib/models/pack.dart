import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

enum GenerationStatus { success, waiting, error }

enum PackType { emoji, sticker, art, other }

class PackModel {
  final String id;
  final String description;
  final String style;
  final String request;
  final GenerationStatus status;
  final PackType type;
  final List pictures;
  final DateTime createdAt;

  PackModel({
    required this.id,
    required this.description,
    required this.style,
    required this.request,
    required this.status,
    required this.type,
    required this.pictures,
    required this.createdAt,
  });

  static void write(PackModel pack) async {
    try {
      final box = GetStorage();
      Map<String, dynamic> map = PackModel.toJson(pack);
      log(map.toString());
      box.write(pack.id, json.encode(map));
    } catch (e) {
      Get.defaultDialog(title: 'Storage error', textCustom: e.toString());
    }
  }

  static Future<PackModel?> get(String id) async {
    return null;
  }

  static List<PackModel> getAll() {
    List<PackModel> result = [];
    try {
      final box = GetStorage();

      List values = box.getValues().toList();
      print(values.toList());

      for (var value in values.reversed) {
        result.add(PackModel.fromJson(json.decode(value)));
      }

      // List<String> keys =
      //     box.getKeys().toString().replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').split(',');

      // for (String key in keys) {
      //   log(key);
      //   String? value = box.read(key);
      //   if (value != null) {
      //     print(value);

      //     result.add(PackModel.fromJson(json.decode(value)));
      //   }
      // }
    } catch (e) {
      log(e.toString());
    }

    return result;
  }

  static Map<String, dynamic> toJson(PackModel pack) {
    return {
      'id': pack.id,
      'description': pack.description,
      'style': pack.style,
      'request': pack.request,
      'type': pack.type.name,
      'status': pack.status.name,
      'pictures': pack.pictures,
      'createdAt': pack.createdAt.toString(),
    };
  }

  static PackModel fromJson(Map<String, dynamic> pack) {
    GenerationStatus getStatus(String? status) {
      if (status == 'waiting') {
        return GenerationStatus.waiting;
      }
      if (status == 'success') {
        return GenerationStatus.success;
      }
      return GenerationStatus.error;
    }

    PackType? getType(String? type) {
      log(type.toString());

      if (type != null) {
        if (type.contains('emoji')) {
          return PackType.emoji;
        }
        if (type == 'sticker') {
          return PackType.sticker;
        }
        if (type == 'art') {
          return PackType.art;
        }
      }
      return null;
    }

    return PackModel(
      id: pack['id'],
      description: pack['description'],
      style: pack['style'],
      request: pack['request'],
      type: getType(pack['type']) ?? PackType.other,
      status: getStatus(pack['status']),
      pictures: pack['pictures'],
      createdAt: DateTime.tryParse(pack['createdAt']) ?? DateTime.now(),
    );
  }
}

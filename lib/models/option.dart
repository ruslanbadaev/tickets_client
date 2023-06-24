import 'package:tickets/models/price.dart';
import 'package:tickets/models/plant.dart';

class OptionModel {
  final String id;
  final String name;
  final List<String> images;
  // final List<HelperModel> helpers;

  OptionModel({
    required this.id,
    required this.name,
    required this.images,
    // required this.helpers,
  });

  // static Future<CellModel> fromJson(Map<String, dynamic> json) async {
  //   return CellModel(
  //     id: json['id'] ?? '??',
  //     plant: json['plant'] ?? '??',
  //   );
  // }
}

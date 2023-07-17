// import 'package:flutter/material.dart';

// import '../pages/creation/controller.dart';

// class PriceModel {
//   final String id;
//   final String name;
//   final Color color;
//   final PointType type;
//   final String? price;

//   PriceModel({
//     required this.id,
//     required this.name,
//     required this.color,
//     required this.type,
//     this.price,
//   });

//   static Map<String, dynamic> toJson(PriceModel price) {
//     return {
//       'id': price.id,
//       'name': price.name,
//       'color': price.color,
//       'type': price.type,
//       'price': price.price,
//     };
//   }

//   static Future<PriceModel> fromJson(Map<String, dynamic> json) async {
//     return PriceModel(
//       id: json['id'] ?? '??',
//       name: json['name'] ?? '??',
//       color: json['color'] ?? '??',
//       type: json['type'] ?? '??',
//       price: json['price'] ?? '??',
//     );
//   }
// }

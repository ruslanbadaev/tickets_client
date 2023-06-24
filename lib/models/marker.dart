import 'package:flutter/material.dart';
import 'package:tickets/pages/creation/controller.dart';

class MarkerModel {
  final String id;
  final int? row;
  final int? column;
  String name;
  Color color;
  String? price;
  PointType? type;
  MarkerModel({
    required this.id,
    required this.name,
    required this.color,
    this.row,
    this.column,
    this.price,
    this.type,
  });

  @override
  String toString() {
    return '''
      Recipient{
        id: $id, 
        name: $name, 
        row: $row,
        column: $column,
        color: $color,
        price: $price,
        type: $type,
      }
      ''';
  }
}

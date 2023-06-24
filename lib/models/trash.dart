class TrashModel {
  final String id;
  final String name;
  final double buyPrice;
  final double sellPrice;
  bool cleared;
  int readyTime;

  TrashModel({
    required this.id,
    required this.name,
    required this.buyPrice,
    required this.sellPrice,
    required this.cleared,
    required this.readyTime,
  });

  // static Future<PlantModel> fromJson(Map<String, dynamic> json) async {
  //   return PlantModel(
  //     id: json['id'] ?? '??',
  //   );
  // }
}

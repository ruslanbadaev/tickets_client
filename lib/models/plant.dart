class PlantModel {
  final String id;
  final String name;
  final String imageUrl;
  final double buyPrice;
  final double sellPrice;
  int readyTime;

  PlantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.buyPrice,
    required this.sellPrice,
    required this.readyTime,
  });

  // static Future<PlantModel> fromJson(Map<String, dynamic> json) async {
  //   return PlantModel(
  //     id: json['id'] ?? '??',
  //   );
  // }
}

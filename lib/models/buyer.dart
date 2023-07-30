class BuyerModel {
  final String id;
  final String name;
  final String status;
  final String? email;
  final String? phone;
  final DateTime? createdAt;

  BuyerModel({
    required this.id,
    required this.name,
    required this.status,
    this.email,
    this.phone,
    this.createdAt,
  });

  static BuyerModel fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      id: (json['id']) ?? '?',
      name: json['name'] ?? '??',
      status: json['status'] ?? '??',
      email: json['email'] ?? '??',
      phone: json['phone'] ?? '??',
      createdAt: DateTime.tryParse((json['createdAt'] ?? '')),
    );
  }

  @override
  String toString() {
    return '''
      BuyerModel{
        id: $id, 
        name: $name, 
        status: $status,
        email: $email,
        phone: $phone,
        createdAt: $createdAt,
      }
      ''';
  }
}

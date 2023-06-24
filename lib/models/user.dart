class UserModel {
  final String uid;
  final String name;
  final String email;
  final bool verified;

  final double lat;
  final double long;
  final DateTime createdAt;
  final DateTime lastSignInTime;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.verified,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.lastSignInTime,
  });

  static Future<UserModel> fromJson(Map<String, dynamic> json) async {
    return UserModel(
      uid: json['uid'] ?? '??',
      name: json['name'] ?? '??',
      email: json['email'] ?? '??',
      verified: json['verified'] ?? false,
      lat: json['location'] ?? 0,
      long: json['location'] ?? 0,
      createdAt: json['createdAt'] ?? DateTime(0),
      lastSignInTime: json['lastSignInTime'] ?? DateTime(0),
    );
  }
}

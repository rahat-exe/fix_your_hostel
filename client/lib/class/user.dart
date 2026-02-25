class User {
  final String id;
  final String name;
  final String email;
  final String hostelBlock;
  final int roomNo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.hostelBlock,
    required this.roomNo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      hostelBlock: json["hostelBlock"],
      roomNo: json["roomNo"],
    );
  }
}
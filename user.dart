class User {
  final String id;
  final String name;
  final String email;
  final String? password; // Only for registration, not stored directly

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
  });

  // Factory constructor for creating a new User instance from a map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }

  // Method for converting a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}

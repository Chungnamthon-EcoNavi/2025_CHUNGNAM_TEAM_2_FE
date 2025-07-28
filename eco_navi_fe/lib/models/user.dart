class User {
  final int id;
  final String username;
  final String name;
  final String role;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    username: json['username'] as String,
    name: json['name'] as String,
    role: json['role'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );

  /// Model → JSON (필요할 때만)
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'name': name,
    'role': role,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

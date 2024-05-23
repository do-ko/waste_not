class UserModel {
  String id;
  String email;
  String username;

  UserModel({
    this.id = '',
    required this.email, 
    required this.username
  });

  // Convert a User instance to a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': username,
    };
  }

  // Construct a User from a json
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'], 
      username: map['name'],
    );
  }
}
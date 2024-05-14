class User {
  String id;
  String email;
  String name;

  User({
    this.id = '',
    required this.email, 
    required this.name
  });

  // Convert a User instance to a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  // Construct a User from a json
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'], 
      name: map['name'],
    );
  }
}
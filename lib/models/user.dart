class User {
  String email;
  String name;

  User({
    required this.email, 
    required this.name
  });

  // Convert a User instance to a json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }

  // Construct a User from a json
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'], 
      name: map['name'],
    );
  }
}
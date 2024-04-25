class User {
  String email;
  String name;

  User({
    required this.email, 
    required this.name
  });

  // Convert a User instance to a Map (for firebase?)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }

  // Construct a User from a map (for firebase?)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'], 
      name: map['name'],
    );
  }
}
class Product {
  String name;
  int category;
  String comment;
  DateTime expirationDate;
  String imageLink;
  final String owner;

  Product({
    required this.name,
    required this.category, 
    required this.comment,
    required this.expirationDate,
    required this.imageLink,
    required this.owner
  });


  // Convert a Product instance to a Map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'comment': comment,
      'expiration_date': expirationDate.toIso8601String(),
      'image_link': imageLink,
      'owner': owner,
    };
  }

  // Construct a Product from a map.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      category: map['category'],
      comment: map['comment'],
      expirationDate: DateTime.parse(map['expiration_date']),
      imageLink: map['image_link'],
      owner: map['owner'],
    );
  }
}
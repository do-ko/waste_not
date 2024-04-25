class Category {
  final String iconPath;
  String name;

  Category({
    required this.iconPath, 
    required this.name
  });

  // Convert a Category instance to a Map.
  Map<String, dynamic> toMap() {
    return {
      'icon_path': iconPath,
      'name': name,
    };
  }

  // Construct a Category from a map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      iconPath: map['icon_path'],
      name: map['name'],
    );
  }
}
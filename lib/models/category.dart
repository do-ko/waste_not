class Category {
  String iconPath;
  String name;

  Category({required this.iconPath, required this.name});

  // Convert a Category instance to a json
  Map<String, dynamic> toJson() {
    return {
      'icon_path': iconPath,
      'name': name,
    };
  }

  // Construct a Category from a json 
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      iconPath: map['icon_path'],
      name: map['name'],
    );
  }
}
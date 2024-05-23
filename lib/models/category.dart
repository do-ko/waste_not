class CategoryModel {
  String id;
  String iconPath;
  String name;

  CategoryModel({required this.id, required this.iconPath, required this.name});

  // Convert a Category instance to a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon_path': iconPath,
      'name': name,
    };
  }

  // Construct a Category from a json
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      iconPath: map['icon_path'],
      name: map['name'],
    );
  }
}
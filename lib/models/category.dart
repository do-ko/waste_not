class CategoryModel {
  String categoryId;
  String iconPath;
  String name;

  CategoryModel({required this.categoryId, required this.iconPath, required this.name});

  // Convert a Category instance to a json
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'icon_path': iconPath,
      'name': name,
    };
  }

  // Construct a Category from a json 
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'],
      iconPath: map['icon_path'],
      name: map['name'],
    );
  }
}
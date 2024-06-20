import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String name;
  String category;
  String comment;
  DateTime expirationDate;
  String imageLink;
  String owner;

  ProductModel({
    required this.productId,
    required this.name,
    required this.category,
    required this.comment,
    required this.expirationDate,
    required this.imageLink,
    required this.owner,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'category': category,
      'comment': comment,
      'expiration_date': Timestamp.fromDate(expirationDate), // Corrected
      'image_link': imageLink,
      'owner': owner,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      name: map['name'],
      category: map['category'],
      comment: map['comment'],
      expirationDate: (map['expiration_date'] as Timestamp).toDate(), // Corrected
      imageLink: map['image_link'],
      owner: map['owner'],
    );
  }

  ProductModel copyWith({
    String? productId,
    String? name,
    String? category,
    String? comment,
    DateTime? expirationDate,
    String? imageLink,
    String? owner,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      comment: comment ?? this.comment,
      expirationDate: expirationDate ?? this.expirationDate,
      imageLink: imageLink ?? this.imageLink,
      owner: owner ?? this.owner,
    );
  }
}

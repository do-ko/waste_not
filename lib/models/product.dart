import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String name;
  String category;
  String comment;
  DateTime expirationDate;
  String imageLink;
  String owner;

  ProductModel(
      {this.productId = '',
      required this.name,
      required this.category,
      required this.comment,
      required this.expirationDate,
      required this.imageLink,
      required this.owner});

  // Convert a Product instance to a Map.
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'category': FirebaseFirestore.instance.doc("Categories/$category"),
      'comment': comment,
      'expiration_date': expirationDate,
      'image_link': imageLink,
      'owner': FirebaseFirestore.instance.doc("users/$owner"),
    };
  }

  // Construct a Product from a map.
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    print("mapping now:");
    print(map);
    return ProductModel(
      productId: map['productId'],
      name: map['name'],
      category: map['category'] is DocumentReference ? map['category'].id : map['category'],
      comment: map['comment'],
      expirationDate: (map['expiration_date'] as Timestamp).toDate(),
      imageLink: map['image_link'],
      owner: map['owner'] is DocumentReference ? map['owner'].id : map['owner'],
    );
  }
}

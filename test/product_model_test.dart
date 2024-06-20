import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_not/models/product.dart';

void main() {
  group('ProductModel', () {
    test('should create a valid ProductModel object from a map', () {
      final productMap = {
        'productId': '123',
        'name': 'Test Product',
        'category': 'Test Category',
        'comment': 'This is a test product',
        'expiration_date': Timestamp.fromDate(DateTime.parse('2023-06-19T12:00:00Z').toUtc()), // Ensured UTC
        'image_link': 'http://example.com/image.png',
        'owner': 'user123',
      };

      final product = ProductModel.fromMap(productMap);

      expect(product.productId, '123');
      expect(product.name, 'Test Product');
      expect(product.category, 'Test Category');
      expect(product.comment, 'This is a test product');
      expect(product.expirationDate.toUtc(), DateTime.parse('2023-06-19T12:00:00Z').toUtc()); // Ensured UTC
      expect(product.imageLink, 'http://example.com/image.png');
      expect(product.owner, 'user123');
    });

    test('should convert a ProductModel object to JSON', () {
      final product = ProductModel(
        productId: '123',
        name: 'Test Product',
        category: 'Test Category',
        comment: 'This is a test product',
        expirationDate: DateTime.parse('2023-06-19T12:00:00Z').toUtc(), // Ensured UTC
        imageLink: 'http://example.com/image.png',
        owner: 'user123',
      );

      final productJson = product.toJson();

      expect(productJson['productId'], '123');
      expect(productJson['name'], 'Test Product');
      expect(productJson['category'], 'Test Category');
      expect(productJson['comment'], 'This is a test product');
      expect((productJson['expiration_date'] as Timestamp).toDate().toUtc(), DateTime.parse('2023-06-19T12:00:00Z').toUtc()); // Ensured UTC
      expect(productJson['image_link'], 'http://example.com/image.png');
      expect(productJson['owner'], 'user123');
    });

    test('should create a copy of ProductModel with updated fields', () {
      final product = ProductModel(
        productId: '123',
        name: 'Test Product',
        category: 'Test Category',
        comment: 'This is a test product',
        expirationDate: DateTime.parse('2023-06-19T12:00:00Z').toUtc(), // Ensured UTC
        imageLink: 'http://example.com/image.png',
        owner: 'user123',
      );

      final updatedProduct = product.copyWith(name: 'Updated Product', category: 'Updated Category');

      expect(updatedProduct.productId, '123');
      expect(updatedProduct.name, 'Updated Product');
      expect(updatedProduct.category, 'Updated Category');
      expect(updatedProduct.comment, 'This is a test product');
      expect(updatedProduct.expirationDate.toUtc(), DateTime.parse('2023-06-19T12:00:00Z').toUtc()); // Ensured UTC
      expect(updatedProduct.imageLink, 'http://example.com/image.png');
      expect(updatedProduct.owner, 'user123');
    });
  });
}

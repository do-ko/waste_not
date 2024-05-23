import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_test/integration_test.dart';
import 'package:waste_not/controllers/product_controller.dart';
import 'package:waste_not/controllers/products_controller.dart';
import 'package:waste_not/firebase_options.dart';
import 'package:waste_not/models/product.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GetStorage.init();
  });

  group('ProductsController Tests', () {
    late ProductsController productsController;
    late FirebaseFirestore firestore;

    setUp(() async {
      firestore = FirebaseFirestore.instance;
      productsController = ProductsController();
    });

    testWidgets('Fetch Products', (WidgetTester tester) async {
      String userId = 'test_user';
      GetStorage().write('userId', userId);

      // Add a sample product to Firestore for testing
      await firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .add({
        'name': 'Test Product',
        'category': 1,
        'comment': 'Test Comment',
        'expiration_date': DateTime.now().toIso8601String(),
        'image_link': 'test_link',
        'owner': userId,
      });

      await productsController.fetchProducts();

      expect(productsController.products.length, greaterThan(0));
      expect(
          productsController.products[0].product.value?.name, 'Test Product');
    });

    testWidgets('Add Product', (WidgetTester tester) async {
      String userId = 'test_user';
      GetStorage().write('userId', userId);

      ProductController productController = ProductController(productId: '');
      productController.product.value = ProductModel(
        name: 'New Product',
        category: "2",
        comment: 'New Comment',
        expirationDate: DateTime.now(),
        imageLink: 'new_link',
        owner: userId,
      );

      await productsController.addProduct(productController.product.value!);

      // Verify if the product is added in Firestore
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .where('name', isEqualTo: 'New Product')
          .get();

      expect(snapshot.docs.length, 1);
    });

    testWidgets('Remove Product', (WidgetTester tester) async {
      String userId = 'test_user';
      GetStorage().write('userId', userId);

      // Add a sample product to Firestore for testing
      DocumentReference docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .add({
        'name': 'Product to Remove',
        'category': 3,
        'comment': 'Comment',
        'expiration_date': DateTime.now().toIso8601String(),
        'image_link': 'link_to_remove',
        'owner': userId,
      });

      await productsController.removeProduct(docRef.id);

      // Verify if the product is removed from Firestore
      DocumentSnapshot doc = await docRef.get();
      expect(doc.exists, isFalse);
    });
  });
}

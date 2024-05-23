import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/models/product.dart';
import 'package:waste_not/notification_service.dart';

class ProductController extends GetxController {
  RxList<ProductModel> products = RxList<ProductModel>();
  final NotificationService notificationService = Get.put(NotificationService());
  final storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    fetchProductsForUser();
    notificationService.initialize();
  }

  Future<void> fetchProductsForUser() async {
    String? currentUserId = AuthController.instance.authUser?.uid;

    if (currentUserId == null) {
      print("User is not logged in");
      return;
    }

    DocumentReference ownerRef =
        FirebaseFirestore.instance.doc('Users/$currentUserId');

    try {
      print(currentUserId);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('owner', isEqualTo: ownerRef)
          .get();
      if (snapshot.docs.isEmpty) {
        print('No products found for the current user.');
      } else {
        print('${snapshot.docs.length} products found.');
        List<ProductModel> productsList = snapshot.docs
            .map((doc) =>
                ProductModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        products.assignAll(productsList);
      }
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      var documentRef = await collectionRef.add(product.toJson());
      product.productId = documentRef.id;
      await documentRef.update({'productId': documentRef.id});
      products.add(product);
      scheduleNotification(product);
      print('Product added and list updated');
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      await collectionRef.doc(product.productId).update(product.toJson());
      int index = products.indexWhere((p) => p.productId == product.productId);
      if (index != -1) {
        products[index] = product;
        scheduleNotification(product);
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> removeProduct(String productId) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      await collectionRef.doc(productId).delete();
      products.removeWhere((product) => product.productId == productId);
      notificationService.cancelAllNotifications(); // Cancel all notifications to avoid duplicates
      rescheduleAllNotifications(); // Reschedule notifications for remaining products
    } catch (e) {
      print('Error removing product: $e');
    }
  }

  Future<void> removeProducts(List<String> productIds) async {
    for (String id in productIds) {
      await removeProduct(id);
    }
  }

  void scheduleNotification(ProductModel product) {
    final notificationInterval = storage.read('notificationInterval') ?? 1;
    final scheduledDate = product.expirationDate.subtract(
      Duration(days: notificationInterval),
    );

    notificationService.scheduleNotification(
      product.productId.hashCode,
      'Product Expiration Alert',
      'The product ${product.name} is about to expire in $notificationInterval days.',
      scheduledDate,
    );
  }

  void rescheduleAllNotifications() {
    for (var product in products) {
      scheduleNotification(product);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/models/product.dart';

class ProductController extends GetxController {
  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onReady() {
    super.onReady();
    fetchProductsForUser();
  }


  Future<void> fetchProductsForUser() async {
    String? currentUserId = AuthController.instance.authUser?.uid;

    if (currentUserId == null) {
      print("User is not logged in");
      return;
    }

    DocumentReference ownerRef = FirebaseFirestore.instance.doc('Users/$currentUserId');

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
            .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        products.assignAll(productsList);
      }

    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

// ProductController getProduct(String productId) {
//   return ProductController(productId: productId);
// }

// bool removeProduct(productId) {
//   ProductController? pc =
//       products.firstWhereOrNull((pc) => pc.productId == productId);
//
//   if (pc != null) {
//     products.remove(pc);
//     pc.removeProduct();
//
//     return true;
//   }
//
//   return false;
// }

// bool removeProducts(List<String> productIds) {
//   bool success = true;
//   for (String id in productIds) {
//     success &= removeProduct(id);
//   }
//   return success;
// }
}

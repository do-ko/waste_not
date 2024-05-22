// import 'package:get/get.dart';
//
// import '../models/product.dart';
//
// class ProductController extends GetxController {
//   final String productId;
//   late Rx<ProductModel?> product;
//
//   ProductController({required this.productId}) {
//     product = getProduct(productId).obs;
//   }
//
//   ProductModel? getProduct(String productId) {
//     return ProductModel(
//         name: "Product $productId",
//         category: -1,
//         comment: "Hi",
//         expirationDate: DateTime.now(),
//         imageLink: "null",
//         owner: "0");
//   }
//
//   bool removeProduct() {
//     product = null.obs;
//     return true;
//   }
// }

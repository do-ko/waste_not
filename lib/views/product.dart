import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_not/controllers/model_controllers/category.dart';
import 'package:waste_not/views/shared/category_icon.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/model_controllers/product.dart';
import '../models/product.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;
  // final ProductController productController;

  const ProductView({super.key, required this.product});

  Widget _buildDetailCard(String title, String value) {
    return Card(
      shadowColor: Colors.transparent,
      color: containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Set the Card's border radius
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: fontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  style: const TextStyle(
                      color: primaryBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildDetailTimeCard(String title, String value1, String value2) {
    return Card(
        shadowColor: Colors.transparent,
        color: containerColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Set the Card's border radius
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: primaryBlue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        value1,
                        style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timelapse,
                        size: 24,
                        color: primaryBlue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$value2 days',
                        style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Get.toNamed("/product/edit",
                  parameters: {"productId": product.productId})),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                FutureBuilder(
                    future: ProductController.getDownloadURL(product.imageLink),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container(
                          width: double.maxFinite,
                          height: 200,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: const CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        return Container(
                          width: double.maxFinite,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!),
                          )),
                        );
                      }

                      return Container(
                          width: double.maxFinite,
                          height: 200,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: const Text('Error loading image'));
                    }),
                Positioned(
                    bottom: -40,
                    right: 30,
                    child: CategoryIcon(
                        iconPath: categoryController
                            .getCategoryById(product.category)
                            ?.iconPath,
                        size: 45,
                        padding: 10,
                        withShadow: true)),
              ],
            ),
            const SizedBox(height: 60),
            _buildDetailCard('Product Name', product.name),
            _buildDetailTimeCard(
                'Expiration Date',
                DateFormat('MM/dd/yyyy').format(product.expirationDate),
                product.expirationDate
                    .difference(DateTime.now())
                    .inDays
                    .toString()),
            _buildDetailCard(
                'Category',
                categoryController.getCategoryById(product.category)?.name ??
                    'null'),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle remove action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryBlue,
                  minimumSize: const Size(180, 36),
                ),
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                ),
                label: const Text(
                  'Remove',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

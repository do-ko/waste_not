import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product_controller_old.dart';
import 'package:waste_not/views/edit_product.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class ProductView extends StatelessWidget {
  ProductModel product;

  ProductView({super.key, required this.product});

  // final ProductController productController;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Get.to(
                  () => EditProductView(productController: productController)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('lib/assets/cheese_temp.jpg'))),
            ),
            //TODO add a category icon (round above image)
            const SizedBox(height: 20),
            _buildDetailCard('Product Name', product.name),
            _buildDetailTimeCard(
                'Expiration Date',
                DateFormat('MM/dd/yyyy').format(product.expirationDate),
                product.expirationDate
                    .difference(DateTime.now())
                    .inDays
                    .toString()),
            _buildDetailCard('Category', product.category.toString()),
            //TODO get category name and not id
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
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
            //TODO add a category icon (round above image)
            Stack(
              clipBehavior: Clip.none,
              children: [
                FutureBuilder<String>(
                    future: getDownloadURL(product.imageLink),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Container(
                          width: double.maxFinite,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!),
                          )),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                            width: double.maxFinite,
                            height: 200,
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: const Text('Error loading image'));
                      }
                      return Container(
                        width: double.maxFinite,
                        height: 200,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const CircularProgressIndicator(),
                      );
                    }),
                Positioned(
                  bottom: -40,
                  right: 30,
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryBlue, // Color of the circle container
                      shape: BoxShape.circle, // Makes the container circular
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    // child: Icon(
                    //   Icons.delete, // Icon inside the circle
                    //   color: Colors.white,
                    //   size: 40,
                    // ),

                    child: SvgPicture.asset(
                      'lib/assets/ready_meals.svg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain
                    ),

                    // child: Container(
                    //   width: 10,
                    //   height: 10,
                    //   child: SvgPicture.asset(
                    //     'lib/assets/ready_meals.svg',
                    //     fit: BoxFit.contain, // This will maintain the SVG's aspect ratio
                    //   ),
                    // ),

                    // child: Image.asset('lib/assets/ready_meals.jpg'),
                  ),
                ),
              ],
            ),
            // FutureBuilder<String>(
            //     future: getDownloadURL(product.imageLink),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done &&
            //           snapshot.hasData) {
            //         return Container(
            //           width: double.maxFinite,
            //           height: 200,
            //           decoration: BoxDecoration(
            //               image: DecorationImage(
            //             fit: BoxFit.cover,
            //             image: NetworkImage(snapshot.data!),
            //           )),
            //         );
            //       } else if (snapshot.hasError) {
            //         return Container(
            //             width: double.maxFinite,
            //             height: 200,
            //             alignment: Alignment.center,
            //             color: Colors.white,
            //             child: const Text('Error loading image'));
            //       }
            //       return Container(
            //         width: double.maxFinite,
            //         height: 200,
            //         alignment: Alignment.center,
            //         color: Colors.white,
            //         child: const CircularProgressIndicator(),
            //       );
            //     }),
            const SizedBox(height: 60),
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

Future<String> getDownloadURL(String gsUrl) async {
  try {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  } catch (e) {
    print('Error obtaining download URL: $e');
    return '';
  }
}

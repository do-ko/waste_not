import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';

import '../controllers/products.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    ProductsController productsController = Get.put(ProductsController());

    String username = GetStorage().read('username') ??
        "[username]"; // TODO where is username actually?

    return Scaffold(
        appBar: AppBar(
          title: Text('Hello, $username!'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Get.to(() => const SettingsView()),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          ProductList(
              homeController: homeController,
              productsController: productsController),
        ])),
        bottomNavigationBar: NavigationBar(destinations: [
          Obx(() => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: homeController.markedProducts.isNotEmpty
                  ? () {
                      productsController
                          .removeProducts(homeController.markedProducts);
                      homeController.clear();
                    }
                  : null)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.to(() => const AddProductView()),
          ),
          IconButton(
            icon: const Icon(Icons.live_help_outlined),
            onPressed: () => {},
          )
        ]));
  }
}

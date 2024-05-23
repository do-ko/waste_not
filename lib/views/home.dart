import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/category_list.dart'; // Import CategoryListView
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';
import '../controllers/home.dart';
import '../controllers/products_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    ProductsController productsController = Get.put(ProductsController());

    String username = GetStorage().read('username') ?? "[username]";

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
      body: Obx(() {
        if (productsController.products.isEmpty) {
          return const Center(child: Text('No products found.'));
        } else {
          return SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ProductList(
                      homeController: homeController,
                      productsController: productsController,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Get.to(() => CategoryListView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Product'),
              onTap: () {
                Get.to(() => const AddProductView());
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_rounded),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help_outlined),
            label: 'Help',
          ),
        ],
        onTap: (index) {
          if (index == 0 && homeController.markedProducts.isNotEmpty) {
            productsController.removeProducts(homeController.markedProducts);
            homeController.clear();
          } else if (index == 1) {
            Get.to(() => const AddProductView());
          } else if (index == 2) {
            // Implement help action
          }
        },
      ),
    );
  }
}
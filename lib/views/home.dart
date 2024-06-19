import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/category.dart';
import 'package:waste_not/controllers/model_controllers/user.dart';
import 'package:waste_not/controllers/page_controllers/home.dart';
import 'package:waste_not/controllers/page_controllers/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/model_controllers/products.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    UserFirebaseController userFirebaseController =
        Get.put(UserFirebaseController());
    UserController userController = Get.put(UserController());
    HomeController homeController = Get.put(HomeController());
    ProductsController productsController = Get.put(ProductsController());
    DarkModeController darkModeController = Get.find();
    Get.put(CategoryController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Obx(
          () => AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Text(
                'Hello, ${userController.user.value.username}!',
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Get.toNamed("/settings"),
              )
            ],
          ),
        ),
      ),
      body: //SingleChildScrollView(
          Container(
        // padding: EdgeInsets.only(top: 20),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), // 20 is the radius of the curve
            topRight: Radius.circular(20),
          ),
        ),
        child: const ProductList(),
      ),
      bottomNavigationBar: NavigationBar(height: 50, destinations: [
        Obx(() => homeController.markedProducts.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.delete_rounded,
                    color: iconColor, size: 30),
                onPressed: () {
                  productsController
                      .removeProducts(homeController.markedProducts);
                  homeController.clear();
                })
            : IconButton(
                icon: Icon(Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.primary.withAlpha(80), size: 30),
                onPressed: null)),
        IconButton(
            icon: Icon(Icons.live_help_outlined,
                color: Theme.of(context).colorScheme.primary, size: 30),
            onPressed: () => Get.toNamed("/suggestions"))
      ]),
      floatingActionButton: Transform.scale(
          scale: 1.2,
          child: FloatingActionButton(
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              shape: const CircleBorder(),
              onPressed: () => Get.toNamed("/product/add"),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add,
                  color: categoryIconLightColor, size: 30))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.delete_rounded),
      //       label: 'Delete',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: 'Add',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.live_help_outlined),
      //       label: 'Suggestions',
      //     ),
      //   ],
      //   onTap: (index) {
      //     if (index == 0 && homeController.markedProducts.isNotEmpty) {
      //       productsController.removeProducts(homeController.markedProducts);
      //       homeController.clear();
      //     } else if (index == 1) {
      //       Get.to(() => const AddProductView());
      //     } else if (index == 2) {
      //       Get.to(() => const SuggestionsView()));
      //     }
      //   },
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Menu'),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.category),
      //         title: const Text('Categories'),
      //         onTap: () {
      //           Get.to(() => CategoryListView());
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.add),
      //         title: const Text('Add Product'),
      //         onTap: () {
      //           Get.to(() => const AddProductView());
      //         },
      //       ),
      //       // Add more menu items as needed
      //     ],
      //   ),
      // ),
    );
  }
}

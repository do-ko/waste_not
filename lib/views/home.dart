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
            elevation: 0,
            title: Text('Hello, ${userController.user.value.username}!'),
            centerTitle: false,
            backgroundColor:
                darkModeController.darkMode.value ? Colors.red : Colors.white,
            titleTextStyle: TextStyle(
              color:
                  //textHeaderColor,
                  darkModeController.darkMode.value ? Colors.blue : fontColor,
              fontSize: 24,
            ),
            iconTheme: IconThemeData(
              color:
                  darkModeController.darkMode.value ? Colors.blue : iconColor,
            ),
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
        decoration: const BoxDecoration(
          color: fridgeColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // 20 is the radius of the curve
            topRight: Radius.circular(20),
          ),
        ),
        child: const ProductList(),
      ),
      bottomNavigationBar: NavigationBar(destinations: [
        Obx(() => homeController.markedProducts.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.delete_rounded, color: iconColor),
                onPressed: () {
                  productsController
                      .removeProducts(homeController.markedProducts);
                  homeController.clear();
                })
            : const IconButton(
                icon: Icon(Icons.delete_rounded), onPressed: null)),
        IconButton(
          icon: const Icon(Icons.add, color: iconColor),
          onPressed: () => Get.toNamed("/product/add"),
        ),
        IconButton(
            icon: const Icon(Icons.live_help_outlined, color: iconColor),
            onPressed: () => Get.toNamed("/suggestions"))
      ]),
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

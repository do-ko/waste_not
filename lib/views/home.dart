import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/category_controller.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/controllers/settings_controller.dart';
import 'package:waste_not/controllers/user_controller.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/product_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    HomeController homeController = Get.put(HomeController());
    ProductController productsController = Get.put(ProductController());
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
                  onPressed: () => Get.to(() => const SettingsView()),
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
            onPressed: () => Get.to(() => const AddProductView()),
          ),
          IconButton(
            icon: const Icon(Icons.live_help_outlined, color: iconColor),
            onPressed: () => {},
          )
        ]));
  }
}

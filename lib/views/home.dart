import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/controllers/settings_controller.dart';
import 'package:waste_not/controllers/user_controller.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/products.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    HomeController homeController = Get.put(HomeController());
    ProductsController productsController = Get.put(ProductsController());
    DarkModeController darkModeController = Get.find();

    String username = GetStorage().read('username') ??
        "[username]"; // TODO where is username actually?

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Obx(
            () => AppBar(
              title: Text('Hello, ${userController.user.value.username}!'),
              centerTitle: false,
              backgroundColor: darkModeController.darkMode.value
                  ? Colors.red
                  : Colors.white,
                titleTextStyle: TextStyle(
                  color: darkModeController.darkMode.value ? Colors.blue : fontColor,
                  fontSize: 24,
                ),
                iconTheme: IconThemeData(
                  color: darkModeController.darkMode.value ? Colors.blue : fontColor,
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
        // AppBar(
        //   title: Text('Hello, $username!'),
        //   backgroundColor: Colors.white,
        //   centerTitle: false,
        //   titleTextStyle: const TextStyle(
        //     color: Colors.black,
        //     fontSize: 24,
        //   ),
        //   iconTheme: const IconThemeData(
        //     color: Colors.black,
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.settings),
        //       onPressed: () => Get.to(() => const SettingsView()),
        //     )
        //   ],
        // ),
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

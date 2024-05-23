import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/controllers/settings_controller.dart';
import 'package:waste_not/controllers/user_controller.dart';

import '../controllers/products_controller.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    HomeController homeController = Get.find();
    ProductsController productsController = Get.find();
    DarkModeController darkModeController = Get.find();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Obx(
            () => AppBar(
                elevation: 0, title: Text('Suggestions'), centerTitle: false),
          ),
        ),
        body: Placeholder());
  }
}

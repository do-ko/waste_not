import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/user.dart';
import 'package:waste_not/controllers/page_controllers/home.dart';
import 'package:waste_not/controllers/page_controllers/settings.dart';

import '../controllers/model_controllers/products.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // UserController userController = Get.find();
    // HomeController homeController = Get.find();
    // ProductsController productsController = Get.find();
    // DarkModeController darkModeController = Get.find();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
              elevation: 0,
              title: const Text('Recipe suggestions'),
              centerTitle: false),
        ),
        body: SingleChildScrollView(
            child: Expanded(
                child: Center(
                    child: SvgPicture.asset("assets/placeholder.svg")))));
  }
}

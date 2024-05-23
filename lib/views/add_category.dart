import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../models/category.dart';

class AddCategoryView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconPathController = TextEditingController();
  final CategoryController categoryController = Get.find();

  void addCategory() {
    final category = CategoryModel(
      id: '',
      name: _nameController.text,
      iconPath: _iconPathController.text,
    );
    categoryController.addCategory(category);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: _iconPathController,
              decoration: const InputDecoration(labelText: 'Icon Path'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addCategory,
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/category_controller.dart';
// import 'add_category.dart';  // Import the AddCategoryView
//
// class CategoryListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final CategoryController categoryController = Get.put(CategoryController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories'),
//       ),
//       body: Obx(() {
//         if (categoryController.categories.isEmpty) {
//           return const Center(child: Text('No categories found.'));
//         } else {
//           return ListView.builder(
//             itemCount: categoryController.categories.length,
//             itemBuilder: (context, index) {
//               final category = categoryController.categories[index];
//               return ListTile(
//                 title: Text(category.name),
//                 leading: category.iconPath.isNotEmpty
//                     ? Image.network(category.iconPath)
//                     : null,
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () {
//                     categoryController.removeCategory(category.id);
//                   },
//                 ),
//                 onTap: () {
//                   // Handle category tap
//                 },
//               );
//             },
//           );
//         }
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => AddCategoryView());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

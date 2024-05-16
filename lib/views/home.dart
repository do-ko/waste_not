import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/product_list.dart';

import '../controllers/products.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int productsMarked;

  @override
  void initState() {
    super.initState();
    productsMarked = 0;
  }

  @override
  Widget build(BuildContext context) {
    String username = GetStorage().read('username') ??
        "[username]"; // TODO where is username actually?

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
        body: SingleChildScrollView(
            child: Column(children: [
          ProductList(),
        ])),
        bottomNavigationBar: NavigationBar(destinations: [
          IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: productsMarked > 0 ? () => {} : null),
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

// class TestRoute extends StatelessWidget {
//   TestRoute({super.key});
//
//   final emailTextController = TextEditingController();
//   final passwordTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('User testing')),
//         body: SingleChildScrollView(child: Column(children: [
//           StreamBuilder<List<User>>(
//               stream: UserController.readUsers(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('something went wrong ${snapshot.error}');
//                 } else if (snapshot.hasData) {
//                   final users = snapshot.data!;
//                   return Column(
//                       children: users.map((e) => Text(e.email)).toList());
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               }),
//           Column(
//             children: [
//               TextField(
//                   controller: emailTextController,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Email'
//                   )
//               ),
//               const SizedBox(height: 24),
//               TextField(
//                   controller: passwordTextController,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password'
//                   )
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(onPressed: () {
//                   UserController.createUser(email: emailTextController.text, name: passwordTextController.text);
//               }, child: const Text("Create User"))
//             ],
//           )
//         ]))
//     );
//   }
// }

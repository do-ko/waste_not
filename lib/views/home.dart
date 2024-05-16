import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/shared/product_list.dart';

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
              onPressed: () => Navigator.of(context).pushNamed("/settings"),
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
              onPressed: () => Navigator.of(context).pushNamed("/product/add")),
          IconButton(
            icon: const Icon(Icons.live_help_outlined),
            onPressed: () => {},
          )
        ]));
  }
}

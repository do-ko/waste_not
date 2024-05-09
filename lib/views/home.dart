import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_not/views/shared/product_list.dart';

import '../controllers/products.dart';
import '../controllers/user.dart';
import '../firebase_options.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseApp? firebaseApp;
  late User? user;
  int productsMarked = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future<FirebaseApp>(() => Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)),
        builder: (context, firebaseAppSnapshot) {
          firebaseApp = firebaseAppSnapshot.data;

          return Scaffold(
              appBar: AppBar(
                title: const Text('Hello, Dominika!'), // TODO use user.name
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/settings"),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Column(children: [
                Text(firebaseApp == null ? 'Not connected :(' : 'Connected :D'),
                ProductList(productsController: ProductsController())
              ])),
              bottomNavigationBar: NavigationBar(destinations: [
                IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: productsMarked > 0 ? () => {} : null),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/product/add")),
                IconButton(
                  icon: const Icon(Icons.live_help_outlined),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TestRoute())),
                )
              ]));
        });
  }
}

class TestRoute extends StatelessWidget {
  const TestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text('User testing')),
        body: StreamBuilder<List<User>>(
            stream: UserController.readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong ${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                    children: users.map((e) => Text(e.email)).toList());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

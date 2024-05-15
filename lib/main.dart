import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/authentication.dart';
import 'package:waste_not/views/edit_account.dart';
import 'package:waste_not/views/edit_product.dart';
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/product.dart';
import 'package:waste_not/views/settings.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: WasteNotApp()));
}

class WasteNotApp extends ConsumerWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: const AuthenticationView(),
      title: 'Waste Not (WIP)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/auth': (context) => const AuthenticationView(),
        '/home': (context) => const HomeView(),
        '/settings': (context) => const SettingsView(),
        '/account': (context) => const EditAccountView(),
        '/product': (context) =>
            ProductView(productController: ProductController(productId: "0")),
        '/product/edit': (context) => EditProductView(
            productController: ProductController(productId: "0")),
        '/product/add': (context) => const AddProductView()
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/auth.dart';
import 'package:waste_not/controllers/product.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/authentication.dart';
import 'package:waste_not/views/edit_account.dart';
import 'package:waste_not/views/edit_product.dart';
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/product.dart';
import 'package:waste_not/views/register.dart';
import 'package:waste_not/views/settings.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      // .then((FirebaseApp value) => Get.put(AuthenticationController()));

  runApp(const ProviderScope(child: WasteNotApp()));
}

class WasteNotApp extends ConsumerWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: const LoginView(),
      // home: const Scaffold(
      //   backgroundColor: Colors.deepPurple,
      //   body: Center(
      //     child: CircularProgressIndicator(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      title: 'Waste Not (WIP)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
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

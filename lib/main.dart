import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/product.dart';
import 'package:waste_not/repositories/auth.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/auth_check.dart';
import 'package:waste_not/views/edit_account.dart';
import 'package:waste_not/views/edit_product.dart';
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/product.dart';
import 'package:waste_not/views/register.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthRepository()));

  runApp(const WasteNotApp());
}

class WasteNotApp extends StatelessWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Scaffold(
        backgroundColor: loadingScreenBackground,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      title: 'Waste Not (WIP)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundHeaderColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: fontColor,
            fontSize: 24,
          ),
          iconTheme: IconThemeData(
            color: fontColor,
          ),
        ),
      ),
      // routes: {
      //   // '/': (context) => const AuthCheckerView(),
      //   '/login': (context) => const LoginView(),
      //   '/register': (context) => const RegisterView(),
      //   '/home': (context) => const HomeView(),
      //   '/settings': (context) => const SettingsView(),
      //   '/account': (context) => const EditAccountView(),
      //   '/product': (context) =>
      //       ProductView(productController: ProductController(productId: "0")),
      //   '/product/edit': (context) => EditProductView(
      //       productController: ProductController(productId: "0")),
      //   '/product/add': (context) => const AddProductView()
      // },
    );
  }
}

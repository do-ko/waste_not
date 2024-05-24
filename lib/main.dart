import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/shared/auth.dart';
import 'package:waste_not/controllers/shared/sound.dart';
import 'package:waste_not/views/add_product.dart';
import 'package:waste_not/views/edit_account.dart';
import 'package:waste_not/views/edit_product.dart';
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/product.dart';
import 'package:waste_not/views/register.dart';
import 'package:waste_not/views/settings.dart';
import 'package:waste_not/views/shared/theme.dart';
import 'package:waste_not/views/suggestions.dart';

import 'controllers/page_controllers/settings.dart';
import 'firebase_options.dart';
import 'models/product.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(DarkModeController(), permanent: true);
  Get.put(NotificationsController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  Get.put(NotificationsIntervalController(), permanent: true);
  Get.put(SoundController(), permanent: true);

  runApp(const WasteNotApp());
}

class WasteNotApp extends StatelessWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return GetMaterialApp(
      home: const Scaffold(
        backgroundColor: loadingScreenBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: baseThemeColor,
          ),
        ),
      ),
      title: 'Waste Not (WIP)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: baseThemeColor),
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
            )),
      ),
      getPages: [
        //GetPage(name: '/', page: () => const AuthenticationView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/register', page: () => const RegisterView()),
        GetPage(name: '/home', page: () => const HomeView()),
        GetPage(name: '/settings', page: () => const SettingsView()),
        GetPage(name: '/account', page: () => const EditAccountView()),
        GetPage(
          name: '/product',
          page: () => ProductView(
              product: ProductModel(
                  productId: "0",
                  name: "0",
                  category: "0",
                  comment: "0",
                  expirationDate: DateTime.now(),
                  imageLink: "",
                  owner: "")),
        ),
        GetPage(
          name: '/product/edit',
          page: () => const EditProductView(),
        ),
        GetPage(name: '/product/add', page: () => const AddProductView()),
        GetPage(name: '/suggestions', page: () => const SuggestionsView())
      ],
    );
  }
}

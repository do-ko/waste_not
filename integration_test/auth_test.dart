import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_test/integration_test.dart';
import 'package:waste_not/controllers/model_controllers/user.dart';
import 'package:waste_not/controllers/shared/auth.dart';
import 'package:waste_not/main.dart' as app;
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/register.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('register', () {
    tearDown(() async {
      AuthController authController = AuthController.instance;
      UserFirebaseController userFirebaseController = Get.put(UserFirebaseController());
      userFirebaseController.removeUser(authController.authUser!.uid);
      await authController.authUser?.delete();
      Get.reset();
    });

    testWidgets('register successfully', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(LoginView), findsOneWidget);

      final Finder registerNavigateButton =
          find.byKey(const Key('registerNavigateButton'));
      await widgetTester.tap(registerNavigateButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(RegisterView), findsOneWidget);

      await widgetTester.enterText(
          find.byKey(const Key('firstNameField')), 'IntegrationTest');
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      await widgetTester.enterText(
          find.byKey(const Key('emailField')), 'test@wastenot.com');
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      await widgetTester.enterText(
          find.byKey(const Key('passwordField')), 'Password123!');
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      await widgetTester.enterText(
          find.byKey(const Key('repeatPasswordField')), 'Password123!');
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      final Finder registerSubmitButton =
          find.byKey(const Key('registerSubmitButton'));
      await widgetTester.ensureVisible(registerSubmitButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      await widgetTester.tap(registerSubmitButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}

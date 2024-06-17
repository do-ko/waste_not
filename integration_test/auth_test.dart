import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:waste_not/controllers/shared/auth.dart';
import 'package:waste_not/main.dart' as app;
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/register.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('register', () {

    testWidgets('register successfully', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();

      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}

class MockGetStorage {
  final Map<String, dynamic> _storage = {};

  dynamic read(String key) {
    return _storage[key];
  }

  void write(String key, dynamic value) {
    _storage[key] = value;
  }

  void remove(String key) {
    _storage.remove(key);
  }

  void erase() {
    _storage.clear();
  }
}

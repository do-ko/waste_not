import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, Test User!'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('Mock HomeView Body'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.delete_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MockHomeView', () {
    testWidgets('should display the correct title', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MockHomeView(),
        ),
      );

      expect(find.text('Hello, Test User!'), findsOneWidget);
    });

    testWidgets('should display settings icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MockHomeView(),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should display delete icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MockHomeView(),
        ),
      );

      expect(find.byIcon(Icons.delete_rounded), findsOneWidget);
    });

    testWidgets('should display add icon in FloatingActionButton', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MockHomeView(),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}

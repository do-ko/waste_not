import 'package:flutter/material.dart';
import 'package:waste_not/repositories/auth.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () => AuthRepository.instance.logout(),
                  child: const Text("Sign Out")),
            ),
          ],
        ));
  }
}

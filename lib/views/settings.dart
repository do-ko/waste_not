import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waste_not/controllers/auth.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              ref.read(loginControllerProvider.notifier).signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text("Sign Out")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/providers/auth_provider.dart';
import 'package:waste_not/views/home.dart';
import 'package:waste_not/views/login.dart';
import 'package:waste_not/views/settings.dart';

class AuthCheckerView extends ConsumerWidget {
  const AuthCheckerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeView();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/settings');
          });
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const HomeView()));
        } else {
          return const LoginView();
          // Explicitly navigate to the LoginView if user is null
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.of(context).pushReplacementNamed('/login');
          // });
        }
        return const Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
      error: (error, trace) => const LoginView(),
      loading: () => const Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

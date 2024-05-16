import 'package:flutter/material.dart';
import 'package:waste_not/views/home.dart';

class AuthCheckerView extends StatelessWidget {
  const AuthCheckerView({super.key});

  @override
  Widget build(BuildContext context) {
    //final authState = ref.watch(authStateProvider);

    return const HomeView();
    // authState.when(
    //   data: (user) {
    //     if (user != null) {
    //       return const HomeView();
    //     } else {
    //       return const LoginView();
    //     }
    //   },
    //   error: (error, trace) => const LoginView(),
    //   loading: () => const Scaffold(
    //     backgroundColor: Colors.deepPurple,
    //     body: Center(
    //       child: CircularProgressIndicator(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}

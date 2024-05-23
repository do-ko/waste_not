// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:waste_not/providers/auth_provider.dart';
// import 'package:waste_not/views/home.dart';
// import 'package:waste_not/views/login.dart';
// import 'package:waste_not/views/settings.dart';
//
// class AuthCheckerView extends ConsumerWidget {
//   const AuthCheckerView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//
//     return authState.when(
//       data: (user) {
//         if (user != null) {
//           return const HomeView();
//         } else {
//           return const LoginView();
//         }
//       },
//       error: (error, trace) => const LoginView(),
//       loading: () => const Scaffold(
//         backgroundColor: Colors.deepPurple,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

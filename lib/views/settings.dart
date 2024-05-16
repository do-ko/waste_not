import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waste_not/controllers/auth.dart';

// import '../providers/auth_provider.dart';

// class SettingsView extends HookConsumerWidget {
//   const SettingsView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//
//     return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             Center(
//               child: ElevatedButton(
//                   onPressed: () {
//                     ref.read(loginControllerProvider.notifier).signOut();
//                     Navigator.of(context).pushReplacementNamed('/');
//                   },
//                   child: const Text("Sign Out")),
//             ),
//             authState.when(
//                 data: (user) {
//                   return Text(user!.uid);
//                 },
//                 error: (error, trace) => const Text("error"),
//                 loading: () => const Text("loading"))
//           ],
//         ));
//   }
// }

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text("test"),
    );
  }
}

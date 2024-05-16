import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    //ref.read(loginControllerProvider.notifier).signOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Text("Sign Out")),
            ),
            // authState.when(
            //     data: (user) {
            //       return Text(user!.uid);
            //     },
            //     error: (error, trace) => const Text("error"),
            //     loading: () => const Text("loading"))
          ],
        ));
  }
}

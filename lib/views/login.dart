import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:waste_not/controllers/auth.dart';

class LoginView extends StatefulHookConsumerWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 24, bottom: 24, right: 24),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "WasteNot",
                  style: TextStyle(fontSize: 48, fontFamily: "serif"),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(CupertinoIcons.mail),
                    ),
                    controller: email,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(CupertinoIcons.lock),
                      suffixIcon: Icon(CupertinoIcons.eye),
                    ),
                    controller: password,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          const Text("Remember Me")
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password?"))
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(loginControllerProvider.notifier)
                              .login(email.text, password.text);
                        },
                        child: const Text("Sign in")),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed("/register")},
                        child: const Text("Create account")),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

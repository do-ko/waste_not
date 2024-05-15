import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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

                          TextButton(onPressed: () {},
                              child: const Text("Forgot password?"))
                        ],
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      SizedBox(width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Sign in")),),

                      const SizedBox(
                        height: 16,
                      ),

                      SizedBox(width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () => {Navigator.of(context).pushNamed("/register")}, child: const Text("Create account")),)


                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

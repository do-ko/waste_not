import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, bottom: 24, right: 24),
          child: Column(
            children: [
              const Text("Let's create your account!",
                  style: TextStyle(fontSize: 20, fontFamily: "serif", fontWeight: FontWeight.bold)),

              const SizedBox(
                height: 32,
              ),

              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(CupertinoIcons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                ],
              )),

              const SizedBox(
                height: 32,
              ),

              SizedBox(width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => {Navigator.of(context).pushNamed("/register")}, child: const Text("Create account")),)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/login.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginView()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 64, left: 24, bottom: 24, right: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.mail_solid,
                    size: 100,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Verify your email!",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "serif",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "support@email.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "serif",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Congratulations! Your Account Awaits. Verify your Email to start using the app.",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "serif",
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Verify")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

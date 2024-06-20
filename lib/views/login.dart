import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/page_controllers/login.dart';
import 'package:waste_not/controllers/shared/validator.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 24, bottom: 24, right: 24),
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
              Obx(() => Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('emailField'),
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(CupertinoIcons.mail),
                        ),
                        controller: controller.email,
                        validator: (value) =>
                            CustomValidator.validateEmail(value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          key: const Key('passwordField'),
                          obscureText: controller.hidePassword.value,
                          controller: controller.password,
                          validator: (value) =>
                              CustomValidator.validatePassword(value),
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: Icon(controller.hidePassword.value
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash)),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (value) => controller.rememberMe
                                        .value = !controller.rememberMe.value),
                              ),
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
                            key: const Key('loginSubmitButton'),
                            onPressed: () => {controller.signIn()},
                            child: const Text("Sign in")),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            key: const Key('registerNavigateButton'),
                            onPressed: () => {Get.toNamed("/register")},
                            child: const Text("Create account")),
                      )
                    ],
                  )))
            ],
          ),
        ),
      ),
    );
  }
}

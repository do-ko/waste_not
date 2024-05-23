import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/page_controllers/signup.dart';
import 'package:waste_not/controllers/shared/validator.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, bottom: 24, right: 24),
          child: Column(
            children: [
              const Text("Let's create your account!",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "serif",
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 32,
              ),
              Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(CupertinoIcons.person),
                        ),
                        controller: controller.username,
                        validator: (value) => CustomValidator.validateEmptyText(
                            "Username", value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
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
                      Obx(
                        () => TextFormField(
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
                                    : CupertinoIcons.eye_fill)),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => {controller.signUp()},
                    child: const Text("Create account")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

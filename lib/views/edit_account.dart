import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/user.dart';
import 'package:waste_not/controllers/page_controllers/edit_account.dart';
import 'package:waste_not/controllers/shared/validator.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/shared/auth.dart';

class EditAccountView extends StatelessWidget {
  const EditAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditAccountController editAccountController =
        Get.put(EditAccountController());
    final UserController userController = Get.find();

    return Scaffold(
        appBar: AppBar(title: const Text('Edit account')),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Change Username",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: fontColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: editAccountController.editUsernameFormKey,
                      child: TextFormField(
                        controller:
                            editAccountController.usernameTextController,
                        validator: (value) =>
                            CustomValidator.validateFieldNotEmpty(
                                "Username", value),
                        decoration: const InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: fontColorBlue),
                          filled: true,
                          fillColor: containerColor,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editAccountController.editUsername();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryBlue,
                        minimumSize: const Size(180, 36),
                      ),
                      child: const Text(
                        'Confirm Name',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const Text(
                      "Change Email",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: fontColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                        key: editAccountController.editEmailFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              canRequestFocus: false,
                              readOnly: true,
                              controller:
                                  editAccountController.oldEmailTextController,
                              validator: (value) {
                                if (value != userController.user.value.email) {
                                  return "Wrong old email provided.";
                                } else {
                                  return CustomValidator.validateEmail(value);
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: "Old Email",
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: fontColorBlue),
                                filled: true,
                                fillColor: containerColor,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller:
                                  editAccountController.newEmailTextController,
                              validator: (value) =>
                                  CustomValidator.validateEmail(value),
                              decoration: const InputDecoration(
                                labelText: "New Email",
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: fontColorBlue),
                                filled: true,
                                fillColor: containerColor,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editAccountController.editEmail();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryBlue,
                        minimumSize: const Size(180, 36),
                      ),
                      child: const Text(
                        'Confirm Email',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const Text(
                      "Change Password",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: fontColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: editAccountController.editPasswordFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            // controller: controller.password,
                            obscureText: true,
                            validator: (value) {
                              if (AuthController.instance.authUser != null) {
                                CustomValidator.validatePassword(value);
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "Old Password",
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: fontColorBlue),
                              filled: true,
                              fillColor: containerColor,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            // controller: controller.password,
                            obscureText: true,

                            validator: (value) =>
                                CustomValidator.validatePassword(value),
                            decoration: const InputDecoration(
                              labelText: "New Password",
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: fontColorBlue),
                              filled: true,
                              fillColor: containerColor,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            // controller: controller.password,
                            obscureText: true,
                            validator: (value) =>
                                CustomValidator.validatePassword(value),
                            decoration: const InputDecoration(
                              labelText: "Repeat New Password",
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: fontColorBlue),
                              filled: true,
                              fillColor: containerColor,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: primaryBlue,
                              minimumSize: const Size(180, 36),
                            ),
                            child: const Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

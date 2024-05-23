import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/controllers/user_controller.dart';
import 'package:waste_not/views/edit_account.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    String username = GetStorage().read('username') ?? "[username]";
    String email = GetStorage().read('email') ?? "[email]";
    List<int> intervals = [1, 2, 3];
    DarkModeController darkModeController = Get.find();
    NotificationsController notificationsController = Get.find();
    LanguageController languageController = Get.find();
    NotificationsIntervalController notificationsIntervalController =
        Get.find();
    UserController userController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        const Text(
                          "You are logged in as ",
                          style: TextStyle(
                            fontSize: 24,
                            color: fontColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            userController.user.value.username,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: fontColor,
                            ),
                          ),
                        ),
                        const Text(
                          ".",
                          style: TextStyle(
                            fontSize: 24,
                            color: fontColor,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Text(
                        userController.user.value.email,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: fontColorLight),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: containerColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the Card's border radius
                ),
                shadowColor: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.to(const EditAccountView()),
                  splashColor: containerColorSplash,
                  borderRadius: BorderRadius.circular(15),
                  // Match InkWell's border radius with Card's
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Account",
                          style: TextStyle(
                            fontSize: 20,
                            color: fontColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Obx(
                    () => Card(
                      color: containerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set the Card's border radius
                      ),
                      shadowColor: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          notificationsController.notifications.value =
                              !notificationsController.notifications.value;
                        },
                        splashColor: containerColorSplash,
                        borderRadius: BorderRadius.circular(15),
                        // Match InkWell's border radius with Card's
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Notifications",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: fontColor,
                                ),
                              ),
                              Switch(
                                activeTrackColor: primaryBlue,
                                value:
                                    notificationsController.notifications.value,
                                onChanged: (value) {
                                  notificationsController.notifications.value =
                                      value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => Card(
                      color: containerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set the Card's border radius
                      ),
                      shadowColor: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          darkModeController.darkMode.value =
                              !darkModeController.darkMode.value;
                        },
                        splashColor: containerColorSplash,
                        borderRadius: BorderRadius.circular(15),
                        // Match InkWell's border radius with Card's
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: fontColor,
                                ),
                              ),
                              Switch(
                                activeTrackColor: primaryBlue,
                                value: darkModeController.darkMode.value,
                                onChanged: (value) {
                                  darkModeController.darkMode.value = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    color: containerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Set the Card's border radius
                    ),
                    shadowColor: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      splashColor: containerColorSplash,
                      borderRadius: BorderRadius.circular(15),
                      // Match InkWell's border radius with Card's
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 20,
                                color: fontColor,
                              ),
                            ),
                            Obx(
                              () => DropdownButton<String>(
                                value: languageController.language.value,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 32,
                                ),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    languageController.updateLanguage(newValue);
                                  }
                                },
                                items: languageController.languages
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        color: fontColor,
                                      ),
                                    ),
                                  );
                                }).toList(), // Ensure this is a synchronous operation
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    color: containerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Set the Card's border radius
                    ),
                    shadowColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Notification Interval",
                            style: TextStyle(
                              fontSize: 20,
                              color: fontColor,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: intervals.map((interval) {
                              return Obx(() => InkWell(
                                    onTap: () => notificationsIntervalController
                                        .updateInterval(interval),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: notificationsIntervalController
                                                      .notificationInterval
                                                      .value ==
                                                  interval
                                              ? primaryBlue
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        interval.toString(),
                                        style: TextStyle(
                                          color: notificationsIntervalController
                                                      .notificationInterval
                                                      .value ==
                                                  interval
                                              ? Colors.white
                                              : fontColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => AuthController.instance.logout(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryBlue,
                    minimumSize: const Size(180, 36),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

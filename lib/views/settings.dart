import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/shared/theme.dart';
import '../controllers/settings_controller.dart';
import '../repositories/auth.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    String username = GetStorage().read('username') ?? "[username]";
    String email = GetStorage().read('email') ?? "[email]";
    DarkModeController darkModeController = Get.find();
    NotificationsController notificationsController = Get.find();

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
                          style: TextStyle(fontSize: 24, color: fontColor),
                        ),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: fontColor,
                          ),
                        ),
                        const Text(
                          ".",
                          style: TextStyle(fontSize: 24, color: fontColor),
                        ),
                      ],
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: fontColorLight),
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
                  onTap: () {},
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
                          style: TextStyle(fontSize: 20),
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
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Notifications",
                                style: TextStyle(fontSize: 20),
                              ),
                              Switch(
                                value:
                                    notificationsController.notifications.value,
                                onChanged: (value) {
                                  notificationsController.notifications.value =
                                      !notificationsController
                                          .notifications.value;
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
                              Text(
                                "Dark Mode",
                                style: TextStyle(fontSize: 20),
                              ),
                              Switch(
                                value: darkModeController.darkMode.value,
                                onChanged: (value) {
                                  darkModeController.darkMode.value =
                                      !darkModeController.darkMode.value;
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
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Language",
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 32,
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
                            Text(
                              "Notification Interval",
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Text(
                                  "  |  ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Text(
                                  "  |  ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "5",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                  onPressed: () => AuthRepository.instance.logout(),
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

// // Column(
// // children: [
// // Center(
// // child: ElevatedButton(
// // onPressed: () => AuthRepository.instance.logout(),
// // child: const Text("Sign Out")),
// // ),
// // ],
// // ),
//
// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     appBar: AppBar(
// //       title: Text('Settings'),
// //       leading: BackButton(),
// //     ),
// //     body: ListView(
// //       children: [
// //         ListTile(
// //           title: Text('You are logged in as Dominika'),
// //           subtitle: Text('email@email.com'),
// //         ),
// //         ListTile(
// //           title: Text('Edit Account'),
// //           trailing: Icon(Icons.navigate_next),
// //           onTap: () {
// //             // Navigate to edit account page
// //           },
// //         ),
// //         SwitchListTile(
// //           title: Text('Notifications'), value: true, onChanged: (bool value) {  },
// //
// //         ),
// //         SwitchListTile(
// //           title: Text('Dark Mode'), value: false, onChanged: (bool value) {  },
// //
// //         ),
// //         ListTile(
// //           title: Text('Language'),
// //           trailing: Icon(Icons.navigate_next),
// //           onTap: () {
// //             // Navigate to language settings page
// //           },
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Text('Notification interval'),
// //         ),
// //         RadioListTile<int>(
// //           title: Text('1'),
// //           value: 1, groupValue: null, onChanged: (int? value) {  },
// //
// //         ),
// //         RadioListTile<int>(
// //           title: Text('3'),
// //           value: 3, groupValue: null, onChanged: (int? value) {  },
// //
// //         ),
// //         RadioListTile<int>(
// //           title: Text('5'),
// //           value: 5, groupValue: null, onChanged: (int? value) {  },
// //
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //           child: ElevatedButton(
// //             onPressed: () {
// //               // Handle logout
// //             },
// //             child: Text('Logout'),
// //             style: ElevatedButton.styleFrom(
// //               foregroundColor: Colors.white, backgroundColor: Colors.blue,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
// }

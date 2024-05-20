// import 'package:flutter/material.dart';
//
// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key});
//
//   @override
//   _SettingsViewState createState() => _SettingsViewState();
// }
//
// class _SettingsViewState extends State<SettingsView> {
//   bool _notificationsEnabled = true;
//   bool _darkMode = false;
//   int _notificationInterval = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         actions: [
//           if (isLandscape)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Logout'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                 ),
//               ),
//             ),
//         ],
//       ),
//       body: isLandscape ? buildHorizontalLayout() : buildVerticalLayout(),
//       bottomNavigationBar: !isLandscape
//           ? Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ElevatedButton(
//           onPressed: () {},
//           child: Text('Logout'),
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white, backgroundColor: Colors.blue,
//             minimumSize: Size(double.infinity, 50), // Ensures the button stretches to fill the width
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   Widget buildVerticalLayout() {
//     return ListView(
//       children: buildSettingsItems(),
//     );
//   }
//
//   Widget buildHorizontalLayout() {
//     return Row(
//       children: [
//         Expanded(
//           child: ListView(
//             children: buildSettingsItems(),
//           ),
//         ),
//         VerticalDivider(width: 1),
//         Expanded(
//           child: ListView(
//             children: [
//               SwitchListTile(
//                 title: Text('Dark Mode'),
//                 value: _darkMode,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _darkMode = value;
//                   });
//                 },
//               ),
//               SwitchListTile(
//                 title: Text('Notifications'),
//                 value: _notificationsEnabled,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _notificationsEnabled = value;
//                   });
//                 },
//               ),
//               ListTile(
//                 title: Text('Language'),
//                 trailing: Icon(Icons.navigate_next),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text('Notification interval'),
//               ),
//               RadioListTile<int>(
//                 title: Text('1'),
//                 value: 1,
//                 groupValue: _notificationInterval,
//                 onChanged: (int? value) {
//                   setState(() {
//                     _notificationInterval = value!;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('3'),
//                 value: 3,
//                 groupValue: _notificationInterval,
//                 onChanged: (int? value) {
//                   setState(() {
//                     _notificationInterval = value!;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('5'),
//                 value: 5,
//                 groupValue: _notificationInterval,
//                 onChanged: (int? value) {
//                   setState(() {
//                     _notificationInterval = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> buildSettingsItems() {
//     return [
//       ListTile(
//         title: Text('You are logged in as Dominika'),
//         subtitle: Text('email@email.com'),
//       ),
//       ListTile(
//         title: Text('Edit Account'),
//         trailing: Icon(Icons.navigate_next),
//         onTap: () {
//           // Navigate to edit account page
//         },
//       ),
//     ];
//   }
// }

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../repositories/auth.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    String username = GetStorage().read('username') ?? "[username]";
    String email = GetStorage().read('email') ?? "[email]";

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
                              "Notifications",
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
                              "Dark Mode",
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

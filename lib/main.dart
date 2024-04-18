import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_not/views/home.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future<FirebaseApp>(() => Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)),
        builder: (context, firebaseAppSnapshot) {
          //String firebaseStatus = 'not connected';
          FirebaseApp? firebaseApp = firebaseAppSnapshot.data;

          // if (firebaseAppSnapshot.connectionState == ConnectionState.done) {
          //   if (firebaseAppSnapshot.hasError) {
          //     firebaseStatus = 'error connecting';
          //   } else {
          //     firebaseStatus = 'Connected! :D';
          //   }
          // }

          return MaterialApp(
            title: 'Waste Not (WIP)',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: HomePage(
                title: 'WasteNot Demo Home Page', firebaseApp: firebaseApp),
          );
        });
  }
}

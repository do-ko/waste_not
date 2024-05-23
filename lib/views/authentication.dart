import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import '../controllers/login_controller.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<StatefulWidget> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  final LoginController loginController = Get.put(LoginController());
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: nameTextController,
                decoration: const InputDecoration(
                  hintText: "name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: emailTextController,
                decoration: const InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: passwordTextController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  signupController.email.text = emailTextController.text;
                  signupController.password.text = passwordTextController.text;
                  signupController.username.text = nameTextController.text;
                  await signupController.signUp();
                },
                child: const Text("Register"),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  loginController.email.text = emailTextController.text;
                  loginController.password.text = passwordTextController.text;
                  await loginController.login();
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../controllers/auth.dart';
// import 'home.dart';

// class AuthenticationView extends StatefulWidget {
//   const AuthenticationView({super.key});

//   @override
//   State<StatefulWidget> createState() => _AuthenticationViewState();
// }

// class _AuthenticationViewState extends State<AuthenticationView> {
//   TextEditingController emailTextController = TextEditingController();
//   TextEditingController passwordTextController = TextEditingController();
//   TextEditingController nameTextController = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         height: MediaQuery
//             .of(context)
//             .size
//             .height,
//         decoration: const BoxDecoration(
//           color: Colors.deepPurple,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: nameTextController,
//                 decoration: const InputDecoration(
//                   hintText: "name",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   labelText: "Name",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery
//                 .of(context)
//                 .size
//                 .height / 35),
//             SizedBox(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: emailTextController,
//                 decoration: const InputDecoration(
//                   hintText: "something@email.com",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   labelText: "Email",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery
//                 .of(context)
//                 .size
//                 .height / 35),
//             SizedBox(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: passwordTextController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: "password",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   labelText: "Password",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: MediaQuery
//                 .of(context)
//                 .size
//                 .height / 35),
//             Container(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 onPressed: () async {
//                   // bool shouldNavigate =
//                   // await AuthController.register(emailTextController.text, passwordTextController.text, nameTextController.text);
//                   // if (shouldNavigate) {
//                   //   Navigator.pushReplacement(
//                   //     context,
//                   //     MaterialPageRoute(builder: (context) => const HomeView()),
//                   //   );
//                   // }
//                 },
//                 child: const Text("Register"),
//               ),
//             ),
//             SizedBox(height: MediaQuery
//                 .of(context)
//                 .size
//                 .height / 35),
//             Container(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                   onPressed: () async {
//                     // bool shouldNavigate =
//                     // await AuthController.signIn(emailTextController.text, passwordTextController.text);
//                     // if (shouldNavigate) {
//                     //   Navigator.pushReplacement(
//                     //     context,
//                     //     MaterialPageRoute(builder: (context) => const HomeView()),
//                     //   );
//                     // }
//                   },
//                   child: const Text("Login")),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
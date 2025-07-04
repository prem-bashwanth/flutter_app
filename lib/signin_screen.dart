// import 'package:flutter/material.dart';
// import 'package:new_project/resources/authentication_methods.dart';
// import 'package:new_project/signup_screen.dart';
// import 'package:new_project/utils.dart';
// import 'package:new_project/custombutton.dart';
// import 'package:new_project/text_field_widget.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   AuthenticationMethods authenticationMethods = AuthenticationMethods();
//   bool isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = Utils().getScreenSize();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Welcome back!",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFieldWidget(
//                   title: "Email",
//                   controller: emailController,
//                   obscureText: false,
//                   hintText: "Enter your email",
//                 ),
//                 SizedBox(height: 20),
//                 TextFieldWidget(
//                   title: "Password",
//                   controller: passwordController,
//                   obscureText: true,
//                   hintText: "Enter your password",
//                 ),
//                 SizedBox(height: 20),
//                 CustomMainButton(
//                   child: isLoading
//                       ? CircularProgressIndicator()
//                       : Text(
//                           "Sign In",
//                           style: TextStyle(
//                             fontSize: 16,
//                             letterSpacing: 0.6,
//                             color: Colors.white,
//                           ),
//                         ),
//                         isLoading: isLoading,
//                   color: Colors.blue,
//                   onPressed: () async {
//                     setState(() {
//                       isLoading = true;
//                     });

//                     String output = await authenticationMethods.signInUser(
//                       email: emailController.text,
//                       password: passwordController.text,
//                     );

//                     setState(() {
//                       isLoading = false;
//                     });

//                     if (output == "success") {
//                       Navigator.pushReplacementNamed(context, '/home');
//                     } else {
//                       Utils().showSnackBar(context: context, content: output);
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "New to Salon booking? ",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignUpScreen()),
//                         );
//                       },
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(fontSize: 14, color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/common_widgets.dart/text_field_widget.dart';
import 'package:new_project/custombutton.dart';
import 'package:new_project/resources/authentication_methods.dart';
import 'package:new_project/signup_screen.dart';
import 'package:new_project/utils.dart'; // Add this line if you want to use SVG images for logos
import 'package:new_project/google_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  title: "Email",
                  controller: emailController,
                  obscureText: false,
                  hintText: "Enter your email",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  title: "Password",
                  controller: passwordController,
                  obscureText: true,
                  hintText: "Enter your password",
                ),
                SizedBox(height: 20),
                CustomMainButton(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.6,
                            color: Colors.white,
                          ),
                        ),
                  isLoading: isLoading,
                  color: Colors.blue,
                  onPressed: () => performSignIn(),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async  {
  UserCredential? userCredential = await authenticationMethods.signInWithGoogle();
  Navigator.pushReplacementNamed(context, '/home');

  // Check if the sign-in was successful
//   if (userCredential!.user != null) {
//     // If the sign-in was successful, navigate to the home page
//     Navigator.pushReplacementNamed(context, '/home');
//   } else {
//     // If the sign-in was not successful, show an error message
//     print('Google sign-in failed');
// }
},

                  child: Image.asset('assets/icons/google_logo.png', height: 36), // Make sure you have this asset
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to Salon booking? ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void performSignIn() async {
    setState(() {
      isLoading = true;
    });

    String output = await authenticationMethods.signInUser(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    handleSignInResponse(output);
  }

  void handleSignInResponse(String output) {
    if (output == "success") {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Utils().showSnackBar(context: context, content: output);
    }
  }

  // Future<void> navigateBasedOnUserRole() async {
  //   // Retrieve userType from Firebase and navigate accordingly
  //   String userType = await getUserTypeFromFirebase();
  //   if (userType == 'barber') {
  //     Navigator.pushReplacementNamed(context, '/barberhome');
  //   } else {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }
}

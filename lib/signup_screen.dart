// import 'package:flutter/material.dart';
// import 'package:new_project/resources/authentication_methods.dart';
// import 'package:new_project/signin_screen.dart';
// import 'package:new_project/utils.dart';
// import 'package:new_project/custombutton.dart';
// import 'package:new_project/text_field_widget.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   AuthenticationMethods authenticationMethods = AuthenticationMethods();
//   bool isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     addressController.dispose();
//     passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   "Sign-Up",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFieldWidget(
//                   title: "Name",
//                   controller: nameController,
//                   obscureText: false,
//                   hintText: "Enter your name",
//                 ),
//                 const SizedBox(height: 10),
//                 TextFieldWidget(
//                   title: "Address",
//                   controller: addressController,
//                   obscureText: false,
//                   hintText: "Enter your address",
//                 ),
//                 const SizedBox(height: 10),
//                 TextFieldWidget(
//                   title: "Email",
//                   controller: emailController,
//                   obscureText: false,
//                   hintText: "Enter your email",
//                 ),
//                 const SizedBox(height: 10),
//                 TextFieldWidget(
//                   title: "Password",
//                   controller: passwordController,
//                   obscureText: true,
//                   hintText: "Enter your password",
//                 ),
//                 const SizedBox(height: 20),
//                 CustomMainButton(
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       letterSpacing: 0.6,
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                   color: Colors.blue,
//                   isLoading: isLoading,
//                   onPressed: () async {
//                     setState(() {
//                       isLoading = true;
//                     });
//                     String output = await authenticationMethods.signUpUser(
//                       name: nameController.text,
//                       address: addressController.text,
//                       email: emailController.text,
//                       password: passwordController.text,
//                     );
//                     setState(() {
//                       isLoading = false;
//                     });
//                     if (output == "success") {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const SignInScreen(),
//                         ),
//                       );
//                     } else {
//                       Utils().showSnackBar(context: context, content: output);
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SignInScreen(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     "Already have an account? Sign in",
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:new_project/resources/authentication_methods.dart';
import 'package:new_project/signin_screen.dart';
import 'package:new_project/utils.dart';
import 'package:new_project/common_widgets.dart/custom_main_button.dart';
import 'package:new_project/common_widgets.dart/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
   String userType = 'user'; 

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height * 0.85,
                        width: screenSize.width * 0.8,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign-Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 33),
                            ),
                            TextFieldWidget(
                              title: "Name",
                              controller: nameController,
                              obscureText: false,
                              hintText: "Enter your name",
                            ),
                            TextFieldWidget(
                              title: "Address",
                              controller: addressController,
                              obscureText: false,
                              hintText: "Enter your address",
                            ),
                            TextFieldWidget(
                              title: "Email",
                              controller: emailController,
                              obscureText: false,
                              hintText: "Enter your email",
                            ),
                            TextFieldWidget(
                              title: "Password",
                              controller: passwordController,
                              obscureText: true,
                              hintText: "Enter your password",
                            ),
                            DropdownButton<String>(
      value: userType,
      items: <String>['user', 'barber'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          userType = newValue!;
        });
      },
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      letterSpacing: 0.6, color: Colors.black),
                                ),
                                color: Color.fromARGB(255, 179, 216, 246),
                                isLoading: isLoading,
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String output =
                                      await authenticationMethods.signUpUser(
                                          name: nameController.text,
                                          address: addressController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          userType: userType, );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (output == "success") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignInScreen()));
                                  } else {
                                    //error
                                    Utils().showSnackBar(
                                        context: context, content: output);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomMainButton(
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignInScreen();
                        }));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

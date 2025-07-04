// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:new_project/models/user_details_model.dart';
//  import 'package:new_project/resources/cloudfirestore_methods.dart';
//  import 'package:cloud_firestore/cloud_firestore.dart';
//  import 'package:firebase_auth/firebase_auth.dart';

// // class AuthenticationMethods {
// //    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// //    CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

// //   Future<String> signUpUser(
// //       {required String name,
// //       required String address,
// //       required String email,
// //       required String password}) async {
// //     name.trim();
// //     address.trim();
// //     email.trim();
// //     password.trim();
// //     String output = "Something went wrong";
// //     if (name != "" && address != "" && email != "" && password != "") {
// //       try {
// //         await firebaseAuth.createUserWithEmailAndPassword(
// //             email: email, password: password);
// //            UserDetailsModel user = UserDetailsModel(name: name, address: address);
// //            await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user);
// //         output = "success";
// //       } on FirebaseAuthException catch (e) {
// //         output = e.message.toString();
// //       }
// //     } else {
// //       output = "Please fill up all the fields.";
// //     }
// //     return output;
// //   }

// //   Future<String> signInUser(
// //       {required String email, required String password}) async {
// //     email.trim();
// //     password.trim();
// //     String output = "Something went wrong";
// //     if (email != "" && password != "") {
// //       try {
// //         await firebaseAuth.signInWithEmailAndPassword(
// //             email: email, password: password);
// //         output = "success";
// //       } on FirebaseAuthException catch (e) {
// //         output = e.message.toString();
// //       }
// //     } else {
// //       output = "Please fill up all the fields.";
// //     }
// //     return output;
// //   }
// // }


// class AuthenticationMethods {
//    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

//   Future signInWithGoogle() async {
//   // Get the currently signed-in user
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   // If the user is not signed in, initiate the Google Sign-In process
//   if (currentUser == null) {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    
//     // Check if the sign-in was cancelled
//     if (gUser == null) {
//       print('Google sign-in was cancelled');
//       return;
//     }

//     final GoogleSignInAuthentication gAuth = await gUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     try {
//       // Sign in with the credential
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

//       // Get the signed-in user
//       final User? user = userCredential.user;

//       if (user != null) {
//         // Call signInWithGoogleAndUploadToDatabase function
//         await cloudFirestoreClass.signInWithGoogleAndUploadToDatabase();
//       } else {
//         print('Failed to get the signed-in user');
//       }
//     } catch (e) {
//       print('Error signing in with Google: $e');
//     }
//   } else {
//     print('User is already signed in');
//   }
// }

//   Future<String> signUpUser(
//       {required String name,
//       required String address,
//       required String email,
//       required String password,
//       required String userType,}) async {
//     name.trim();
//     address.trim();
//     email.trim();
//     password.trim();
//     String output = "Something went wrong";
//     if (name != "" && address != "" && email != "" && password != "") {
//       try {
//         await firebaseAuth.createUserWithEmailAndPassword(
//             email: email, password: password);
//            UserDetailsModel user = UserDetailsModel(name: name, address: address, userType: userType, email: email);
//            await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user, userType: userType );
//         output = "success";
//       } on FirebaseAuthException catch (e) {
//         output = e.message.toString();
//       }
//     } else {
//       output = "Please fill up all the fields.";
//     }
//     return output;
//   }

//   Future<String> signInUser(
//       {required String email, required String password}) async {
//     email.trim();
//     password.trim();
//     String output = "Something went wrong";
//     if (email != "" && password != "") {
//       try {
//         await firebaseAuth.signInWithEmailAndPassword(
//             email: email, password: password);
//         output = "success";
//       } on FirebaseAuthException catch (e) {
//         output = e.message.toString();
//       }
//     } else {
//       output = "Please fill up all the fields.";
//     }
//     return output;
//   }
// }
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_project/models/user_details_model.dart';
import 'package:new_project/resources/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

Future signInWithGoogle() async {
  print('Starting Google sign-in process');
  // Get the currently signed-in user
  User? currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  // Check if the sign-in was cancelled
  if (gUser == null) {
    print('Google sign-in was cancelled');
    return;
  }
  final GoogleSignInAuthentication gAuth = await gUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );

  try {
    // Sign in with the credential
    print('Signing in with Google credential');
   

    UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the signed-in user
    final User? user = userCredential.user;

    if (user != null) {
      // Call signInWithGoogleAndUploadToDatabase function
      print('User signed in successfully, uploading to database');
      await cloudFirestoreClass.signInWithGoogleAndUploadToDatabase();
    } else {
      print('Failed to get the signed-in user');
    }
  } catch (e) {
    print('Error signing in with Google: $e');
  }
}















  // Future<UserCredential?> signInWithGoogle() async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;

  //   if (currentUser == null) {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //     if (gUser == null) {
  //       print('Google sign-in was cancelled');
  //       return null;
  //     }

  //     final GoogleSignInAuthentication gAuth = await gUser.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken,
  //       idToken: gAuth.idToken,
  //     );

  //     try {
  //       UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  //       final User? user = userCredential.user;

  //       if (user != null) {
  //         await cloudFirestoreClass.signInWithGoogleAndUploadToDatabase();
  //       } else {
  //         print('Failed to get the signed-in user');
  //       }
  //       return userCredential;
  //     } catch (e) {
  //       print('Error signing in with Google: $e');
  //       return null;
  //     }
  //   } else {
  //     print('User is already signed in');
  //     return null;
  //   }
  // }

  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
    required String userType,
  }) async {
    name = name.trim();
    address = address.trim();
    email = email.trim();
    password = password.trim();
    String output = "Something went wrong";

    if (name.isNotEmpty && address.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserDetailsModel user = UserDetailsModel(
          name: name,
          address: address,
          userType: userType,
          email: email,
        );

        await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user, userType: userType);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    email = email.trim();
    password = password.trim();
    String output = "Something went wrong";

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          output = "success";
        } else {
          output = "Sign-in failed";
        }
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }
}

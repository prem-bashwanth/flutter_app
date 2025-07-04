import 'package:new_project/models/user_details_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// class CloudFirestoreClass {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   Future uploadNameAndAddressToDatabase(
//       {required UserDetailsModel user}) async {
//     await firebaseFirestore
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .set(user.getJson());
//   }

//   Future getNameAndAddress() async {
//     DocumentSnapshot snap = await firebaseFirestore
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .get();

//     UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
//       (snap.data() as dynamic),
//     );

//     return userModel;
//   }
// }

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModel user, required String userType}) async {
    String collectionName;

    // Determine the collection name based on the userType
    if (userType == 'user') {
      collectionName = 'users';
    } else if (userType == 'barber') {
      collectionName = 'barbers';
    } else {
      throw Exception('Invalid userType');
    }

    await firebaseFirestore
        .collection(collectionName)
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

 Future signInWithGoogleAndUploadToDatabase() async {
  print('Starting signInWithGoogleAndUploadToDatabase function');
  
  // Get the currently signed-in user
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    print('User is signed in, creating UserDetailsModel instance');

    // Create a UserDetailsModel instance
    UserDetailsModel userDetails = UserDetailsModel(
      name: user.displayName ?? '', // Use the displayName as the name
      address: '', // Set address as null
      userType: 'user',
      email: user.email ?? '', // Use the provided userType
    );

    print('UserDetailsModel instance created, storing user details in Firestore');

    // Create a reference to the Firestore collection
    final CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Store the user's details in Firestore
    return users.doc(user.uid).set(userDetails.getJson()).then((value) => print("User details added to Firestore")).catchError((error) => print("Failed to add user details: $error"));
  } else {
    print('No user is currently signed in.');
  }
}


  Future getNameAndAddressFromDatabase(
      {required String userType}) async {
        String collectionName;

    // Determine the collection name based on the userType
    if (userType == 'user') {
      collectionName = 'users';
    } else if (userType == 'barber') {
      collectionName = 'barbers';
    } else {
      throw Exception('Invalid userType');
    }
    DocumentSnapshot snap = await firebaseFirestore
        .collection(collectionName)
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }
}


// class CloudFirestoreClass {
//    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   Future uploadNameAndAddressToDatabase(
//       {required UserDetailsModel user, required String userType}) async { 
//         // new parameter
//         // if(userType=='user'){
//         //   String x="users";
//         //   await firebaseFirestore
//         // .collection(x) // use userType as collection name
//         // .doc(firebaseAuth.currentUser!.uid)
//         // .set(user.getJson());
//         // }else{
//           await firebaseFirestore
//         .collection("users") // use userType as collection name
//         .doc(firebaseAuth.currentUser!.uid)
//         .set(user.getJson());
//         //}
    
//   }

//   // Future uploadNameAndAddressToBarbersDatabase(
//   //     {required UserDetailsModel user}) async { // new method
//   //   await firebaseFirestore
//   //       .collection("barber")
//   //       .doc(firebaseAuth.currentUser!.uid)
//   //       .set(user.getJson());
//   // }

//   Future getNameAndAddressFromDatabase(
//       {required String userType}) async { // new parameter
//     DocumentSnapshot snap = await firebaseFirestore
//         .collection(userType) // use userType as collection name
//         .doc(firebaseAuth.currentUser!.uid)
//         .get();

//     UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
//       (snap.data() as dynamic),
//     );

//     return userModel;
//   }

// }

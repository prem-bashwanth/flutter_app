import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_project/bookings_screen/bookings_screen.dart';
import 'package:new_project/editprofile_screen.dart';
// import 'package:salon_main/screens/sign_in_screen.dart';
import 'package:new_project/custombutton.dart';


import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
   GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8, // Adjust this value as needed.
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: <Widget>[
                    Icon(Icons.account_circle_outlined, size: 100),
                    Text(data['name']), // User's name from Firebase.
                    Text(user?.email ?? 'No email'), // User's email from Firebase.
                    // ... rest of your code ...
                     ListView(
            shrinkWrap: true,
            children: <Widget>[
              

ElevatedButton(
  onPressed: () async {
     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>MyBookingsScreen()),
                        );

  },
  child: Text('My Bookings'),
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.white, // This sets the text color to black.
  ),
),


              
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to the "Offers & Deals" page.
                },
                child: Text('Offers & Deals'),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white, // This sets the text color to black.
  ),
              ),
              
  //             ElevatedButton(
  //               onPressed: () {
  //                 // TODO: Navigate to the "My Reviews" page.
  //               },
  //               child: Text('My Reviews'),
  //               style: ElevatedButton.styleFrom(
  //   primary: Colors.white, // This sets the background color to white.
  //   onPrimary: Colors.black, // This sets the text color to black.
  // ),
  //             ),
              SizedBox(height: 40),
              CustomMainButton(
  child:const Text(
    'Log Out',
  style: TextStyle( letterSpacing: 0.6, color: Colors.black),),
  color: Color.fromARGB(255, 179, 216, 246),// Change this to your preferred color.
  isLoading: false,
  onPressed: () async {
  print('Starting sign-out process');
  
  // Sign out the user from Firebase.
  await FirebaseAuth.instance.signOut();
  print('User signed out from Firebase');

  // Sign out from Google Sign-In and revoke access.
  await _googleSignIn.signOut();
  
  print('Navigating to sign-in screen');
  Navigator.pushReplacementNamed(context, '/signin');
},
),

SizedBox(height: 20), // This creates a gap between the two buttons.
CustomMainButton(
  child:const Text(
    'Edit Profile',
  style: TextStyle( letterSpacing: 0.6, color: Colors.black),),
  color: Color.fromARGB(255, 179, 216, 246),// Change this to your preferred color.
  isLoading: false,
  onPressed: () {
    // TODO: Implement edit profile functionality.
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  },
),
                    ],
                  ),
                    ],
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data"); // Placeholder for empty data.
              }
              return const Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 9, 9, 2)),
        backgroundColor: Color.fromARGB(255, 225, 224, 224),
    strokeWidth: 4,
      ),
      SizedBox(height: 10),
      Text(
        'Loading...',
        style: TextStyle(
          color: Color.fromARGB(255, 89, 90, 91),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
); // Loading state.
            },
          ),
        ),
      ),
    );
  }
}
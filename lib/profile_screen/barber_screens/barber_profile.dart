// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:new_project/custombutton.dart';
// import 'package:new_project/editprofile_screen.dart';


// class BarberProfileScreen extends StatefulWidget {
//   const BarberProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<BarberProfileScreen> createState() => _BarberProfileScreenState();
// }

// class _BarberProfileScreenState extends State<BarberProfileScreen> {
//   final user = FirebaseAuth.instance.currentUser;

//   Future<List<dynamic>> getBarberAppointments() async {
//     // Get the reference to the barber document.
//     final barberRef = FirebaseFirestore.instance.collection('barbers').doc(user?.uid);

//     // Fetch the barber data.
//     final barberData = await barberRef.get();

//     // Get the list of appointments.
//     List<dynamic> appointments = barberData.data()?['appointments'] ?? [];

//     return appointments;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.8, // Adjust this value as needed.
//           child: FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance.collection('barbers').doc(user?.uid).get(), // Fetch data from 'barbers' collection
//             builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//                 return Column(
//                   children: <Widget>[
//                     Icon(Icons.account_circle_outlined, size: 100),
//                     Text(data['name']), // Barber's name from Firebase.
//                     Text(user?.email ?? 'No email'), // Barber's email from Firebase.
//                     SizedBox(height: 20), 
//                     ElevatedButton(
//                       onPressed: () {
//     // // TODO: Implement edit profile functionality.
//     //  Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) =>  ServicesScreen()),
//     // );
//   },
                      
//   child: Text('My Services'),
//   style: ElevatedButton.styleFrom(
//     primary: Colors.white, // This sets the background color to white.
//     onPrimary: Colors.black, // This sets the text color to black.
//   ),
// ),

// SizedBox(height: 10), 
// ElevatedButton(
//                       onPressed: () async {
//     // TODO: Implement edit profile functionality.
//      List<dynamic> appointments = await getBarberAppointments();
    
     
//   },
                      
//   child: Text('Appointments'),
//   style: ElevatedButton.styleFrom(
//     primary: Colors.white, // This sets the background color to white.
//     onPrimary: Colors.black, // This sets the text color to black.
//   ),
// ),
// SizedBox(height: 20), 

//                     // ... rest of your code ...
//                     CustomMainButton(
//   child:const Text(
//     'Log Out',
//   style: TextStyle( letterSpacing: 0.6, color: Colors.black),),
//   color: Color.fromARGB(255, 179, 216, 246),// Change this to your preferred color.
//   isLoading: false,
//   onPressed: () async {
//     // Sign out the user from Firebase.
//     await FirebaseAuth.instance.signOut();

//     // Navigate to the sign-in screen.
   
//     Navigator.pushReplacementNamed(context, '/signin');
//   },
// ),

// SizedBox(height: 20), // This creates a gap between the two buttons.
// CustomMainButton(
//   child:const Text(
//     'Edit Profile',
//   style: TextStyle( letterSpacing: 0.6, color: Colors.black),),
//   color: Color.fromARGB(255, 179, 216, 246),// Change this to your preferred color.
//   isLoading: false,
//   onPressed: () {
//     // TODO: Implement edit profile functionality.
//      Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EditProfileScreen()),
//     );
//   },
// ),

//                   ],
//                 );
//               }
//               return CircularProgressIndicator(); // Show a loading spinner while waiting for data
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_project/custombutton.dart';
import 'package:new_project/editprofile_screen.dart';
import 'package:new_project/profile_screen/barber_screens/appointments_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barberservices.dart';

class BarberProfileScreen extends StatefulWidget {
  const BarberProfileScreen({Key? key}) : super(key: key);

  @override
  State<BarberProfileScreen> createState() => _BarberProfileScreenState();
}

class _BarberProfileScreenState extends State<BarberProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<List<dynamic>> getBarberAppointments() async {
    // Get the reference to the barber document.
    final barberRef = FirebaseFirestore.instance.collection('barbers').doc(user?.uid);

    // Fetch the barber data.
    final barberData = await barberRef.get();

    // Get the list of appointments.
    List<dynamic> appointments = barberData.data()?['appointments'] ?? [];

    return appointments;
  }

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
            future: FirebaseFirestore.instance.collection('barbers').doc(user?.uid).get(), // Fetch data from 'barbers' collection
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: <Widget>[
                    Icon(Icons.account_circle_outlined, size: 100),
                    Text(data['name']), // Barber's name from Firebase.
                    Text(user?.email ?? 'No email'), // Barber's email from Firebase.
                    SizedBox(height: 20), 
                    ElevatedButton(
  onPressed: () async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServicesScreen(barberId: user.uid)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
    }
  },
  child: Text('My Services'),
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.white, // This sets the text color to black.
  ),
),

                    SizedBox(height: 10), 
                    ElevatedButton(
                      onPressed: () async {
                        // TODO: Implement edit profile functionality.
                        List<dynamic> appointments = await getBarberAppointments();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppointmentsScreen(appointments: appointments)),
                        );
                      },
                      child: Text('Appointments'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white, // This sets the text color to black.
                      ),
                    ),
                    SizedBox(height: 20), 
                    // ... rest of your code ...
                    CustomMainButton(
                      child: const Text(
                        'Log Out',
                        style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                      ),
                      color: Color.fromARGB(255, 179, 216, 246),// Change this to your preferred color.
                      isLoading: false,
                      onPressed: () async {
                        // Sign out the user from Firebase.
                        await FirebaseAuth.instance.signOut();

                        // Navigate to the sign-in screen.
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                    ),
                    SizedBox(height: 20), // This creates a gap between the two buttons.
                    CustomMainButton(
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                      ),
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
                );
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
);
 // Show a loading spinner while waiting for data
            },
          ),
        ),
      ),
    );
  }
}




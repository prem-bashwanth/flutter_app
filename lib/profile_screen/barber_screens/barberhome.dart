// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:new_project/controllers/barberhome_controller.dart';
// import 'package:new_project/profile_screen/barber_screens/appointments_screen.dart';
// import 'package:new_project/profile_screen/barber_screens/barber_profile.dart';
// import 'package:new_project/profile_screen/barber_screens/barberhome_screen.dart';
// import 'package:new_project/profile_screen/barber_screens/barberorders_screen.dart';
// import 'package:new_project/profile_screen/barber_screens/barbersetprize_screen.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:get/get.dart';

// import 'package:new_project/profile_screen/profile_screen.dart';
// class BarberHome extends StatefulWidget {
//   const BarberHome({super.key});

//   @override
//   State<BarberHome> createState() => _BarberHomeState();
// }

// class _BarberHomeState extends State<BarberHome> {

//   late Future<List<dynamic>> appointmentsFuture;

//   Future<List<dynamic>> getBarberAppointments() async {
//     final barberRef = FirebaseFirestore.instance.collection('barbers').doc(FirebaseAuth.instance.currentUser?.uid);

//     final barberData = await barberRef.get();
//     List<dynamic> appointments = barberData.data()?['appointments'] ?? [];

//     return appointments;
//   }

//   @override
//   void initState() {
//     super.initState();
//     appointmentsFuture = getBarberAppointments();
//   }
  

//   Widget build(BuildContext context) {
//     var controller = Get.put(BarberHomeController());
//     var navbarItem=[
//       BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png" ,width: 26,),label: 'Home'),
      
//       BottomNavigationBarItem(icon: Image.asset("assets/icons/image.png" ,width: 36,),label: 'orders'),
//       BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png" ,width: 26,),label: 'Set prize'),
//       BottomNavigationBarItem(icon: Image.asset("assets/icons/profile.png" ,width: 26,),label: 'Profile'),
//     ];
//     var navBody=[
//        BarberHomeScreen(),
//        AppointmentsScreen(appointments: appointmentsFuture),
//        SetPrizeScreen(),
//        BarberProfileScreen(),
//     ];
//     return Scaffold(
//       body: Column(
//         children:[
//         Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value),))
//         ]
//         ), 
//       bottomNavigationBar: Obx(
//         () =>BottomNavigationBar(
//           currentIndex: controller.currentNavIndex.value,
//           selectedItemColor: Colors.red,
//           type:BottomNavigationBarType.fixed,
//           backgroundColor: Color.fromARGB(255, 240, 238, 238),
//           items: navbarItem,
//           onTap: (value) {
//               controller.currentNavIndex.value =value;
//           },
//         )
//       )
      
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:new_project/controllers/barberhome_controller.dart';
import 'package:new_project/profile_screen/barber_screens/appointments_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barber_profile.dart';
import 'package:new_project/profile_screen/barber_screens/barberhome_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barberorders_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barbersetprize_screen.dart';
import 'package:new_project/profile_screen/profile_screen.dart';

class BarberHome extends StatefulWidget {
  const BarberHome({super.key});

  @override
  State<BarberHome> createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {
  late Future<List<dynamic>> appointmentsFuture;

  Future<List<dynamic>> getBarberAppointments() async {
    final barberRef = FirebaseFirestore.instance.collection('barbers').doc(FirebaseAuth.instance.currentUser?.uid);

    final barberData = await barberRef.get();
    List<dynamic> appointments = barberData.data()?['appointments'] ?? [];

    return appointments;
  }

  @override
  void initState() {
    super.initState();
    appointmentsFuture = getBarberAppointments();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BarberHomeController());
    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png", width: 26), label: 'Home'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/image.png", width: 36), label: 'appointments'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png", width: 26), label: 'set timings'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/profile.png", width: 26), label: 'Profile'),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: appointmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 9, 9, 2)),
        backgroundColor: Color.fromARGB(255, 225, 224, 224),
    strokeWidth: 4,
      );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  var navBody = [
                    BarberHomeScreen(),
                    AppointmentsScreen(appointments: snapshot.data!),
                    TimeSlotScreen(),
                    BarberProfileScreen(),
                  ];
                  return Obx(() => navBody.elementAt(controller.currentNavIndex.value));
                } else {
                  return Text("No data available");
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 240, 238, 238),
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // import 'package:new_project/display.dart';
// // import 'package:new_project/display1.dart';
// import 'package:new_project/firebase_options.dart';
// import 'package:new_project/home.dart';
// import 'package:new_project/notifications.dart';
// import 'package:new_project/signin_screen.dart';
// // import 'package:new_project/splash_screen.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   tz.initializeTimeZones();
//    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//    Future<void> requestNotificationPermissions() async {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(const AndroidNotificationChannel(
//             'hair_care_channel', // Unique channel ID for your hair care service
//       'Hair Care Notifications',
//             importance: Importance.high, 
//             playSound: true,
//             enableVibration: true));
//   }
//   print("#############################0");
//   await NotificationService.init();
// final user = FirebaseAuth.instance.currentUser;

//   if (user != null) {
//   // User is signed in, proceed to fetch bookings
//   final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
//   final userData = await userRef.get();
//   List<dynamic> bookings = userData.data()?['bookings'] ?? [];

//   // Process the snapshot data
//   if (bookings.isNotEmpty) {
//     // Bookings found, iterate through the list and print booked dates
//     print('Booked dates:');
//     bookings.forEach((booking) {
//       DateTime bookingDate = DateTime.parse(booking['date']);
//       String formattedDate = DateFormat('dd/MM/yy').format(bookingDate);
//     String shopName = booking['shopName'];

//     // Example: Schedule a notification 1 day before the booking date
//     DateTime notificationDate = bookingDate.subtract(Duration(days: 1));
//     DateTime scheduledDate = DateTime.parse('2024-04-03 05:12:00.000');
//     NotificationService.scheduleNotification(
//       notificationId: 0, // Unique notification ID
//       title: 'Booking Reminder',
//       body: 'Your booking at $shopName is scheduled for tomorrow.',
//       scheduledDate: scheduledDate,
//     );

//       print("Notification scheduled for booking at $shopName on $scheduledDate");
//       print(formattedDate);
//     });
//   } else {
//     // No bookings found
//     print('No bookings found for the current user.');
//   }
// } else {
//   // No user signed in
//   print('No user signed in.');
// }








// //   // Fetch booking data from Firestore
// //   final user = FirebaseAuth.instance.currentUser;
// //   final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
// //   final bookingSnapshot = await userRef.collection('bookings').get();


  
  
// //   if(bookingSnapshot.docs.isEmpty){print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");}
// //   // Schedule notifications for each booking
// //   bookingSnapshot.docs.forEach((doc) {
// //     final bookingData = doc.data();

// //     DateTime bookingDate;
// // if (bookingData['date'] is DateTime) {
// //   bookingDate = bookingData['date'];
// // } else {
// //   // Convert Firestore Timestamp to DateTime
// //   bookingDate = (bookingData['date'] as Timestamp).toDate();
// // }
// //     print("================= $bookingDate"); // Convert Firestore Timestamp to DateTime
// //     String shopName = bookingData['shopName'];

// //     // Example: Schedule a notification 1 day before the booking date
// //     DateTime notificationDate = bookingDate.subtract(Duration(days: 1));
    
// //     NotificationService.scheduleNotification(
// //       notificationId: doc.id.hashCode, // Unique notification ID
// //       title: 'Booking Reminder',
// //       body: 'Your booking at $shopName is scheduled for tomorrow.',
// //       scheduledDate: notificationDate,
// //     );
// //     print('@@@@@@@@@@@@@@@@@@@@@@==============>>>>>>>>>>>Notification scheduled for booking at $shopName on $notificationDate');
// //   });


  

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//    Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Salon Booking App",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//          scaffoldBackgroundColor: Colors.white,
//       ),
//       home: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, AsyncSnapshot<User?> user) {
//               if (user.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.orange,
//                   ),
//                 );
//               } else if (user.hasData) {
//                 return Home();
//                 //return const SellScreen();
//               } else {
//                 return const SignInScreen();
//               }
//             }),
//             routes: {
//         '/signin': (context) => SignInScreen(), 
//         '/home': (context) => Home(),// This is the initial screen.
//       },
//    );
//   }

// //   Widget build(BuildContext context) {
    
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home:Home(),
// //     );

// // }

// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:new_project/firebase_options.dart';
import 'package:new_project/home.dart';
import 'package:new_project/notifications.dart';
import 'package:new_project/profile_screen/barber_screens/barberhome.dart';
import 'package:new_project/signin_screen.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  tz.initializeTimeZones();

  // Request notification permissions
  await _requestNotificationPermissions();

  // Schedule notifications for booked services
  await _scheduleNotifications();

  runApp(const MyApp());
}

Future<void> _requestNotificationPermissions() async {
  PermissionStatus permissionStatus = await Permission.notification.request();
  if (!permissionStatus.isGranted) {
    // Handle if permission is not granted
    print('Notification permissions not granted.');
  }
}

Future<void> _scheduleNotifications() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userData = await userRef.get();
    List<dynamic> bookings = userData.data()?['bookings'] ?? [];

    if (bookings.isNotEmpty) {
      // Bookings found, iterate through the list and schedule notifications
      bookings.forEach((booking) {
        DateTime bookingDate = DateTime.parse(booking['date']);
        DateTime notificationDate = bookingDate.subtract(Duration(days: 1));

        // Schedule notification for 22:55 on the day before booking
         DateTime scheduledDate = DateTime.parse('2024-04-03 00:53:00.000');
        // Schedule the notification
        NotificationService.scheduleNotification(
          notificationId: 0, // Unique notification ID
          title: 'Booking Reminder',
          body: 'Your booking at ${booking['shopName']} is scheduled for tomorrow.',
          scheduledDate: scheduledDate,
        );

        print('Notification scheduled for booking at ${booking['shopName']} on $scheduledDate');
      });
    } else {
      print('No bookings found for the current user.');
    }
  } else {
    print('No user signed in.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "Salon Booking App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, AsyncSnapshot<User?> user) {
      //     if (user.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.orange,
      //         ),
      //       );
      //     } else if (user.hasData) {
      //       return const SignInScreen();
      //     } else {
      //       return const SignInScreen();
      //     }
      //   },
      // ),
      // routes: {
      //   '/signin': (context) => SignInScreen(),
      //   '/home': (context) => Home(),
      // },
      home: StreamBuilder(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, AsyncSnapshot<User?> userSnapshot) {
    if (userSnapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (userSnapshot.hasData) {
      // User is logged in
      User? user = userSnapshot.data;
      return FutureBuilder<List<DocumentSnapshot>>(
        future: Future.wait([
          FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
          FirebaseFirestore.instance.collection('barbers').doc(user.uid).get(),
        ]),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else {
            DocumentSnapshot userSnapshot = snapshot.data![0];
            DocumentSnapshot barberSnapshot = snapshot.data![1];

            if (userSnapshot.exists) {
              // uid is present in users collection
              return Home();
            } else if (barberSnapshot.exists) {
              // uid is present in barbers collection
              return BarberHome();
            } else {
              // uid is not present in both collections
              return const SignInScreen();
            }
          }
        },
      );
    } else {
      // User is not logged in
      return const SignInScreen();
    }
  },
),
     
    );
  }
}

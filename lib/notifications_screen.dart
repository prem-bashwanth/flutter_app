// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class NotificationsScreen extends StatefulWidget {
//   @override
//   _NotificationsScreenState createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   List<String> notificationMessages = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAndGenerateNotifications();
//   }

//   Future<void> fetchAndGenerateNotifications() async {
//     // Fetch the list of bookings from Firestore
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('bookings').get();

//     // Get the current date
//     DateTime today = DateTime.now();
    
//     // Filter bookings scheduled for tomorrow
//     List<Map<String, dynamic>> tomorrowBookings = querySnapshot.docs
//         .map((doc) => doc.data())
//         .where((booking) {
//           DateTime bookingDate = DateTime.parse(booking['date']);
//           return bookingDate.year == today.year &&
//                  bookingDate.month == today.month &&
//                  bookingDate.day == today.day + 1; // Filter bookings for tomorrow
//         })
//         .toList();

//     // Generate notification messages for tomorrow's bookings
//     tomorrowBookings.forEach((booking) {
//       String shopName = booking['shopName'];
//       String service = booking['serivceName'];

//       String formattedDate = DateFormat('EEEE, MMMM d').format(today);
//       String message = 'Tomorrow, you have an appointment at $shopName .';
//       notificationMessages.add('$formattedDate: $message');
//     });

//     // Update the state to trigger a rebuild with the generated notification messages
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: ListView.builder(
//         itemCount: notificationMessages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(notificationMessages[index]),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class NotificationsScreen extends StatefulWidget {
//   @override
//   _NotificationsScreenState createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   List<String> notificationMessages = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAndGenerateNotifications();
//   }

//   Future<void> fetchAndGenerateNotifications() async {
//     // Fetch the list of bookings from Firestore
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('bookings').get();

//     // Get the current date
//     DateTime today = DateTime.now();

//     // Filter bookings scheduled for tomorrow
//     List<Map<String, dynamic>> tomorrowBookings = querySnapshot.docs
//         .map((doc) => doc.data())
//         .where((booking) {
//       DateTime bookingDate = DateTime.parse(booking['date']);
//       return bookingDate.year == today.year &&
//           bookingDate.month == today.month &&
//           bookingDate.day == today.day + 1; // Filter bookings for tomorrow
//     })
//         .toList();

//     // Generate notification messages for tomorrow's bookings
//     tomorrowBookings.forEach((booking) {
//       String shopName = booking['shopName'];
//       String serviceName = booking['serviceName']; // Add service name
//       String formattedDate = DateFormat('EEEE, MMMM d').format(today);
//       String message = 'Tomorrow, you have an appointment at $shopName for $serviceName.'; // Include service name in message
//       notificationMessages.add('$formattedDate: $message');
//     });

//     // Update the state to trigger a rebuild with the generated notification messages
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: ListView.builder(
//         itemCount: notificationMessages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(notificationMessages[index]),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class NotificationsScreen extends StatefulWidget {
//   final String userName;
//   NotificationsScreen({required this.userName});
//   @override
//   _NotificationsScreenState createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   List<String> notificationMessages = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAndGenerateNotifications();
//   }

//   Future<void> fetchAndGenerateNotifications() async {
//     // Fetch the list of bookings from Firestore
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('bookings').get();

//     // Get the current date
//     DateTime today = DateTime.now();

//     // Filter bookings scheduled for tomorrow
//     List<Map<String, dynamic>> tomorrowBookings = querySnapshot.docs
//         .map((doc) => doc.data())
//         .where((booking) {
//       DateTime bookingDate = DateTime.parse(booking['date']);
//       return bookingDate.year == today.year &&
//           bookingDate.month == today.month &&
//           bookingDate.day == today.day + 1; // Filter bookings for tomorrow
//     })
//         .toList();

//     // Generate notification messages for tomorrow's bookings
//     tomorrowBookings.forEach((booking) {
//       String shopName = booking['shopName'];
//       String person =widget.userName;
//       String serviceName = booking['serviceName']; // Add service name
//       String formattedDate = DateFormat('EEEE, MMMM d').format(today);
//       String message =
//           'hey $person, you have an appointment at $shopName for $serviceName.'; // Include service name in message
//       notificationMessages.add('$formattedDate: $message');
      
//       // Show dialog for the new message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('New Appointment Notification'),
//             content: Text(message),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     });

//     // Update the state to trigger a rebuild with the generated notification messages
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: ListView.builder(
//         itemCount: notificationMessages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(notificationMessages[index]),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  final String userName;

  NotificationsScreen({required this.userName});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> notificationMessages = [];

  @override
  void initState() {
    super.initState();
    fetchAndGenerateNotifications();
  }

  Future<void> fetchAndGenerateNotifications() async {
    // Fetch the list of bookings from Firestore
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('bookings').get();

    // Get the current date
    DateTime today = DateTime.now();

    // Filter bookings scheduled for tomorrow
    List<Map<String, dynamic>> tomorrowBookings = querySnapshot.docs
        .map((doc) => doc.data())
        .where((booking) {
      DateTime bookingDate = DateTime.parse(booking['date']);
      return bookingDate.year == today.year &&
          bookingDate.month == today.month &&
          bookingDate.day == today.day + 1; // Filter bookings for tomorrow
    }).toList();

    // Generate notification messages for tomorrow's bookings
    tomorrowBookings.forEach((booking) {
      String shopName = booking['shopName'];
      String serviceName = booking['serviceName']; // Add service name
      String formattedDate = DateFormat('EEEE, MMMM d').format(today);
      String message =
          'Hey ${widget.userName}, you have an appointment at $shopName for $serviceName tomorrow.'; // Include service name in message
      notificationMessages.add('$formattedDate: $message');

      // Show dialog for the new message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Appointment Notification'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });

    // Update the state to trigger a rebuild with the generated notification messages
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: notificationMessages.isEmpty
          ? Center(
              child: Text(
                'No notifications for tomorrow.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notificationMessages.length,
              itemBuilder: (context, index) {
                return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          notificationMessages[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
              },
            ),
    );
  }
}


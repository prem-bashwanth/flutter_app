// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class AppointmentsScreen extends StatelessWidget {
// //   final List<dynamic> appointments;

// //   const AppointmentsScreen({Key? key, required this.appointments}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Appointments'),
// //         centerTitle: true,
// //         backgroundColor: Colors.blueGrey, // Updated color for consistency
// //       ),
// //       body: appointments.isEmpty
// //           ? Center(child: Text('No Appointments Scheduled', style: TextStyle(fontSize: 16, color: Colors.grey)))
// //           : ListView.builder(
// //               itemCount: appointments.length,
// //               itemBuilder: (context, index) {
// //                 final appointment = appointments[index];
// //                 final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(appointment['date']);
// //                 final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(parsedDate);
// //                 final String service = appointment['service'];
// //                 final String timeSlot = appointment['timeSlot'];
// //                 final String userName = appointment['userName'];
                
// //                 return Card(
// //                   color: Colors.white, // Ensuring card has a neutral color with elevated shadow for depth
// //                   elevation: 4,
// //                   margin: EdgeInsets.all(10),
// //                   child: ListTile(
// //                     title: Padding(
// //                       padding: EdgeInsets.only(bottom: 8.0), // Space between title and subtitle
// //                       child: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
// //                     ),
// //                     subtitle: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text('Date: $formattedDate', style: TextStyle(color: Colors.blueGrey)),
// //                         Text('Service: $service', style: TextStyle(color: Colors.blueGrey)),
// //                         Text('Time Slot: $timeSlot', style: TextStyle(color: Colors.blueGrey)),
// //                       ],
// //                     ),
// //                     leading: CircleAvatar(
// //                       backgroundColor: Colors.blueGrey,
// //                       child: Icon(Icons.calendar_today, color: Colors.white),
// //                     ),
// //                     trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey), // Visual cue for navigation
// //                   ),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AppointmentsScreen extends StatelessWidget {
//   final List<dynamic> appointments;

//   const AppointmentsScreen({Key? key, required this.appointments}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey, // Updated color for consistency
//       ),
//       body: appointments.isEmpty
//           ? Center(child: Text('No Appointments Scheduled', style: TextStyle(fontSize: 16, color: Colors.grey)))
//           : ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 final appointment = appointments[index];
//                 final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(appointment['date']);
//                 final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(parsedDate);
//                 final String service = appointment['service'];
//                 final String timeSlot = appointment['timeSlot'];
//                 final String userName = appointment['userName'];
//                 final String bookingid = appointment['bookingid'];



//                 return Card(
//                   color: Colors.lightGreen[100], // Updated color based on payment status
//                   elevation: 4,
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Padding(
//                       padding: EdgeInsets.only(bottom: 8.0), // Space between title and subtitle
//                       child: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Date: $formattedDate', style: TextStyle(color: Colors.blueGrey)),
//                         Text('Service: $service', style: TextStyle(color: Colors.blueGrey)),
//                         Text('Time Slot: $timeSlot', style: TextStyle(color: Colors.blueGrey)),
//                       ],
//                     ),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blueGrey,
//                       child: Icon(Icons.calendar_today, color: Colors.white),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey), // Visual cue for navigation
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AppointmentsScreen extends StatelessWidget {
//   final List<dynamic> appointments;

//   const AppointmentsScreen({Key? key, required this.appointments}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: appointments.isEmpty
//           ? Center(child: Text('No Appointments Scheduled', style: TextStyle(fontSize: 16, color: Colors.grey)))
//           : ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 final appointment = appointments[index];
//                 final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(appointment['date']);
//                 final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(parsedDate);
//                 final String service = appointment['service'];
//                 final String timeSlot = appointment['timeSlot'];
//                 final String userName = appointment['userName'];
//                 final String bookingId = appointment['bookingid'];

//                 return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance.collection('bookings').doc(bookingId).get(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }

//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     }

//                     final paymentStatus = snapshot.data?['paymentStatus'] ?? 'pending';
//                     final double selectedCost = double.parse(snapshot.data?['selectedcost'].toString() ?? '139');
//                     // Determine card color based on payment status
//                     Color cardColor = paymentStatus == 'done' ? Colors.lightGreen[100]! : Colors.red[100]!;
//                     String paymentMessage = paymentStatus == 'done'
//                         ? 'Total amount paid: \$${selectedCost.toStringAsFixed(2)}'
//                         : 'Payment of \$${selectedCost.toStringAsFixed(2)} not completed';

//                     return Card(
//                       color: cardColor,
//                       elevation: 4,
//                       margin: EdgeInsets.all(10),
//                       child: ListTile(
//                         title: Padding(
//                           padding: EdgeInsets.only(bottom: 8.0),
//                           child: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Date: $formattedDate', style: TextStyle(color: Colors.blueGrey)),
//                             Text('Service: $service', style: TextStyle(color: Colors.blueGrey)),
//                             Text('Time Slot: $timeSlot', style: TextStyle(color: Colors.blueGrey)),
//                             Text(paymentMessage, style: TextStyle(fontWeight: FontWeight.bold, color: paymentStatus == 'done' ? Colors.green : Colors.red)), // Display payment status
//                           ],
//                         ),
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.blueGrey,
//                           child: Icon(Icons.calendar_today, color: Colors.white),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // For using debugPrint

class AppointmentsScreen extends StatelessWidget {
  final List<dynamic> appointments;

  const AppointmentsScreen({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: appointments.isEmpty
          ? Center(child: Text('No Appointments Scheduled', style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(appointment['date']);
                final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(parsedDate);
                final String service = appointment['service'];
                final String timeSlot = appointment['timeSlot'];
                final String userName = appointment['userName'];
                final String bookingId = appointment['bookingid'];

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('bookings').doc(bookingId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      // Log the error in detail
                      debugPrint('Error fetching booking data: ${snapshot.error}');
                      return Center(child: Text('Error occurred: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(child: Text("Booking information not available."));
                    }

                    Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return Center(child: Text("No data found for this booking."));
                    }

                    final paymentStatus = data['paymentStatus'] ?? 'pending';
                    final double selectedCost = double.tryParse(data['selectedcost']?.toString() ?? '139') ?? 139.0;
                    Color cardColor = paymentStatus == 'done' ? Colors.lightGreen[100]! : Colors.red[100]!;
                    String paymentMessage = paymentStatus == 'done'
                        ? 'Total amount paid: ₹${selectedCost.toStringAsFixed(2)}'
                        : 'Payment of ₹${selectedCost.toStringAsFixed(2)} pending';

                    return Card(
                      color: cardColor,
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: $formattedDate', style: TextStyle(color: Colors.blueGrey)),
                            Text('Service: $service', style: TextStyle(color: Colors.blueGrey)),
                            Text('Time Slot: $timeSlot', style: TextStyle(color: Colors.blueGrey)),
                            Text(paymentMessage, style: TextStyle(fontWeight: FontWeight.bold, color: paymentStatus == 'done' ? Color.fromARGB(255, 42, 60, 70) :const Color.fromARGB(255, 33, 43, 48))),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Icon(Icons.calendar_today, color: Colors.white),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

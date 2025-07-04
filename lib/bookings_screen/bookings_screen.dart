// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class MyBookingsScreen extends StatefulWidget {
// //   @override
// //   _MyBookingsScreenState createState() => _MyBookingsScreenState();
// // }

// // class _MyBookingsScreenState extends State<MyBookingsScreen> {
// //   late Future<DocumentSnapshot> _bookingsFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _bookingsFuture = _fetchBookings();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('My Bookings'),
// //       ),
// //       body: FutureBuilder<DocumentSnapshot>(
// //         future: _bookingsFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else {
// //             List<dynamic>? bookings = snapshot.data?.get('bookings');
// //             return ListView.builder(
// //               itemCount: bookings?.length ?? 0,
// //               itemBuilder: (context, index) {
// //                 var booking = bookings![index];
// //                 DateTime date = DateTime.parse(booking['date']);
// //                 String formattedDate = DateFormat('dd/MM/yy').format(date);
// //                 return Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
// //                   child: Card(
// //                     elevation: 4,
// //                     child: ListTile(
// //                       leading: Icon(Icons.calendar_today),
// //                       title: Text('Date: $formattedDate'),
// //                       subtitle: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Icon(Icons.access_time),
// //                               SizedBox(width: 5),
// //                               Text('Time Slot: ${booking['timeSlot']}'),
// //                             ],
// //                           ),
// //                           Row(
// //                             children: [
// //                               Icon(Icons.store),
// //                               SizedBox(width: 5),
// //                               Flexible(
// //                                 child: Text(
// //                                   'Shop Name: ${booking['shopName']}',
// //                                   overflow: TextOverflow.ellipsis, // Handle overflow
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           Row(
// //                             children: [
// //                               Icon(Icons.work),
// //                               SizedBox(width: 5),
// //                               Flexible(
// //                                 child: Text(
// //                                   'Service Name: ${booking['serviceName']}',
// //                                   overflow: TextOverflow.ellipsis, // Handle overflow
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                       trailing: IconButton(
// //                         icon: Icon(Icons.cancel),
// //                         onPressed: () {
// //                           _cancelBooking(snapshot.data!.reference, booking);
// //                         },
// //                       ),
// //                       onTap: () {
// //                         // Handle tapping on the booking for more details or actions
// //                       },
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   Future<DocumentSnapshot> _fetchBookings() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     return FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
// //   }
// //   void _showCancellationMessage(BuildContext context, String shopName) {
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         title: Text(
// //           'Cancellation Successful',
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             color: Colors.blue, // Customize the title color
// //           ),
// //         ),
// //         content: Text(
// //           'Your booking with $shopName has been cancelled successfully.',
// //           style: TextStyle(
// //             fontSize: 16,
// //             color: Colors.black87, // Customize the content color
// //           ),
// //         ),
// //         actions: <Widget>[
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //             child: Text(
// //               'OK',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: Color.fromARGB(255, 151, 213, 166), // Customize the button text color
// //               ),
// //             ),
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }


// //   Future<void> _cancelBooking(DocumentReference userRef, Map<String, dynamic> booking) async {
// //   try {
// //     // Get the current bookings list
// //     DocumentSnapshot userDoc = await userRef.get();
// //     List<dynamic>? bookings = userDoc['bookings'];
// //     String deletedshop =booking['shopName'];
// //     // Remove the specific booking to be cancelled
    
// //     bookings?.removeWhere((b) => b['date'] == booking['date'] && b['timeSlot'] == booking['timeSlot'] && b['shopName'] == booking['shopName']);
// //     _showCancellationMessage(context, deletedshop);
// //     print("================555555555555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
// //     // Update the bookings list in Firestore
// //     await userRef.update({'bookings': bookings});
    
// //     // Call setState to trigger rebuild of the widget after cancelling the booking
// //     setState(() {
// //       // Update the state if necessary
// //     });
// //   } catch (e) {
// //     // Handle error
// //     print('Error cancelling booking: $e');
// //   }
  

// // }

// // }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:new_project/profile_screen/barber_screens/razorpay.dart';
// // import 'package:new_project/profile_screen/profile_screen.dart';

// class MyBookingsScreen extends StatefulWidget {
//   @override
//   _MyBookingsScreenState createState() => _MyBookingsScreenState();
// }

// class _MyBookingsScreenState extends State<MyBookingsScreen> {
//   late Future<DocumentSnapshot> _bookingsFuture;


//   Future<void> _handleBookingTap(BuildContext context,String selectedService, String selectedBarber,double selectedcost,String selecteddate,String selectedslot) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('You need to be logged in to view booking details.'), backgroundColor: Colors.red),
//       );
//       return;
//     }

//     final bookingRef = FirebaseFirestore.instance.collection('bookings');
//     final bookingSnapshot = await bookingRef
//         .where('barber', isEqualTo: selectedBarber)
//         .where('date', isEqualTo: selecteddate)
//         .where('timeSlot', isEqualTo: selectedslot)
//         .where('paymentStatus', isEqualTo: "done")
//         .get();
//       if (bookingSnapshot.docs.isEmpty) {
//       final newBookingSnapshot = await bookingRef
//         .where('barber', isEqualTo: selectedBarber)
//         .where('date', isEqualTo: selecteddate)
//         .where('timeSlot', isEqualTo: selectedslot)
//         .where('userId', isEqualTo: user.uid)
//         .get();
//      if (newBookingSnapshot.docs.isNotEmpty) {
//         final bookingId = newBookingSnapshot.docs.first.id;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentScreen(
//               selectedService: selectedService,
//               selectedcost: selectedcost,
//               bookingId: bookingId,
//             ),
//           ),
//         );
//       }} else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('This booking cannot be viewed or is already completed.'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _bookingsFuture = _fetchBookings();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Bookings'),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //      Navigator.pushReplacement(
// //                           context,
// //                           MaterialPageRoute(builder: (context) =>ProfileScreen()),
// //                         );
// //  // Explicitly pop the current screen off the navigation stack
// //     },
// //         ),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: _bookingsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             try{
//             List<dynamic>? bookings = snapshot.data?.get('bookings');
            
//             return ListView.builder(
//               itemCount: bookings?.length ?? 0,
//               itemBuilder: (context, index) {
//                 var booking = bookings![index];
//                 DateTime date = DateTime.parse(booking['date']);
//                 String formattedDate = DateFormat('dd/MM/yy').format(date);
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                   child: Card(
//                     elevation: 4,
//                     child: ListTile(
//                       leading: Icon(Icons.calendar_today),
//                       title: Text('Date: $formattedDate'),
//                       subtitle: _buildBookingDetails(booking),
//                       trailing: IconButton(
//                         icon: Icon(Icons.cancel),
//                         onPressed: () {
//                           _cancelBooking(snapshot.data!.reference, booking);
//                         },
//                       ),
//                       onTap: () {
//                         // Handle tapping on the booking for more details or actions
//                         _handleBookingTap(context,booking['service'],booking['barber'],booking['selectedcost'],booking['date'],booking['timeSlot'] );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }catch (e) {
//               return Center(child: Text('your bookings are empty ...'));
//             }
//         }
//         }
        
//       ),
//     );
//   }

//   Column _buildBookingDetails(Map<String, dynamic> booking) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         Row(
//           children: [
//             Icon(Icons.access_time),
//             SizedBox(width: 5),
//             Flexible(
//               child: Text(
//                 'time: ${booking['timeSlot']}',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         // Row(
//         //   children: [
//         //     Icon(Icons.access_time),
//         //     SizedBox(width: 5),
//         //     Text('Time Slot: ${booking['timeSlot']}'),
//         //   ],
//         // ),
//         Row(
//           children: [
//             Icon(Icons.store),
//             SizedBox(width: 5),
//             Flexible(
//               child: Text(
//                 'Shop Name: ${booking['shopName']}',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Icon(Icons.work),
//             SizedBox(width: 5),
//             Flexible(
//               child: Text(
//                 'Service Name: ${booking['serviceName']}',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Future<DocumentSnapshot> _fetchBookings() async {
//     final user = FirebaseAuth.instance.currentUser;
//     return FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
//   }
//   void _showCancellationMessage(BuildContext context, String shopName) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(
//           'Cancellation Successful',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.blue, // Customize the title color
//           ),
//         ),
//         content: Text(
//           'Your booking with $shopName has been cancelled successfully.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black87, // Customize the content color
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text(
//               'OK',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color.fromARGB(255, 151, 213, 166), // Customize the button text color
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
  
//   Future<void> _cancelBooking(DocumentReference userRef, Map<String, dynamic> booking) async {
//   try {
//     // Get the current bookings list
//     DocumentSnapshot userDoc = await userRef.get();
//     List<dynamic>? bookings = userDoc['bookings'];
//     String deletedshop =booking['shopName'];
//     // Remove the specific booking to be cancelled
    
//     bookings?.removeWhere((b) => b['date'] == booking['date'] && b['timeSlot'] == booking['timeSlot'] && b['shopName'] == booking['shopName']);
//     _showCancellationMessage(context, deletedshop);
//     print("================555555555555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
//     // Update the bookings list in Firestore
//     await userRef.update({'bookings': bookings});
    
//     // Call setState to trigger rebuild of the widget after cancelling the booking
//     setState(() {
//       // Update the state if necessary
//     });
//   } catch (e) {
//     // Handle error
//     print('Error cancelling booking: $e');
//   }
  
// }
//   }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project/profile_screen/barber_screens/razorpay.dart';
// import 'package:new_project/profile_screen/profile_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  late Future<DocumentSnapshot> _bookingsFuture;
  
  
Future<bool> findPaymentStatus(BuildContext context, String selectedBarber, String selectedDate, String selectedSlot) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return false; // User not logged in
  }

  final bookingRef = FirebaseFirestore.instance.collection('bookings');

  final newBookingSnapshot = await bookingRef
      .where('barber', isEqualTo: selectedBarber)
      .where('date', isEqualTo: selectedDate)
      .where('timeSlot', isEqualTo: selectedSlot)
      .where('userId', isEqualTo: user.uid)
      .get();
  if (newBookingSnapshot.docs.isNotEmpty) {
    // Iterate over the documents returned by the query
    for (var doc in newBookingSnapshot.docs) {
      // Check the payment status of each document
      if (doc['paymentStatus'] == "done") {
        return true; // Payment done
      } else {
        return false; // Payment not done
      }
    }
  }
  return false; // No booking found
}

  @override
  void initState() {
    super.initState();
    _bookingsFuture = _fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _bookingsFuture,
        builder: (context, snapshotqq) {
          if (snapshotqq.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshotqq.hasError) {
            return Center(child: Text('Error: ${snapshotqq.error}'));
          } else {
            try {
              List<dynamic>? bookings = snapshotqq.data?.get('bookings');
              
              return ListView.builder(
                itemCount: bookings?.length ?? 0,
                itemBuilder: (context, index) {
                  var booking = bookings![index];
                  DateTime date = DateTime.parse(booking['date']);
                  String formattedDate = DateFormat('dd/MM/yy').format(date);
                  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                  print(booking);
                  return Padding(
                    
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    
                    child: FutureBuilder<bool>(
  future: findPaymentStatus(context, booking['shopName'], booking['date'], booking['timeSlot']),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // While waiting for the result, return a loading indicator or a placeholder.
      return CircularProgressIndicator(); // Or any other loading widget.
    } else if (snapshot.hasError) {
      // If an error occurs, handle it gracefully.
      return Text('Error: ${snapshot.error}');
    } else {
      // Once the result is available, use it to determine the color of the Card.
      final paymentDone = snapshot.data ?? false; // Default to false if data is null.
      return Card(
        color: paymentDone ? Colors.lightGreen[100]! : Colors.red[100]!,
        elevation: 4,
        child: ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Date: $formattedDate'),
          subtitle: _buildBookingDetails(booking),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              _cancelBooking(snapshotqq.data!.reference, booking);
            },
          ),
          onTap: () async {
            // Handle tapping on the booking for more details or actions
          },
        ),
      );
    }
  },
),

                  );
                },
              );
            } catch (e) {
              return Center(child: Text('Your bookings are empty...'));
            }
          }
        },
      ),
    );
  }

  Column _buildBookingDetails(Map<String, dynamic> booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                'Time: ${booking['timeSlot']}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.store),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                'Shop Name: ${booking['shopName']}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.work),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                'Service Name: ${booking['serviceName']}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
                                  Container(
  width: double.infinity, // Make the button take the full width
  margin: EdgeInsets.symmetric(horizontal: 20),
  child: ElevatedButton(
    onPressed: ()async {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                          print(booking);
                          final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to be logged in to view booking details.'), backgroundColor: Colors.red),
      );
      return;
    }
    if (booking['selectedcost'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barber Don\'t set the cost for this.'), backgroundColor: Colors.red),
      );
      return;
    }

    final bookingRef = FirebaseFirestore.instance.collection('bookings');
    final bookingSnapshot = await bookingRef
        .where('barber', isEqualTo: booking['shopName'])
        .where('date', isEqualTo: booking['date'])
        .where('timeSlot', isEqualTo: booking['timeSlot'])
        .where('paymentStatus', isEqualTo: "done")
        .get();
    
    if (bookingSnapshot.docs.isEmpty) {
      final newBookingSnapshot = await bookingRef
        .where('barber', isEqualTo: booking['shopName'])
        .where('date', isEqualTo: booking['date'])
        .where('timeSlot', isEqualTo: booking['timeSlot'])
        .where('userId', isEqualTo: user.uid)
        .get();
      
      if (newBookingSnapshot.docs.isNotEmpty) {
        final bookingId = newBookingSnapshot.docs.first.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              selectedService: booking['serviceName'],
              selectedcost: double.parse(booking['selectedcost'].toString()),
              bookingId: bookingId,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This booking cannot be viewed or is already completed.'), backgroundColor: Colors.red),
      );
    }
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ), backgroundColor: Colors.black,
      elevation: 3,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15), // Adjust the padding as needed
      child: Text(
        'Pay now',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  ),
),
      ],
      
    );
  }

  Future<DocumentSnapshot> _fetchBookings() async {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
  }

  void _showCancellationMessage(BuildContext context, String shopName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancellation Successful',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue, // Customize the title color
            ),
          ),
          content: Text(
            'Your booking with $shopName has been cancelled successfully.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87, // Customize the content color
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 151, 213, 166), // Customize the button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelBooking(DocumentReference userRef, Map<String, dynamic> booking) async {
    try {
      DocumentSnapshot userDoc = await userRef.get();
      List<dynamic>? bookings = userDoc['bookings'];
      String deletedShop = booking['shopName'];

      bookings?.removeWhere((b) => b['date'] == booking['date'] && b['timeSlot'] == booking['timeSlot'] && b['shopName'] == booking['shopName']);
      _showCancellationMessage(context, deletedShop);

      await userRef.update({'bookings': bookings});

      setState(() {
        // Update the state if necessary
      });
    } catch (e) {
      print('Error cancelling booking: $e');
    }
  }
}


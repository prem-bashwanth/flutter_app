// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class TimeSlotScreen extends StatefulWidget {
// //   @override
// //   _TimeSlotScreenState createState() => _TimeSlotScreenState();
// // }

// // class _TimeSlotScreenState extends State<TimeSlotScreen> {
// //   late List<String> timeSlots;
// //   late DateTime selectedDate;
// //   String? barberName;
  

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchUserName();
// //     selectedDate = DateTime.now();
// //     timeSlots = List.generate(9, (index) {
// //       final hour = 9 + index;
// //       return '${hour.toString().padLeft(2, '0')}:00';
// //     });
// //   }
// // Future<void> fetchUserName() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     if (user != null) {
// //       final docSnapshot = await FirebaseFirestore.instance.collection('barbers').doc(user.uid).get();
// //       setState(() {
// //         barberName = docSnapshot['name'];
        
// //       });
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Select Time Slot'),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: ElevatedButton(
// //               onPressed: () async {
// //                 final DateTime? pickedDate = await showDatePicker(
// //                   context: context,
// //                   initialDate: selectedDate,
// //                   firstDate: DateTime.now(),
// //                   lastDate: DateTime(2100),
// //                 );
// //                 if (pickedDate != null && pickedDate != selectedDate) {
// //                   setState(() {
// //                     selectedDate = pickedDate;
// //                   });
// //                 }
// //               },
// //               child: Text('Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
// //             ),
// //           ),
// //           Expanded(
// //             child: FutureBuilder<List<String>>(
// //               future: fetchBookedTimeSlots(selectedDate),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return Center(child: CircularProgressIndicator());
// //                 } else if (snapshot.hasError) {
// //                   return Center(child: Text('Error: ${snapshot.error}'));
// //                 } else {
// //                   final List<String> bookedTimeSlots = snapshot.data ?? [];
// //                   return ListView.builder(
// //                     itemCount: timeSlots.length,
// //                     itemBuilder: (context, index) {
// //                       final timeSlot = timeSlots[index];
// //                       final isBooked = bookedTimeSlots.contains(timeSlot);
// //                       return ListTile(
// //                         title: Text(timeSlot),
// //                         onTap: () async {
// //                           // Show alert dialog for confirmation
// //                           final bool? confirm = await showDialog(
// //                             context: context,
// //                             builder: (BuildContext context) {
// //                               return AlertDialog(
// //                                 title: Text(isBooked ? 'Confirmation' : 'Confirmation'),
// //                                 content: Text(isBooked ? 'Are you sure you want to make this slot available?' : 'Do you want to block this slot?'),
// //                                 actions: [
// //                                   TextButton(
// //                                     onPressed: () {
// //                                       Navigator.of(context).pop(false); // Return false when cancelled
// //                                     },
// //                                     child: Text('Cancel'),
// //                                   ),
// //                                   TextButton(
// //   onPressed: () {
// //     Navigator.of(context).pop(true); // Return true when confirmed
// //     // Show Snackbar
// //     final message = isBooked ? 'this slot now is availble for the customers' : 'customers now no longer can book in this slot';
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //       ),
// //     );
// //   },
// //   child: Text(isBooked ? 'Yes' : 'Yes'),
// // ),

// //                                 ],
// //                               );
// //                             },
// //                           );

// //                           // Proceed with booking or cancellation if confirmed
// //                           if (confirm ?? false) {
// //                             if (isBooked) {
// //                               cancelBooking(timeSlot);
// //                             } else {
// //                               bookTimeSlot(timeSlot);
// //                             }
// //                           }
// //                         },
// //                         tileColor: isBooked ? Colors.grey : null,
// //                       );
// //                     },
// //                   );
// //                 }
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<List<String>> fetchBookedTimeSlots(DateTime date) async {
// //     final formattedDate = DateFormat('yyyy-MM-dd').format(date);
// //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //         .collection('bookings')
// //         .where('date', isEqualTo: formattedDate)
// //         .get();
// //     return querySnapshot.docs.map<String>((doc) => doc['timeSlot'] as String).toList();
// //   }

// //   Future<void> bookTimeSlot(String timeSlot) async {
// //     final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
// //     final currentUser = FirebaseAuth.instance.currentUser;
// //   final userId = currentUser?.uid;
  
// //     await FirebaseFirestore.instance.collection('bookings').add({
// //       'barber': barberName, // Replace 'vineela' with the current user's name
// //       'date': formattedDate,
// //       'service': '',
// //       'timeSlot': timeSlot,
// //       'userId': userId,
// //       'userName':barberName,
// //     });
// //   }

// //   Future<void> cancelBooking(String timeSlot) async {
// //     final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
// //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //         .collection('bookings')
// //         .where('date', isEqualTo: formattedDate)
// //         .where('timeSlot', isEqualTo: timeSlot)
// //         .limit(1)
// //         .get();

// //     if (querySnapshot.docs.isNotEmpty) {
// //       final docId = querySnapshot.docs.first.id;
// //       await FirebaseFirestore.instance.collection('bookings').doc(docId).delete();
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TimeSlotScreen extends StatefulWidget {
//   // final String selectedService;
//   // final String selectedBarber;


//   // const BookingScreen({
//   //   Key? key,
//   //   required this.selectedService,
//   //   required this.selectedBarber,
//   // }) : super(key: key);
  

//   @override
//   _TimeSlotScreenState createState() => _TimeSlotScreenState();
// }

// class _TimeSlotScreenState extends State<TimeSlotScreen> {
//   DateTime? selectedDate;
//   String selectedTimeSlot = '';

//   @override
//   Widget build(BuildContext context) {
//     // String selectedService = widget.selectedService;
//     // String selectedBarber = widget.selectedBarber;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select your slots'),
//       ),
//       body: Column(
//         children: <Widget>[
//           // 'Select Date' button
//           ElevatedButton(
//             child: Text('Select Date'),
//             onPressed: () async {
//               final date = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now().add(Duration(days: 1)),
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime.now().add(Duration(days: 14)),
//               );
//               if (date != null) {
//                 setState(() {
//                   selectedDate = date;
//                 });
//               }
//             },
//           ),

//           // List of time slots
//           if (selectedDate != null)
//             ...['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00'].map((timeSlot) =>
//               ListTile(
//                 title: Text(timeSlot),
//                 onTap: () {
//                   setState(() {
//                     selectedTimeSlot = timeSlot;
//                   });
//                 },
//               ),
//             ).toList(),

//           // 'Book' button
//           if (selectedDate != null && selectedTimeSlot != '')
// //           ElevatedButton(
// //   child: Text('Select'),
// // //   onPressed: () async {
// // //     final user = FirebaseAuth.instance.currentUser;
// // //     final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
// // //     final bookingRef = FirebaseFirestore.instance.collection('bookings');
// // //     final querySnapshot = await FirebaseFirestore.instance
// // //   .collection('barbers')
// // //   .where('name', isEqualTo: selectedBarber)
// // //   .get();
  

// // // final barberRef = querySnapshot.docs.first.reference;

// // //     final bookingSnapshot = await bookingRef
// // //         .where('barber', isEqualTo: selectedBarber)
// // //         .where('date', isEqualTo: selectedDate!.toIso8601String())
// // //         .where('timeSlot', isEqualTo: selectedTimeSlot)
// // //         .get();

// // //     if (bookingSnapshot.docs.isEmpty) {
// // //       // Fetch the user's name.
// // //       final userData = await userRef.get();
// // //       final userName = userData.data()?['name'];

// // //       // If the time slot is not booked, book it.
// // //       await bookingRef.add({
// // //         'userId': user?.uid,
// // //         'userName': userName,
// // //         'barber': selectedBarber,
// // //         'service': selectedService,
// // //         'date': selectedDate!.toIso8601String(),
// // //         'timeSlot': selectedTimeSlot,
// // //       });

// // //       // Also add the booking to the user's document.
// // //       List<dynamic> bookings = userData.data()?['bookings'] ?? [];
// // //       bookings.add({
// // //         'barber': selectedBarber,
// // //         'service': selectedService,
// // //         'date': selectedDate!.toIso8601String(),
// // //         'timeSlot': selectedTimeSlot,
// // //       });
// // //       await userRef.update({'bookings': bookings});

// // //       // Add the booking to the barber's document in the 'appointments' field.
// // //       final barberData = await barberRef.get();
      
// // //       List<dynamic> appointments = barberData.data()?['appointments'] ?? [];
// // //       appointments.add({
// // //         'userId': user?.uid,
// // //         'userName': userName,
// // //         'service': selectedService,
// // //         'date': selectedDate!.toIso8601String(),
// // //         'timeSlot': selectedTimeSlot,
// // //       });
// // //       await barberRef.update({'appointments': appointments});

// // //       // Show a success message.
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Slot booked successfully!')),
// // //       );

// // //       Navigator.pop(context);
// // //     } else {
// // //       // If the time slot is already booked, show an error.
// // //       if (bookingSnapshot.docs.first.data()['userId'] == user?.uid) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('You have already booked this time slot.')),
// // //         );
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('This time slot is not available.')),
// // //         );
// // //       }
// // //     }
// // //   },

// // ),
// ElevatedButton(
//   child: Text('Book'),
//   onPressed: () async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userRef = FirebaseFirestore.instance.collection('barbers').doc(user?.uid);
//     final bookingRef = FirebaseFirestore.instance.collection('bookings');

//     // Fetch the current user's data to get the barber's name (assuming the user is the barber).
//     final userData = await userRef.get();
//     final barberName = userData.data()?['name'];

//     if (barberName != null) {
//       final bookingSnapshot = await bookingRef
//           .where('barber', isEqualTo: barberName)
//           .where('date', isEqualTo: selectedDate!.toIso8601String())
//           .where('timeSlot', isEqualTo: selectedTimeSlot)
//           .get();

//       if (bookingSnapshot.docs.isEmpty) {
//         // If the time slot is not booked, book it.
//         await bookingRef.add({
//           'barber': barberName,
//           'date': selectedDate!.toIso8601String(),
//           'service': 'haircut', 
//           'timeSlot': selectedTimeSlot,
//           'userId': user?.uid,
//           'userName': barberName, // Assuming the barber's name is also used as the user's name
//           // Assuming the service is always a haircut
//         });

//         // Show a success message.
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Slot booked successfully!')),
//         );

//         // Navigator.pop(context);
//       } else {
//         // If the time slot is already booked, show an error.
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('This time slot is not available.')),
//         );
//       }
//     } else {
//       // If the barber's name is not available, show an error.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unable to fetch barber information.')),
//       );
//     }
//   },
// )







//         ],
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart'; // Needed for formatting dates

// class TimeSlotScreen extends StatefulWidget {
//   @override
//   _TimeSlotScreenState createState() => _TimeSlotScreenState();
// }

// class _TimeSlotScreenState extends State<TimeSlotScreen> {
//   DateTime? selectedDate;
//   String selectedTimeSlot = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Your Slots'),
//         backgroundColor: Colors.deepPurple, // Stylish color for the app bar
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Displaying the selected date with a more readable format
//               if (selectedDate != null) 
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20.0),
//                   child: Text(
//                     'Selected Date: ${DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)}',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),

//               ElevatedButton.icon(
//                 icon: Icon(Icons.calendar_today),
//                 label: Text('Select Date'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.deepPurple, // Button color
//                   onPrimary: Colors.white, // Text color
//                 ),
//                 onPressed: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now().add(Duration(days: 1)),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(Duration(days: 30)),
//                   );
//                   if (date != null) {
//                     setState(() {
//                       selectedDate = date;
//                       selectedTimeSlot = ''; // Reset time slot when date changes
//                     });
//                   }
//                 },
//               ),
//               SizedBox(height: 20),

//               // Conditional display of time slots based on date selection
//               if (selectedDate != null)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Available Time Slots:',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     ...['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00'].map((timeSlot)  =>
//                       ListTile(
//                         title: Text(timeSlot),
//                         leading: Radio<String>(
//                           value: timeSlot,
//                           groupValue: selectedTimeSlot,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedTimeSlot = value!;
//                             });
//                           },
//                         ),
//                       ),
//                     ).toList(),
//                   ],
//                 ),

//               if (selectedTimeSlot.isNotEmpty) 
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 20),
//                   child: ElevatedButton(
//                     child: Text('Book Slot'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green, // Book button color
//                     ),
//                     onPressed: () {
//                       // Functionality to book the slot
//                       bookTimeSlot();
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void bookTimeSlot() async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userRef = FirebaseFirestore.instance.collection('barbers').doc(user?.uid);
//     final bookingRef = FirebaseFirestore.instance.collection('bookings');

//     final userData = await userRef.get();
//     final barberName = userData.data()?['name'];

//     if (barberName != null) {
//       final bookingSnapshot = await bookingRef
//           .where('barber', isEqualTo: barberName)
//           .where('date', isEqualTo: selectedDate!.toIso8601String())
//           .where('timeSlot', isEqualTo: selectedTimeSlot)
//           .get();

//       if (bookingSnapshot.docs.isEmpty) {
//         await bookingRef.add({
//           'barber': barberName,
//           'date': selectedDate!.toIso8601String(),
//           'service': 'haircut', // Assuming the service is always a haircut
//           'timeSlot': selectedTimeSlot,
//           'userId': user?.uid,
//           'userName': barberName, // Assuming the barber's name is also used as the user's name
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Slot booked successfully!'), backgroundColor: Colors.green),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('This time slot is not available.'), backgroundColor: Colors.red),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unable to fetch barber information.'), backgroundColor: Colors.red),
//       );
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeSlotScreen extends StatefulWidget {
  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  DateTime? selectedDate;
  String selectedTimeSlot = '';

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Select Your Slots'),
      backgroundColor: Colors.deepPurple, // Stylish color for the app bar
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Displaying the selected date with a more readable format
            if (selectedDate != null) 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Selected Date: ${DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

            ElevatedButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text('Select Date'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple, // Text color
              ),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                    selectedTimeSlot = ''; // Reset time slot when date changes
                  });
                }
              },
            ),
            SizedBox(height: 20),

            // Conditional display of time slots based on date selection
            if (selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Available Time Slots:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ...['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00'].map((timeSlot) =>
                    ListTile(
                      title: Text(timeSlot),
                      leading: Radio<String>(
                        value: timeSlot,
                        groupValue: selectedTimeSlot,
                        onChanged: (value) {
                          setState(() {
                            selectedTimeSlot = value!;
                          });
                        },
                      ),
                    ),
                  ).toList(),
                ],
              ),

            if (selectedTimeSlot.isNotEmpty) 
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance.collection('bookings')
    .where('date', isEqualTo: selectedDate!.toIso8601String())
    .where('timeSlot', isEqualTo: selectedTimeSlot)
    .get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return a placeholder while loading
      return CircularProgressIndicator();
    } else {
      if (snapshot.hasError) {
        // Handle any potential errors
        return Text('Error: ${snapshot.error}');
      } else {
        // Check if the time slot is already booked
        final bool isBooked = snapshot.data!.docs.isNotEmpty;

        // Return the appropriate label based on the booking status
        return ElevatedButton(
          child: Text(isBooked ? 'Make this available' : 'Block this Slot'),
          onPressed: () {
            // Implement the corresponding functionality
            if (isBooked) {
              final bookingId = snapshot.data!.docs.first.id;
                          FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete()
                            .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('customers now can book this slot!'), backgroundColor: Colors.red),
                              );
                            })
                            .catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error deleting slot: $error'), backgroundColor: Colors.red),
                              );
                            });
                        } 
                else {
              bookTimeSlot(); // Function to book the slot
            }
          },
        );
      }
    }
  },
),






                // child: ElevatedButton(
                //   child: Text('Book Slot'),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.green, // Book button color
                //   ),
                //   onPressed: () {
                //     // Check if the selected slot is already booked
                //     FirebaseFirestore.instance.collection('bookings')
                //       .where('date', isEqualTo: selectedDate!.toIso8601String())
                //       .where('timeSlot', isEqualTo: selectedTimeSlot)
                //       .get()
                //       .then((querySnapshot) {
                //         if (querySnapshot.docs.isNotEmpty) {
                //           // Slot is booked, delete the booking
                //           final bookingId = querySnapshot.docs.first.id;
                //           FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete()
                //             .then((_) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(content: Text('customers now can book this slot!'), backgroundColor: Colors.red),
                //               );
                //             })
                //             .catchError((error) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(content: Text('Error deleting slot: $error'), backgroundColor: Colors.red),
                //               );
                //             });
                //         } else {
                //           // Slot is available, book it
                //           bookTimeSlot();
                //         }
                //       });
                //   },
                // ),
              ),
          ],
        ),
      ),
    ),
  );
}


  void bookTimeSlot() async {
    final user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('barbers').doc(user?.uid);
    final bookingRef = FirebaseFirestore.instance.collection('bookings');

    final userData = await userRef.get();
    final barberName = userData.data()?['name'];

    if (barberName != null) {
      final bookingSnapshot = await bookingRef
          .where('barber', isEqualTo: barberName)
          .where('date', isEqualTo: selectedDate!.toIso8601String())
          .where('timeSlot', isEqualTo: selectedTimeSlot)
          .get();

      if (bookingSnapshot.docs.isEmpty) {
        await bookingRef.add({
          'barber': barberName,
          'date': selectedDate!.toIso8601String(),
          'service': 'haircut', // Assuming the service is always a haircut
          'timeSlot': selectedTimeSlot,
          'userId': user?.uid,
          'userName': barberName, // Assuming the barber's name is also used as the user's name
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('customers no longer can book this slot!'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This time slot is not available.'), backgroundColor: Colors.red),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to fetch barber information.'), backgroundColor: Colors.red),
      );
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookingScreen extends StatefulWidget {
//   final String selectedService;
//   final String selectedBarber;


//   const BookingScreen({
//     Key? key,
//     required this.selectedService,
//     required this.selectedBarber,
//   }) : super(key: key);
  

//   @override
//   _BookingScreenState createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   DateTime? selectedDate;
//   String selectedTimeSlot = '';

//   @override
//   Widget build(BuildContext context) {
//     String selectedService = widget.selectedService;
//     String selectedBarber = widget.selectedBarber;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking'),
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
//           ElevatedButton(
//   child: Text('Book'),
//   onPressed: () async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
//     final bookingRef = FirebaseFirestore.instance.collection('bookings');
//     final querySnapshot = await FirebaseFirestore.instance
//   .collection('barbers')
//   .where('name', isEqualTo: selectedBarber)
//   .get();
  

// final barberRef = querySnapshot.docs.first.reference;

//     final bookingSnapshot = await bookingRef
//         .where('barber', isEqualTo: selectedBarber)
//         .where('date', isEqualTo: selectedDate!.toIso8601String())
//         .where('timeSlot', isEqualTo: selectedTimeSlot)
//         .get();

//     if (bookingSnapshot.docs.isEmpty) {
//       // Fetch the user's name.
//       final userData = await userRef.get();
//       final userName = userData.data()?['name'];

//       // If the time slot is not booked, book it.
//       await bookingRef.add({
//         'userId': user?.uid,
//         'userName': userName,
//         'barber': selectedBarber,
//         'service': selectedService,
//         'date': selectedDate!.toIso8601String(),
//         'timeSlot': selectedTimeSlot,
//       });

//       // Also add the booking to the user's document.
//       List<dynamic> bookings = userData.data()?['bookings'] ?? [];
//       bookings.add({
//         'shopName': selectedBarber,
//         'serviceName': selectedService,
//         'date': selectedDate!.toIso8601String(),
//         'timeSlot': selectedTimeSlot,
//       });
//       await userRef.update({'bookings': bookings});

//       // Add the booking to the barber's document in the 'appointments' field.
//       final barberData = await barberRef.get();
      
//       List<dynamic> appointments = barberData.data()?['appointments'] ?? [];
//       appointments.add({
//         'userId': user?.uid,
//         'userName': userName,
//         'service': selectedService,
//         'date': selectedDate!.toIso8601String(),
//         'timeSlot': selectedTimeSlot,
//       });
//       await barberRef.update({'appointments': appointments});

//       // Show a success message.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Slot booked successfully!')),
//       );

//       Navigator.pop(context);
//     } else {
//       // If the time slot is already booked, show an error.
//       if (bookingSnapshot.docs.first.data()['userId'] == user?.uid) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('You have already booked this time slot.')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('This time slot is not available.')),
//         );
//       }
//     }
//   },
// ),






//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:new_project/profile_screen/barber_screens/razorpay.dart'; // Needed for formatting dates

class BookingScreen extends StatefulWidget {
  final String selectedService;
  final String selectedBarber;
  final double selectedcost;

  const BookingScreen({
    Key? key,
    required this.selectedService,
    required this.selectedBarber,
    required this.selectedcost,
  }) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  String selectedTimeSlot = '';

  @override
  Widget build(BuildContext context) {
    String selectedService = widget.selectedService;
    String selectedBarber = widget.selectedBarber;
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        backgroundColor: Colors.deepPurple, // Stylish color for the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 'Select Date' button
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
                    lastDate: DateTime.now().add(Duration(days: 14)),
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
                    ...['9:00 AM - 11:00 AM', '11:00 AM - 1:00 PM',  '1:00 PM - 3:00 PM', '3:00 PM - 5:00 PM','5:00 PM - 6:00 PM','6:00 PM - 7:00 PM','7:00 PM - 9:00 PM','9:00 PM - 11:00 PM'].map((timeSlot)  =>
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
                  child: ElevatedButton(
                    child: Text('Book Slot'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Book button color
                    ),
                    onPressed: () {
                      // Functionality to book the slot
                      bookTimeSlot(selectedService, selectedBarber,widget.selectedcost);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void bookTimeSlot(String selectedService, String selectedBarber,double selectedcost) async {
    final user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
    final bookingRef = FirebaseFirestore.instance.collection('bookings');
    final querySnapshot = await FirebaseFirestore.instance
        .collection('barbers')
        .where('name', isEqualTo: selectedBarber)
        .get();

    final barberRef = querySnapshot.docs.first.reference;

    final bookingSnapshot = await bookingRef
        .where('barber', isEqualTo: selectedBarber)
        .where('date', isEqualTo: selectedDate!.toIso8601String())
        .where('timeSlot', isEqualTo: selectedTimeSlot)
        .where('paymentStatus',isEqualTo: "done"
        )
        .get();
    final userSnapshot = await bookingRef
        .where('barber', isEqualTo: selectedBarber)
        .where('date', isEqualTo: selectedDate!.toIso8601String())
        .where('timeSlot', isEqualTo: selectedTimeSlot)
        .where('userId',isEqualTo:user?.uid )
        
        .get();

    if (bookingSnapshot.docs.isEmpty && userSnapshot.docs.isEmpty) {
      // Fetch the user's name.
      final userData = await userRef.get();
      final userName = userData.data()?['name'];

      // If the time slot is not booked, book it.
      final newBooking = await bookingRef.add({
      'userId': user?.uid,
      'userName': userName,
      'barber': selectedBarber,
      'service': selectedService,
      'date': selectedDate!.toIso8601String(),
      'timeSlot': selectedTimeSlot,
      'paymentStatus': 'pending' ,
      'selectedcost':selectedcost // Added column for payment status
    });

      // Also add the booking to the user's document.
      List<dynamic> bookings = userData.data()?['bookings'] ?? [];
      bookings.add({
      'shopName': selectedBarber,
      'serviceName': selectedService,
      'date': selectedDate!.toIso8601String(),
      'timeSlot': selectedTimeSlot,
      'paymentStatus': 'pending',
      'selectedcost':selectedcost // Added column for payment status

    });
      await userRef.update({'bookings': bookings});

      // Add the booking to the barber's document in the 'appointments' field.
      final barberData = await barberRef.get();

      List<dynamic> appointments = barberData.data()?['appointments'] ?? [];
      appointments.add({
      'userId': user?.uid,
      'userName': userName,
      'service': selectedService,
      'date': selectedDate!.toIso8601String(),
      'timeSlot': selectedTimeSlot,
      'paymentStatus': 'pending',
      'bookingid':newBooking.id
    });
      await barberRef.update({'appointments': appointments});

      // Show a success message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Slot booked successfully!'), backgroundColor: Colors.green),
      );

       Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(selectedService: selectedService,selectedcost: widget.selectedcost,bookingId: newBooking.id,)));
    } else {
      // If the time slot is already booked, show an error.
      if (userSnapshot.docs.isNotEmpty && userSnapshot.docs.first.data()['userId'] == user?.uid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have already booked this time slot.'), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This time slot is not available.'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:new_project/common_widgets.dart/switch.dart/';

class BookingScreen extends StatefulWidget {
  final shopName;
  final serviceCategory;
  final shoplat;
  final shoplon;
  const BookingScreen({
    Key? key,
    required this.shopName,
    required this.serviceCategory,
    required this.shoplat,
    required this.shoplon,
  }) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  String selectedTimeSlot = '';
  
  Future<void> addToCart(String userId, String shopName, String service,double shoplat,double shoplon) async {
  final user = FirebaseAuth.instance.currentUser;
final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
final cartRef = FirebaseFirestore.instance.collection('carts');

try {
  // Add the shop and service to the user's cart
  await cartRef.add({
    'userId': user?.uid,
    'shopName': widget.shopName,
    'location': {
      'latitude': widget.shoplat,
      'longitude': widget.shoplon,
    },
    'serviceCategory': widget.serviceCategory,
    'timestamp': Timestamp.now(),
  });

  // Also add the cart item to the user's document
  final userData = await userRef.get();
  List<dynamic> carts = userData.data()?['carts'] ?? [];
  carts.add({
    'shopName': widget.shopName,
    'location': {
      'latitude': widget.shoplat,
      'longitude': widget.shoplon,
    },
    'serviceCategory': widget.serviceCategory,
    'timestamp': Timestamp.now(),
  });
  await userRef.update({'carts': carts});
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
  content: Row(
    children: [
      Icon(
        Icons.check_circle_outline,
        color: Colors.green, // Change color to green for success
      ),
      SizedBox(width: 8.0),
      Text(
        'added to cart successfully!',
        style: TextStyle(
          color: Colors.black, // Change text color to white
          fontSize: 16.0, // Adjust font size as needed
        ),
      ),
    ],
  ),
  backgroundColor: Colors.white, // Change background color to blue
  behavior: SnackBarBehavior.floating, // Add floating behavior
  duration: Duration(seconds: 3), // Adjust duration as needed
),
    );
} catch (e) {
  // Handle any errors
  print('Error adding shop and service to cart: $e');
}

}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Service Price: ₹${Random().nextInt(200) + 300}/-",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), 
              
              ElevatedButton(
  onPressed: () async {
    // Get the current user's ID (assuming you're using Firebase Authentication)
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    if (userId != null) {
      // Add the shop and service to the user's cart
      await addToCart(userId, widget.shopName, widget.serviceCategory,widget.shoplat,widget.shoplon);
    } else {
      // Handle the case where the user is not logged in
      print('User is not logged in');
    }
    
    // Close the current screen or dialog
    Navigator.of(context).pop(); 
  },
  child: Text(
    'Add to cart',
    style: TextStyle(
      fontSize: 16,
    ),
  ),
),
// Adjust spacing between text and button
SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement the logic when the button is pressed
                  // For example, show a dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Are you sure you want to book this service?'),
                        actions: [
                          TextButton(
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
                                });
                              }
                              // Implement your action when the user confirms
                              // For example, navigate to the booking screen
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Book Service',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // List of time slots
              if (selectedDate != null)
  GridView.count(
    shrinkWrap: true,
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    children: ['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00','18:00'].map((timeSlot) {
      bool isSelected = selectedTimeSlot == timeSlot;
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedTimeSlot = timeSlot;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              timeSlot,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    }).toList(),
  ),

              SizedBox(height: 20),
              // 'Book' button
              if (selectedDate != null && selectedTimeSlot != '')
                ElevatedButton(
child: Text('Book'),
onPressed: () async {
  final user = FirebaseAuth.instance.currentUser;
  final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
  final bookingRef = FirebaseFirestore.instance.collection('bookings');
  final bookingSnapshot = await bookingRef
      .where('shopName',isEqualTo: widget.shopName)
      .where('date', isEqualTo: selectedDate!.toIso8601String())
      .where('timeSlot', isEqualTo: selectedTimeSlot)
      .get();

  if (bookingSnapshot.docs.isEmpty) {
    // If the time slot is not booked, book it.
    await bookingRef.add({
      'userId': user?.uid,
      'date': selectedDate!.toIso8601String(),
      'timeSlot': selectedTimeSlot,
      'shopName': widget.shopName, // Add shop name attribute
      'location': {
        'latitude': widget.shoplat, // Add latitude attribute
        'longitude': widget.shoplon, // Add longitude attribute
      },
      'serviceName': widget.serviceCategory,
      'selectedCost':-1, // Use the selected service here
    });

    // Also add the booking to the user's document.
    final userData = await userRef.get();
    List<dynamic> bookings = userData.data()?['bookings'] ?? [];
    bookings.add({
      'date': selectedDate!.toIso8601String(),
      'timeSlot': selectedTimeSlot,
      'shopName': widget.shopName, // Add shop name attribute
      'location': {
        'latitude': widget.shoplat, // Add latitude attribute
        'longitude': widget.shoplon, // Add longitude attribute
      },
      'serviceName': widget.serviceCategory,
      'selectedcost':-1,
    });
    await userRef.update({'bookings': bookings});
      // Show a success message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
  content: Row(
    children: [
      Icon(
        Icons.check_circle_outline,
        color: Colors.green, // Change color to green for success
      ),
      SizedBox(width: 8.0),
      Text(
        'Slot booked successfully!',
        style: TextStyle(
          color: Colors.black, // Change text color to white
          fontSize: 16.0, // Adjust font size as needed
        ),
      ),
    ],
  ),
  backgroundColor: Colors.white, // Change background color to blue
  behavior: SnackBarBehavior.floating, // Add floating behavior
  duration: Duration(seconds: 3), // Adjust duration as needed
),

      );

      Navigator.pop(context);
    } else {
      // If the time slot is already booked, show an error.
      if (bookingSnapshot.docs.first.data()['userId'] == user?.uid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have already booked this time slot.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This time slot is not available.')),
        );
      }
    }
  },
),
            ],
          ),
        ),
      ),
    );
  }
}

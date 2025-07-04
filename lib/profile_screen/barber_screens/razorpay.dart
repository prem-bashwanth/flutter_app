// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class PaymentScreen extends StatefulWidget {
//   final String selectedService;
//   final double selectedcost;
//   final String bookingId;

//   PaymentScreen({
//     required this.selectedService,
//     required this.selectedcost,
//     required this.bookingId,
//   });

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear(); // Removes all listeners
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("Payment Success: ${response.paymentId}");
//     final bookingRef = FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId); 

//     bookingRef.update({
//       'payment': 'done'
//     }).then((_) {
//       print("Payment status updated to done");
//     // Show toast message
//     Fluttertoast.showToast(
//       msg: "Payment successful!",
      
//       );
      
//     }).catchError((error) {
//       print("Error updating payment statusssssssssssssssssssssssssssssssssssssssssssssssssssssss: $error");
//     });
//   }

//  void _handlePaymentError(PaymentFailureResponse response) {
//   print("Payment Error: ${response.code} - ${response.message}");
//   Fluttertoast.showToast(
//     msg: "Payment error: ${response.message}",
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//   );
// }

// void _handleExternalWallet(ExternalWalletResponse response) {
//   print("External Wallet: ${response.walletName}");
//   Fluttertoast.showToast(
//     msg: "External Wallet: ${response.walletName} successful",
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.blue, // You can adjust the color as needed
//     textColor: Colors.white,
//   );
// }


//   void _triggerPayment() {
//     var options = {
//       'key': 'rzp_test_1s2n3fSk85sXEt',
//       'amount': (widget.selectedcost * 100).toInt(), // Amount in smallest currency unit (paise)
//       'name': 'Barber Shop',
//       'description': 'Payment for ${widget.selectedService}',
//       'prefill': {
//         'contact': 'USER_CONTACT', // Optional: Fetch from user profile if available
//         'email': 'USER_EMAIL', // Optional: Fetch from user profile if available
//       },
//       'payment_method': ['upi'],
//       'external': {
//     'wallets': ['phonepe', 'paytm'] // Enable PhonePe and Paytm wallets
//       }
//       // 'notes': {
//       //   'booking_id': widget.bookingId,
//       // },
//       // 'theme': {
//       //   'color': '#D32F2F', // Customizing the color of the payment form
//       // },
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error in paymentttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900], // Dark theme background
//       body: Container(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Spacer(),
//             Text(
//               'Payment',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Please proceed to secure payment',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey[500],
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: _triggerPayment, // Trigger payment function
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurple, // Button color
//                 onPrimary: Colors.white, // Text color
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 elevation: 8,
//                 shadowColor: Colors.black87,
//               ),
//               child: Text(
//                 'Proceed with Your Payment',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentScreen extends StatefulWidget {
  final String selectedService;
  final double selectedcost;
  final String bookingId;
  

  PaymentScreen({
    required this.selectedService,
    required this.selectedcost,
    required this.bookingId,
    
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  bool _paymentSuccess = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");
    final bookingRef = FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId);

    bookingRef.update({'paymentStatus': 'done'}).then((_) {
      print("Payment status updated to done");
      setState(() {
        _paymentSuccess = true; // Set payment success flag
      });

      // Show toast message
      Fluttertoast.showToast(
        msg: "Payment successful! your paymentid ${response.paymentId}",
        toastLength: Toast.LENGTH_LONG,
      );
    }).catchError((error) {
      print("Error updating payment status: $error");
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    Fluttertoast.showToast(
      msg: "Payment error: ${response.message}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    final bookingRef = FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId);

    bookingRef.update({'paymentStatus': 'done'}).then((_) {
      print("Payment status updated to done");
      setState(() {
        _paymentSuccess = true; // Set payment success flag
      });

      // Show toast message
      Fluttertoast.showToast(
        msg: "Payment successful! ${response.walletName}",
        toastLength: Toast.LENGTH_LONG,
      );
    }).catchError((error) {
      print("Error updating payment status: $error");
    });
    print("External Wallet: ${response.walletName}");
    
    
  }

  void _triggerPayment() {
    var options = {
      'key': 'rzp_test_1s2n3fSk85sXEt',
      'amount': (widget.selectedcost * 100).toInt(), // Amount in smallest currency unit (paise)
      'name': 'Barber Shop',
      'description': 'Payment for ${widget.selectedService}',
      'prefill': {
        'contact': 'USER_CONTACT', // Optional: Fetch from user profile if available
        'email': 'USER_EMAIL', // Optional: Fetch from user profile if available
      },
      'payment_method': ['upi'],
      'external': {
        'wallets': ['phonepe', 'paytm'] // Enable PhonePe and Paytm wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error in payment: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark theme background
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Text(
                  'Payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Please proceed to secure payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _triggerPayment, // Trigger payment function
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Button color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black87,
                  ),
                  child: Text(
                    'Proceed with Your Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          if (_paymentSuccess)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.green,
                child: Text(
                  'Payment successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


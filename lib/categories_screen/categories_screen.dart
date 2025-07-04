// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MyCartScreen extends StatefulWidget {
//   @override
//   _MyCartScreenState createState() => _MyCartScreenState();
// }

// class _MyCartScreenState extends State<MyCartScreen> {
//   late Future<DocumentSnapshot> _cartsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _cartsFuture = _fetchCarts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: _cartsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             print("fgeggjjjjjjjjjjjjjjdf");
//             List<dynamic>? carts = snapshot.data?.get('carts');
// if (carts == null) {
//   print("&&&&&&&&&&&&&&&&&&&&&&&&&&");
//   // Handle case where 'carts' field is missing or null
//   return Center(child: Text('No items in cart'));
// }
// else{
//   print("ëlse selseff");
// }

//             return ListView.builder(
//               itemCount: carts?.length ?? 0,
//               itemBuilder: (context, index) {
//                 var cart = carts![index];
//                 return ListTile(
//                   title: Text(
//                     'Shop Name: ${cart['shopName']}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text('Service Category: ${cart['serviceCategory']}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.cancel),
//                     onPressed: () {
//                       _cancelCart(snapshot.data!.reference, cart);
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<DocumentSnapshot> _fetchCarts() async {
//     final user = FirebaseAuth.instance.currentUser;
//     return FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
//   }

//   void _cancelCart(DocumentReference userRef, Map<String, dynamic> cart) async {
//     try {
//       DocumentSnapshot userDoc = await userRef.get();
//       List<dynamic>? carts = userDoc['carts'];
//       String deletedShop = cart['shopName'];
//       carts?.removeWhere((c) => c['shopName'] == cart['shopName']);
//       await userRef.update({'carts': carts});
//       _showCancellationMessage(context, deletedShop);
//       setState(() {});
//     } catch (e) {
//       print('Error cancelling cart: $e');
//     }
//   }

//   void _showCancellationMessage(BuildContext context, String shopName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Cancellation Successful',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
//           ),
//           content: Text(
//             'Your cart with $shopName has been cancelled successfully.',
//             style: TextStyle(fontSize: 16, color: Colors.black87),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'OK',
//                 style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 151, 213, 166)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  late Future<DocumentSnapshot> _cartsFuture;

  @override
  void initState() {
    super.initState();
    _cartsFuture = _fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _cartsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            try {
              List<dynamic>? carts = snapshot.data?.get('carts');
              if (carts == null || carts.isEmpty) {
                return Center(child: Text('Your cart is empty.'));
              }
              return ListView.builder(
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  var cart = carts[index];
                  return ListTile(
                    title: Text(
                      'Shop Name: ${cart['shopName']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Service Category: ${cart['serviceCategory']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _cancelCart(snapshot.data!.reference, cart);
                      },
                    ),
                  );
                },
              );
            } catch (e) {
              return Center(child: Text('your cart is empty 🛒...'));
            }
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> _fetchCarts() async {
    final user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
    return userRef.get();
  }

  void _cancelCart(DocumentReference userRef, Map<String, dynamic> cart) async {
    try {
      DocumentSnapshot userDoc = await userRef.get();
      List<dynamic> carts = userDoc['carts'];
      String deletedShop = cart['shopName'];
      carts.removeWhere((c) => c['shopName'] == cart['shopName']);
      await userRef.update({'carts': carts});
      _showCancellationMessage(context, deletedShop);
      setState(() {});
    } catch (e) {
      print('Error cancelling cart: $e');
    }
  }

  void _showCancellationMessage(BuildContext context, String shopName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancellation Successful',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
          content: Text(
            'Your cart with $shopName has been cancelled successfully.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 151, 213, 166)),
              ),
            ),
          ],
        );
      },
    );
  }
}




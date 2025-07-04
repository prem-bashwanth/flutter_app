// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';


// // import 'package:firebase_storage/firebase_storage.dart';

// // class Barbershops extends StatefulWidget {
// //   const Barbershops({Key? key}) : super(key: key);

// //   @override
// //   State<Barbershops> createState() => _BarbershopsState();
// // }

// // class _BarbershopsState extends State<Barbershops> {
// //   late String _barberId;
// //   late Future<String> _imageUrl;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Barbers'),
// //         backgroundColor: Colors.blueGrey,
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.hasError) {
// //             return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
// //           }
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           return SizedBox(
// //             height: 250, // Adjust height to fit the card
// //             child: ListView.builder(
// //               scrollDirection: Axis.horizontal,
// //               itemCount: snapshot.data?.docs.length ?? 0,
// //               itemBuilder: (context, index) {
// //                 var document = snapshot.data!.docs[index];
// //                 _barberId = document.id;
// //                 var data = document.data() as Map<String, dynamic>;
// //                 _imageUrl = _getFirstImage(); // Retrieve the first image URL asynchronously
// //                 return FutureBuilder<String>(
// //                   future: _imageUrl,
// //                   builder: (context, snapshot) {
// //                     if (snapshot.connectionState == ConnectionState.waiting) {
// //                       return CircularProgressIndicator(); // Placeholder while loading image
// //                     }
// //                     if (snapshot.hasError) {
// //                       return Text('Error: ${snapshot.error}');
// //                     }
// //                     return GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(context, MaterialPageRoute(
// //                           builder: (context) => BarberDetailsScreen(barberData: data, ),
// //                         ));
// //                       },
// //                       child: Card(
// //                         margin: EdgeInsets.all(8),
// //                         child: Column(
// //                           children: [
// //                             snapshot.data != null ? Image.network(
// //                               snapshot.data!, // Example: replace with your image field
// //                               height: 160,
// //                               width: 160,
// //                               fit: BoxFit.cover,
// //                             ) : Container(), // Handle empty imageUrl
// //                             Padding(
// //                               padding: EdgeInsets.all(8),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text(data['name'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
// //                                   Text(data['shopAddress'] ?? 'No address provided'),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Future<String> _getFirstImage() async {
// //     Reference ref = FirebaseStorage.instance.ref().child('barberImages/$_barberId');
// //     ListResult result = await ref.listAll();
// //     if (result.items.isNotEmpty) {
// //       return result.items.last.getDownloadURL();
// //     }
// //     return ''; // Return empty string if no images found
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';

// // class Barbershops extends StatefulWidget {
// //   const Barbershops({Key? key}) : super(key: key);

// //   @override
// //   State<Barbershops> createState() => _BarbershopsState();
// // }

// // class _BarbershopsState extends State<Barbershops> {


// //   @override
// //   Widget build(BuildContext context) {
// //     return buildBarberList();
// //   }

//   Widget buildBarberList() {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }
//       return SizedBox(
//         height: 250, // Adjust height to fit the card
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: snapshot.data?.docs.length ?? 0,
//           itemBuilder: (context, index) {
//             var document = snapshot.data!.docs[index];
//             var barberId = document.id;
//             var data = document.data() as Map<String, dynamic>;
//             return FutureBuilder<String>(
//               future: _getFirstImage(barberId), // Pass the barberId to _getFirstImage
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator(); // Placeholder while loading image
//                 }
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => BarberDetailsScreen(barberData: data),
//                     ));
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(8),
//                     child: Column(
//                       children: [
//                         snapshot.data != null ? Image.network(
//                           snapshot.data!, // Example: replace with your image field
//                           height: 160,
//                           width: 160,
//                           fit: BoxFit.cover,
//                         ) : Container(), // Handle empty imageUrl
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(data['name'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
//                               Text(data['shopAddress'] ?? 'No address provided'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       );
//     },
//   );
// }

// Future<String> _getFirstImage(String barberId) async {
//   Reference ref = FirebaseStorage.instance.ref().child('barberImages/$barberId');
//   ListResult result = await ref.listAll();
//   if (result.items.isNotEmpty) {
//     return result.items.last.getDownloadURL();
//   }
//   return ''; // Return empty string if no images found
// }


  
// //}


// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';

// // class Barbershops extends StatelessWidget {
// //   const Barbershops({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Barbers'),
// //         backgroundColor: Colors.blueGrey,
// //       ),
// //       body: BarberList(),
// //     );
// //   }
// // }

// // class BarberList extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
// //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (snapshot.hasError) {
// //           return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
// //         }
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //         return SizedBox(
// //           height: 250, // Adjust height to fit the card
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: snapshot.data?.docs.length ?? 0,
// //             itemBuilder: (context, index) {
// //               var document = snapshot.data!.docs[index];
// //               var barberId = document.id;
// //               var data = document.data() as Map<String, dynamic>;
// //               return FutureBuilder<String>(
// //                 future: _getFirstImage(barberId),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return CircularProgressIndicator(); // Placeholder while loading image
// //                   }
// //                   if (snapshot.hasError) {
// //                     return Text('Error: ${snapshot.error}');
// //                   }
// //                   return GestureDetector(
// //                     onTap: () {
// //                       Navigator.push(context, MaterialPageRoute(
// //                         builder: (context) => BarberDetailsScreen(barberData: data),
// //                       ));
// //                     },
// //                     child: Card(
// //                       margin: EdgeInsets.all(8),
// //                       child: Column(
// //                         children: [
// //                           snapshot.data != null ? Image.network(
// //                             snapshot.data!, // Example: replace with your image field
// //                             height: 160,
// //                             width: 160,
// //                             fit: BoxFit.cover,
// //                           ) : Container(), // Handle empty imageUrl
// //                           Padding(
// //                             padding: EdgeInsets.all(8),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(data['name'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
// //                                 Text(data['shopAddress'] ?? 'No address provided'),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Future<String> _getFirstImage(String barberId) async {
// //     Reference ref = FirebaseStorage.instance.ref().child('barberImages/$barberId');
// //     ListResult result = await ref.listAll();
// //     if (result.items.isNotEmpty) {
// //       return result.items.last.getDownloadURL();
// //     }
// //     return ''; // Return empty string if no images found
// //   }
// // }

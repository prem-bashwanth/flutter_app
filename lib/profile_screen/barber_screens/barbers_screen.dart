

// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:new_project/editprofile_screen.dart';
// // // import 'package:new_project/profile_screen/barber_screens/barber_booking.dart';

// // // class BarberListScreen extends StatefulWidget {
// // //   const BarberListScreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<BarberListScreen> createState() => _BarberListScreenState();
// // // }

// // // class _BarberListScreenState extends State<BarberListScreen> {
// // //   late String selectedBarber;
// // //   late String selectedService;
// // //   late double selectedcost;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Barbers'),
// // //         backgroundColor:Colors.blueGrey, // Change app bar color
// // //       ),
// // //       body: StreamBuilder<QuerySnapshot>(
// // //         stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
// // //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //           if (snapshot.hasError) {
// // //             return Center(
// // //               child: Text(
// // //                 'Something went wrong',
// // //                 style: TextStyle(color: Colors.red), // Error message color
// // //               ),
// // //             );
// // //           }

// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return Center(
// // //               child: CircularProgressIndicator(), // Loading indicator
// // //             );
// // //           }

// // //           return ListView(
// // //             padding: EdgeInsets.all(16), // Add padding to the list
// // //             children: snapshot.data!.docs.map((DocumentSnapshot document) {
// // //               Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

// // //               // Check if data is null
// // //               if (data == null) {
// // //                 return SizedBox.shrink();
// // //               }

// // //               return Card(
// // //                 elevation: 3, // Add elevation for a shadow effect
// // //                 margin: EdgeInsets.symmetric(vertical: 8), // Add vertical margin between cards
// // //                 child: ExpansionTile(
// // //                   title: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text('Name: ${data['name'] ?? ''}'),
// // //                       Text('Address: ${data['shopAddress'] ?? ''}'),
// // //                       Text('Description: ${data['description'] ?? ''}'),
// // //                       Text('Offers: ${data['offers'] ?? ''}'),
// // //                       Text('Offer Duration: ${data['offerDuration'] ?? ''}'),
// // //                       Text('Services Offered:', style: TextStyle(fontWeight: FontWeight.bold)),
// // //                     ],
// // //                   ),
// // //                   children: data['services'] != null
// // //                       ? data['services'].map<Widget>((service) {
// // //                           return ListTile(
// // //                             title: Text(service ?? ''),
// // //                             subtitle: Text(
// // //                                 'Prices: ${data['prices'] != null ? data['prices'][data['services'].indexOf(service)] ?? '' : ''}'),
// // //                             onTap: () {
// // //                               setState(() {
// // //                                 selectedBarber = data['name'] ?? '';
// // //                                 selectedService = service ?? '';
// // //                                 selectedcost = data['prices'][data['services'].indexOf(service)] ?? '';
// // //                               });
// // //                               // You can add your logic here for handling the tap event
// // //                               showDialog(
// // //               context: context,
// // //               builder: (BuildContext context) {
// // //                 return AlertDialog(
                  
// // //                   content: SingleChildScrollView(
// // //                     child: ListBody(
// // //                       children: <Widget>[
                        
// // //                         Padding(padding: EdgeInsets.all(8.0)),
// // //                         GestureDetector(
// // //                           child: Text("Book Service"),
// // //                           onTap: () async {
// // //                             Navigator.push(
// // //                               context,
// // //                               MaterialPageRoute(builder: (context) => BookingScreen(selectedService: selectedService,
// // //                                 selectedBarber: selectedBarber,selectedcost:selectedcost )),
// // //                             );
// // //                           },
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             );
// // //                             },
// // //                           );
// // //                         }).toList()
// // //                       : [],
// // //                 ),
// // //               );
// // //             }).toList(),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:new_project/editprofile_screen.dart';
// // import 'package:new_project/profile_screen/barber_screens/barber_booking.dart';

// // class BarberListScreen extends StatefulWidget {
// //   const BarberListScreen({Key? key}) : super(key: key);

// //   @override
// //   State<BarberListScreen> createState() => _BarberListScreenState();
// // }

// // class _BarberListScreenState extends State<BarberListScreen> {
// //   late String selectedBarber;
// //   late String selectedService;
// //   late double selectedcost;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Barbers'),
// //         backgroundColor: Colors.blueGrey, // Change app bar color
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text(
// //                 'Something went wrong',
// //                 style: TextStyle(color: Colors.red), // Error message color
// //               ),
// //             );
// //           }

// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(
// //               child: CircularProgressIndicator(), // Loading indicator
// //             );
// //           }

// //           return ListView(
// //             padding: EdgeInsets.all(16), // Add padding to the list
// //             children: snapshot.data!.docs.map((DocumentSnapshot document) {
// //               Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

// //               // Check if data is null
// //               if (data == null) {
// //                 return SizedBox.shrink();
// //               }

// //               return Card(
// //                 elevation: 3, // Add elevation for a shadow effect
// //                 margin: EdgeInsets.symmetric(vertical: 8), // Add vertical margin between cards
// //                 child: ExpansionTile(
// //                   title: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text('Name: ${data['name'] ?? ''}'),
// //                       Text('Address: ${data['shopAddress'] ?? ''}'),
// //                       Text('Description: ${data['description'] ?? ''}'),
// //                       Text('Offers: ${data['offers'] ?? ''}'),
// //                       Text('Offer Duration: ${data['offerDuration'] ?? ''}'),
// //                       Text('Services Offered:', style: TextStyle(fontWeight: FontWeight.bold)),
// //                     ],
// //                   ),
// //                   children: data['services'] != null
// //                       ? data['services'].map<Widget>((service) {
// //                           return ListTile(
// //                             title: Text(service ?? ''),
// //                             subtitle: Text(
// //                                 'Prices: ${data['prices'] != null ? data['prices'][data['services'].indexOf(service)] ?? '' : ''}'),
// //                             onTap: () {
// //                               setState(() {
// //                                 selectedBarber = data['name'] ?? '';
// //                                 selectedService = service ?? '';
// //                                 selectedcost = (data['prices'][data['services'].indexOf(service)] ?? 0).toDouble();

// //                               });
// //                               // You can add your logic here for handling the tap event
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) => BookingScreen(
// //                                     selectedService: selectedService,
// //                                     selectedBarber: selectedBarber,
// //                                     selectedcost: selectedcost,
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                           );
// //                         }).toList()
// //                       : [],
// //                 ),
// //               );
// //             }).toList(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class BarberListScreen extends StatefulWidget {
//   const BarberListScreen({Key? key}) : super(key: key);

//   @override
//   State<BarberListScreen> createState() => _BarberListScreenState();
// }

// class _BarberListScreenState extends State<BarberListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Barbers'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return SizedBox(
//             height: 250, // Adjust height to fit the card
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: snapshot.data?.docs.length ?? 0,
//               itemBuilder: (context, index) {
//                 var document = snapshot.data!.docs[index];
//                 var data = document.data() as Map<String, dynamic>;
//                 print(document.id);
//                 print("******************************");
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => BarberDetailsScreen(barberData: data),
//                     ));
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(8),
//                     child: FutureBuilder<String?>(
//                       future: _getImageURL(data['image']), // Fetch image URL from Firebase Storage
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }
//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         return Column(
//                           children: [
//                             Image.network(
//                               snapshot.data ?? 'default_image.png', // Use the fetched URL or a default image
//                               height: 160,
//                               width: 160,
//                               fit: BoxFit.cover,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(data['name'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
//                                   Text(data['shopAddress'] ?? 'No address provided'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<String?> _getImageURL(String? imagePath) async {
//     if (imagePath == null) return null;
//     try {
//       var ref = FirebaseStorage.instance.ref().child(imagePath);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       print('Error fetching image URL: $e');
//       return null;
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';


// import 'package:firebase_storage/firebase_storage.dart';

// class BarberListScreen extends StatefulWidget {
//   const BarberListScreen({Key? key}) : super(key: key);

//   @override
//   State<BarberListScreen> createState() => _BarberListScreenState();
// }

// class _BarberListScreenState extends State<BarberListScreen> {
//   late String _barberId;
//   late Future<String> _imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Barbers'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return SizedBox(
//             height: 250, // Adjust height to fit the card
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: snapshot.data?.docs.length ?? 0,
//               itemBuilder: (context, index) {
//                 var document = snapshot.data!.docs[index];
//                 _barberId = document.id;
//                 var data = document.data() as Map<String, dynamic>;
//                 _imageUrl = _getFirstImage(); // Retrieve the first image URL asynchronously
//                 return FutureBuilder<String>(
//                   future: _imageUrl,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator(); // Placeholder while loading image
//                     }
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => BarberDetailsScreen(barberData: data, ),
//                         ));
//                       },
//                       child: Card(
//                         margin: EdgeInsets.all(8),
//                         child: Column(
//                           children: [
//                             snapshot.data != null ? Image.network(
//                               snapshot.data!, // Example: replace with your image field
//                               height: 160,
//                               width: 160,
//                               fit: BoxFit.cover,
//                             ) : Container(), // Handle empty imageUrl
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(data['name'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
//                                   Text(data['shopAddress'] ?? 'No address provided'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<String> _getFirstImage() async {
//     Reference ref = FirebaseStorage.instance.ref().child('barberImages/$_barberId');
//     ListResult result = await ref.listAll();
//     if (result.items.isNotEmpty) {
//       return result.items.last.getDownloadURL();
//     }
//     return ''; // Return empty string if no images found
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_project/common_widgets.dart/switch.dart';
import 'package:new_project/notifications_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barber_details_screen.dart';
import 'package:new_project/profile_screen/barber_screens/barbershops.dart';
import 'package:new_project/searched_screen.dart';

class BarberListScreen extends StatefulWidget {
  @override
  State<BarberListScreen> createState() => _BarberListScreenState();
}

class _BarberListScreenState extends State<BarberListScreen> {
  // Assuming these variables are fetched from some methods
  String userName = "User"; // Placeholder value, replace with actual data fetching logic
  String address = "Loading..."; // Placeholder value, replace with actual data fetching logic
  Future<void> fetchUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
      setState(() {
        address =
            '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}';
      });
    } catch (e) {
      print('Error fetching user location: $e');
    }
  }
   Future<void> fetchUserData() async {

    try {
      final user = FirebaseAuth.instance.currentUser;
if (user != null) {
  final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  // Use userData or perform further operations here
  setState(() {
        userName = userData['name'];
      });
} else {
  // Handle the case where user is null
}
      
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchUserLocation();
    fetchUserData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color.fromARGB(255, 246, 245, 245),
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  color: Color.fromARGB(255, 105, 100, 100),
                                  size: 26.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  'Hi, $userName',
                                  style: TextStyle(
                                    fontSize: 23.50,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0), // Adjust spacing between username and address
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(227, 182, 16, 4),
                                  size: 26.0,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    '$address',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromARGB(255, 5, 5, 5),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to notifications screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NotificationsScreen(userName: userName)),
                                    );
                                  },
                                  child: Icon(
                                    Icons.notifications,
                                    color: const Color.fromARGB(255, 8, 8, 8),
                                    size: 26.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                color: Colors.black,
                child: Row(
                  children: [
                    SizedBox(width: 16.0),
                    Image.asset(
                      'assets/icons/banner_image.jpg', // Replace with your asset image
                      width: 360.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NearbyShopsScreen(searchedAddress: value),
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search anything...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.filter_list),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, shape: CircleBorder(), backgroundColor: Colors.grey[200],
                            padding: EdgeInsets.all(14.0),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10.0),
                    // Row(
                    //   children: [
                    //     Icon(Icons.location_on, color: Colors.grey),
                    //     SizedBox(width: 10.0),
                    //     Text(
                    //       'Please choose your address',
                    //       style: TextStyle(color: Colors.grey),
                    //     ),
                    //     Spacer(),
                    //     Icon(Icons.settings, color: Colors.grey),
                    //   ],
                    // ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended for you',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text('View All'),
                        // ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    buildBarberList(),
  
                    SizedBox(
  height: 400, // Adjust height as needed
  child: SwitchWidget(userlocation: address),
),

                  ],
                  
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }


  Widget buildBarberList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('barbers').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      return SizedBox(
        height: 300, // Adjusted for uniformity
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data?.docs.length ?? 0,
          itemBuilder: (context, index) {
            var document = snapshot.data!.docs[index];
            var barberId = document.id;
            var data = document.data() as Map<String, dynamic>;
            return FutureBuilder<String>(
              future: _getFirstImage(barberId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BarberDetailsScreen(barberData: data,barberId:barberId),
                    ));
                  },
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Container(
                      width: 270,
                      color: Colors.white, // Ensure the inner container is white
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: snapshot.data != null ? Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ) : Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 96, 77, 77),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'] ?? 'Unisex salon',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    data['shopAddress'] ?? 'No address provided',
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

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
//         height: 300, // Adjusted for uniformity
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: snapshot.data?.docs.length ?? 0,
//           itemBuilder: (context, index) {
//             var document = snapshot.data!.docs[index];
//             var barberId = document.id;
//             var data = document.data() as Map<String, dynamic>;
//             return FutureBuilder<String>(
//               future: _getFirstImage(barberId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => BarberDetailsScreen(barberData: data),
//                     ));
//                   },
//                   child: Theme( // Override the theme for this card
//                     data: Theme.of(context).copyWith(cardColor: Colors.white),
//                     child: Card(
//                       elevation: 10,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                       child: Container(
//                         width: 270,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Expanded(
//                                 child: snapshot.data != null ? Image.network(
//                                   snapshot.data!,
//                                   fit: BoxFit.cover,
//                                 ) : Container(
//                                   decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 96, 77, 77),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       data['name'] ?? 'N/A',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       data['shopAddress'] ?? 'No address provided',
//                                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
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


Future<String> _getFirstImage(String barberId) async {
  Reference ref = FirebaseStorage.instance.ref().child('barberImages/$barberId');
  ListResult result = await ref.listAll();
  if (result.items.isNotEmpty) {
    return result.items.last.getDownloadURL(); // Suggesting to use the first image for consistency
  }
  return ''; // Return empty string if no images found
}


//   Widget _buildRecommendedCard(BuildContext context, String imageUrl, String title) {
//     return GestureDetector(
//       onTap: () {
//         // Handle card tap
//       },
//       child: Card(
//         margin: EdgeInsets.all(8.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Container(
//           width: 160.0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//                 child: Image.asset(
//                   imageUrl,
//                   height: 140.0,
//                   width: 160.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       '0.00 km',
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}

// class NotificationsScreen extends StatelessWidget {
//   final String userName;

//   const NotificationsScreen({Key? key, required this.userName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: Center(
//         child: Text('Notifications for $userName'),
//       ),
//     );
//   }
// }

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:new_project/common_widgets.dart/switch.dart';
// import 'package:new_project/listofshops.dart';
// import 'package:new_project/lists.dart';
// import 'package:new_project/notifications_screen.dart';
// import 'package:new_project/searched_screen.dart';
// import 'package:new_project/shops_withcategory.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'dart:convert';


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String address = 'Loading...';
//   String userName = '';
//   List<dynamic> nearbyShops = [];

// //   @override
  


//   Future<void> fetchUserLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       Placemark placemark = placemarks.first;
//       setState(() {
//         address =
//             '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}';
//       });
//     } catch (e) {
//       print('Error fetching user location: $e');
//     }
//   }

//   Future<void> fetchUserData() async {

//     try {
//       final user = FirebaseAuth.instance.currentUser;
// if (user != null) {
//   final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//   // Use userData or perform further operations here
//   setState(() {
//         userName = userData['name'];
//       });
// } else {
//   // Handle the case where user is null
// }
      
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }

// Future<void> fetchNearbyShops(String address) async {
//     // Step 1: Geocode address to get coordinates
//     var shops = await _fetchCoordinates(address);

//     // Step 2: Fetch nearby shops using coordinates

//     setState(() {
//       nearbyShops = shops;
//     });
//   }
// Future<List<dynamic>> _fetchCoordinates(String vicinity) async {
//   String apiKey = 'AIzaSyBy9kfOVTl3SxLRB_ZRK7R6ww80umGPcVQ';
//   String geocodeUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
//   String nearbySearchUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

//   try {
//     // Step 1: Fetch coordinates for the searched vicinity
//     http.Response response = await http.get(Uri.parse('$geocodeUrl?address=$vicinity&key=$apiKey'));
    
//     if (response.statusCode == 200) {
//       Map<String, dynamic> geocodeData = json.decode(response.body);

//       if (geocodeData['status'] == 'OK') {
//         double latitude = geocodeData['results'][0]['geometry']['location']['lat'];
//         double longitude = geocodeData['results'][0]['geometry']['location']['lng'];

//         // Step 2: Fetch nearby shops based on the coordinates
//         http.Response nearbyResponse = await http.get(Uri.parse('$nearbySearchUrl?location=$latitude,$longitude&radius=500&type=hair_care&key=$apiKey'));

//         if (nearbyResponse.statusCode == 200) {
//           Map<String, dynamic> nearbyData = json.decode(nearbyResponse.body);

//           if (nearbyData['status'] == 'OK') {
//             List<dynamic> results = nearbyData['results'];

//             // Step 3: Process and display nearby shops
//             List<Widget> shopWidgets = [];

//             for (var result in results) {
//               double shopLat = result['geometry']['location']['lat'];
//               double shopLng = result['geometry']['location']['lng'];
//               String shopName = result['name'];
//               String shopVicinity = result['vicinity'];
//               double distance = _calculateDistance(latitude, longitude, shopLat, shopLng);
//               String imageUrl = result['photos'] != null && result['photos'].isNotEmpty
//             ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=$apiKey'
//             : '';
//               shopWidgets.add(
//                 HaircareShopWidget(
//                   category: "Haircut", // Example category
//                   distance: distance,
//                   name: shopName,
//                   vicinity: shopVicinity,
//                   imageUrl:imageUrl, // Add image URL if available
//                   lat: shopLat,
//                   lon: shopLng,
//                 ),
//               );
//             }

//             // Display the list of nearby shops
//             // Replace with your preferred way of displaying shops (ListView, GridView, etc.)
//             return shopWidgets;
//             print('Nearby shops count: ${shopWidgets.length}');
//             // Add your code to display the shopWidgets
//           } else {
//             throw Exception('Error: ${nearbyData['status']}');
//           }
//         } else {
//           throw Exception('Failed to fetch nearby shops');
//         }
//       } else {
//         throw Exception('Error: ${geocodeData['status']}');
//       }
//     } else {
//       throw Exception('Failed to fetch coordinates');
//     }
//   } catch (e) {
//     print('Error: $e');
//     return [];
//   }
// }

// double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//   const int earthRadius = 6371; // Radius of the Earth in kilometers
//   double dLat = _degreesToRadians(lat2 - lat1);
//   double dLon = _degreesToRadians(lon2 - lon1);
//   double a = pow(sin(dLat / 2), 2) + cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * pow(sin(dLon / 2), 2);
//   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//   return earthRadius * c;
// }

// double _degreesToRadians(double degrees) {
//   return degrees * pi / 180;
// }

// @override
//   void initState() {
//     super.initState();
//     fetchUserLocation();
//     fetchUserData();
//   }
// Widget build(BuildContext context) {
//   return Container(
//     color: Color.fromARGB(255, 246, 245, 245),
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//     child: SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//   padding: EdgeInsets.all(12.0),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(12.0),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 2,
//         blurRadius: 5,
//         offset: Offset(0, 2),
//       ),
//     ],
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Icon(
//             Icons.account_circle_outlined,
//             color: Color.fromARGB(255, 105, 100, 100),
//             size: 26.0,
//           ),
//           SizedBox(width: 4.0),
//           Text(
//             'Hi, $userName',
//             style: TextStyle(
//               fontSize: 23.50,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: 4.0), // Adjust spacing between username and address
//       Row(
//         children: [
//           Icon(
//             Icons.location_on,
//             color: Color.fromARGB(227, 182, 16, 4),
//             size: 26.0,
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               '$address',
//               style: TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.grey[600],
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               // Navigate to notifications screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsScreen(userName:userName)),
//               );
//             },
//             child: Icon(
//               Icons.notifications,
//               color: Colors.grey[600],
//               size: 26.0,
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),

//           SizedBox(height: 16.0),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: TextFormField(
//               onFieldSubmitted: (value) {
//                   Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => NearbyShopsScreen(  searchedAddress:value),
//   ),
// );

//                 },
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'Search anything...',
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   vertical: 16.0,
//                   horizontal: 20.0,
//                 ),
//               ),
//             ),
//           ),
          
//           Expanded(
//   child: Column(
//     children: [
//       VxSwiper.builder(
//         aspectRatio: 16 / 9,
//         autoPlay: true,
//         height: 165,
//         enlargeCenterPage: true,
//         itemCount: slidersList.length,
//         itemBuilder: (context, index) {
//           return Image.asset(
//             slidersList[index],
//             fit: BoxFit.fill,
//           ).box.rounded.clip(Clip.antiAlias).margin(
//             EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//           ).make();
//         },
//       ),
//       Expanded(
//         // child: SwitchWidget(userlocation :address ),
//         child: SwitchWidget(userlocation:address ),
//       ),
//     ],
//   ),
// ),

//         ],
//       ),
//     ),
//   );
// }

// }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Color.fromARGB(255, 246, 245, 245),
// //       width: MediaQuery.of(context).size.width,
// //       height: MediaQuery.of(context).size.height,
// //       child: SafeArea(
// //         child: Column(
          
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
           
// // Container(
// //   padding: EdgeInsets.all(12.0),
// //   decoration: BoxDecoration(
// //     color: Colors.white,
// //     borderRadius: BorderRadius.circular(12.0),
// //     boxShadow: [
// //       BoxShadow(
// //         color: Colors.grey.withOpacity(0.5),
// //         spreadRadius: 2,
// //         blurRadius: 5,
// //         offset: Offset(0, 2),
// //       ),
// //     ],
// //   ),
// //   child: Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Row(
// //         children: [
// //           Icon(
// //             Icons.account_circle_outlined,
// //             color: Color.fromARGB(255, 105, 100, 100),
// //             size: 26.0,
// //           ),
// //           SizedBox(width: 4.0),
// //           Text(
// //             'Hi, $userName',
// //             style: TextStyle(
// //               fontSize: 23.50,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //         ],
// //       ),
// //       SizedBox(height: 4.0), // Adjust spacing between username and address
// //       Row(
// //         children: [
// //           Icon(
// //             Icons.location_on,
// //             color: Color.fromARGB(227, 182, 16, 4),
// //             size: 26.0,
// //           ),
// //           SizedBox(width: 4.0),
// //           Text(
// //             '$address',
// //             style: TextStyle(
// //               fontSize: 14.0,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //         ],
// //       ),
// //     ],
// //   ),
// // ),

             
            
            
// //             SizedBox(height: 16.0),
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.5),
// //                     spreadRadius: 2,
// //                     blurRadius: 5,
// //                     offset: Offset(0, 2),
// //                   ),
// //                 ],
// //               ),
// //               child: TextFormField(
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(Icons.search),
// //                   hintText: 'Search anything...',
// //                   border: InputBorder.none,
// //                   contentPadding: EdgeInsets.symmetric(
// //                     vertical: 16.0,
// //                     horizontal: 20.0,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             VxSwiper.builder(
// //   aspectRatio: 16 / 9,
// //   autoPlay: true,
// //   height: 165,
// //   enlargeCenterPage: true,
// //   itemCount: slidersList.length,
// //   itemBuilder: (context, index) {
// //     return Image.asset(
// //       slidersList[index],
// //       fit: BoxFit.fill,
// //     ).box.rounded.clip(Clip.antiAlias).margin(
// //       EdgeInsets.symmetric(horizontal: 8, vertical: 2),
// //     ).make();
// //   },
// // ),


// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: 1, // Adjust as needed
// //                 itemBuilder: (context, index) {
// //                   return Container(
// //                     height: MediaQuery.of(context).size.height, // Adjust as needed
// //                     child: SwitchWidget(),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }


// // Future<void> _fetchCoordinates(String vicinity) async {
// //     String apiKey = 'AIzaSyBy9kfOVTl3SxLRB_ZRK7R6ww80umGPcVQ';
// //     String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
// //     String url = '$baseUrl?address=$vicinity&key=$apiKey';

// //     try {
// //       http.Response response = await http.get(Uri.parse(url));

// //       if (response.statusCode == 200) {
// //         Map<String, dynamic> data = json.decode(response.body);

// //         if (data['status'] == 'OK') {
// //           double latitude = data['results'][0]['geometry']['location']['lat'];
// //           double longitude = data['results'][0]['geometry']['location']['lng'];

// //           print('=========================================================================================');
// //           print('Latitude: $latitude, Longitude: $longitude');
// //           print('=========================================================================================');
// //           FutureBuilder(
// //                   future: getNearbyHaircareShopswithcategory(latitude, longitude,0),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.connectionState == ConnectionState.waiting) {
// //                       return const CircularProgressIndicator();
// //                     } else if (snapshot.hasError) {
// //                       return Text('Error: ${snapshot.error}');
// //                     } else {
// //                       final List<dynamic> haircareShops = snapshot.data as List<dynamic>;

// //                       if (haircareShops.isEmpty) {
// //                         return Center(
// //                           child: Text('No hair care shops nearby.'),
// //                         );
// //                       }

// //                       List<Widget> shopWidgets = [];

// //                       for (int i = 0; i < haircareShops.length; i++) {
// //                         HaircareShop shop = haircareShops[i];

// //                         shopWidgets.add(
// //                           HaircareShopWidget(
// //                             category:"Haircut" ,
// //                             distance: shop.distance * 1000,
// //                             name: shop.name,
// //                             vicinity: shop.vicinity,
// //                             imageUrl: shop.imageUrl,
// //                             lat: 1,
// //                             lon: 2,
// //                           ),
// //                         );
// //                       }
// //                       print(haircareShops.length);
// //                                  print(haircareShops.length);

// //                       return ListView(
// //                         shrinkWrap: true,
// //                         physics: NeverScrollableScrollPhysics(),
// //                         children: shopWidgets,
// //                       );
// //                     }
// //                   },
// //                 );
              
// //           print('Latitude: $latitude, Longitude: $longitude');
// //           print('=========================================================================================');
// //         } else {
// //           throw Exception('Error: ${data['status']}');
// //         }
// //       } else {
// //         throw Exception('Failed to fetch coordinates');
// //       }
// //     } catch (e) {

// //       print('Error: $e');
// //       print('=========');
// //     }
// //   }

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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey),
                        SizedBox(width: 10.0),
                        Text(
                          'get near by shops',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Spacer(),
                        // Icon(Icons.settings, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 10.0),
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





Future<String> _getFirstImage(String barberId) async {
  Reference ref = FirebaseStorage.instance.ref().child('barberImages/$barberId');
  ListResult result = await ref.listAll();
  if (result.items.isNotEmpty) {
    return result.items.last.getDownloadURL(); // Suggesting to use the first image for consistency
  }
  return ''; // Return empty string if no images found
}



}
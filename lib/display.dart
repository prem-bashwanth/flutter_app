// ...

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:new_project/getnearby_shops.dart';
import 'package:new_project/current_location.dart';
import 'package:new_project/listofshops.dart';


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Permission hasn't been granted yet
      requestLocationPermission();
    }
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, proceed with location-related tasks
      // ...
    } else if (status.isDenied) {
      // Permission denied by the user
      // Handle the denial, show a message, or provide an explanation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Permission Denied'),
          content: Text('To use this feature, allow location access in the app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('My App'),
    ),
    body: FutureBuilder(
      future: getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final position = snapshot.data as Position?;

          if (position == null) {
            return Center(
              child: Text('Location not available.'),
            );
          }

          Widget locationWidget = Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Current Location: ${position.latitude}, ${position.longitude}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                locationWidget,
                SizedBox(height: 8), // Add some spacing

                FutureBuilder(
                  future: getNearbyHaircareShops(position.latitude, position.longitude),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<dynamic> haircareShops = snapshot.data as List<dynamic>;

                      if (haircareShops.isEmpty) {
                        return Center(
                          child: Text('No hair care shops nearby.'),
                        );
                      }

                      List<Widget> shopWidgets = [];

                      for (int i = 0; i < haircareShops.length; i++) {
                        HaircareShop shop = haircareShops[i];

                        // shopWidgets.add(
                        //   HaircareShopWidget(
                        //     category: 'Service',
                        //     distance: shop.distance * 1000,
                        //     name: shop.name,
                        //     vicinity: shop.vicinity,
                        //     imageUrl: shop.imageUrl,
                        //     lat:,
                        //   ),
                        // );
                      }

                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: shopWidgets,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    ),
  );
}}









// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     resizeToAvoidBottomInset: false,
//     appBar: AppBar(
//       title: const Text('My App'),
//     ),
//     body: FutureBuilder(
//       future: getCurrentLocation(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final position = snapshot.data as Position?;

//           if (position == null) {
//             // Handle the case where the position is null (e.g., location permission not granted)
//             return Center(
//               child: Text('Location not available.'),
//             );
//           }

//           // Display the current location
//           Widget locationWidget = Container(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Current Location: ${position.latitude}, ${position.longitude}',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           );
// return Column(
//   crossAxisAlignment: CrossAxisAlignment.stretch,
//   children: [
//     locationWidget,
// //     FutureBuilder(
// //       future: getNearbyHaircareShops(position.latitude, position.longitude),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const CircularProgressIndicator();
// //         } else if (snapshot.hasError) {
// //           return Text('Error: ${snapshot.error}');
// //         } else {
// //           final List<dynamic> haircareShops = snapshot.data as List<dynamic>;

// //           if (haircareShops.isEmpty) {
// //             return Center(
// //               child: Text('No hair care shops nearby.'),
// //             );
// //           }else{
// //           for(int i=0;i<haircareShops.length;i++){
// //             HaircareShop shop =haircareShops[i];

// //             HaircareShopWidget(
// //                 distance: shop.distance,
// //                 name: shop.name,
// //                 vicinity: shop.vicinity,
// //                 imageUrl: shop.imageUrl,

// //             );
// //           }
// //           }
// // //           HaircareShop shop =haircareShops[4];
// // //           return Center(
// // //   child: Column(
// // //     mainAxisAlignment: MainAxisAlignment.center,
// // //     children: [
// // //       Text('Number of Hair Care Shops: ${haircareShops.length}'),
// // //       Text('Name of the First Hair Care Shop: ${shop.name}'),
// // //       Text('address First Hair Care Shop: ${shop.vicinity}'),
// // //       Text('distance First Hair Care Shop: ${shop.distance}'),
// // //       shop.imageUrl.isNotEmpty
// // //                         ? Image.network(shop.imageUrl)
// // //                        : Image.asset('assets/KANE.jpeg'),
// // //     ],
// // //   ),
// // // );

 

// //           // return ListView.builder(
// //           //   itemCount: haircareShops.length,
// //           //   itemBuilder: (context, index) {
// //           //     HaircareShop shop = haircareShops[index];
// //           //     return ListTile(
// //           //       title: Text(shop.name),
// //           //       subtitle: Column(
// //           //         crossAxisAlignment: CrossAxisAlignment.start,
// //           //         children: [
// //           //           Text('Location: ${shop.vicinity}'),
// //           //           Text('Distance: ${shop.distance} km'),
// //           //           shop.imageUrl.isNotEmpty
// //           //               ? Image.network(shop.imageUrl)
// //           //               : Image.asset('assets/default_image.png'), // Set a default image
// //           //         ],
// //           //       ),
// //           //     );
// //           //   },
// //           // );
// //         }
// //       },
// //     ),
// FutureBuilder(
//   future: getNearbyHaircareShops(position.latitude, position.longitude),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       final List<dynamic> haircareShops = snapshot.data as List<dynamic>;

//       if (haircareShops.isEmpty) {
//         return Center(
//           child: Text('No hair care shops nearby.'),
//         );
//       } else {

//         List<Widget> shopWidgets = [];

//         for (int i = 0; i < haircareShops.length; i++) {
//           HaircareShop shop = haircareShops[i];

//           // Add HaircareShopWidget to the list
//           shopWidgets.add(
//             HaircareShopWidget(
              
//               distance: shop.distance*1000,
//               name: shop.name,
//               vicinity: shop.vicinity,
//               imageUrl: shop.imageUrl,
//             ),
//           );
//         }

//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               // ... other widgets before the list of shops
//               const SizedBox(height: 8),
//               ListView(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: shopWidgets,
//               ),
//             ],
//           ),
//         );
//          //Create a list to store HaircareShopWidget
        
//         // // Return a widget that contains the list of HaircareShopWidgets
  
//         //  return SingleChildScrollView(
//         //   child: Column(
//         //     children: shopWidgets,
//         // ));
//       }
//     }
//   },
// ),

//   ],
// );


// //           return Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               locationWidget,

// //               FutureBuilder(
// //                 future: getNearbyHaircareShops(position.latitude, position.longitude),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const CircularProgressIndicator();
// //                   } else if (snapshot.hasError) {
// //                     return Text('Error: ${snapshot.error}');
// //                   } else {
// //                     final List<dynamic> haircareShops = snapshot.data as List<dynamic>;

// //                     if (haircareShops.isEmpty) {
// //                       return Center(
// //                         child: Text('No hair care shops nearby.'),
// //                       );
// //                     }
// //                      return ListView.builder(
// //         itemCount: haircareShops.length,
// //         itemBuilder: (context, index) {
// //           HaircareShop shop = haircareShops[index];
// //           return ListTile(
// //             title: Text(shop.name),
// //             subtitle: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Location: ${shop.vicinity}'),
// //                 Text('Distance: ${shop.distance} km'),
// //                 shop.imageUrl.isNotEmpty
// //                         ? Image.network(shop.imageUrl)
// //                         : Image.asset('assets/KANE.jpeg'),
// //               ],
// //             ),
// //           );
// //         },
// //       );
// // //                     return Column(
// // //   children: [
// // //   shops.imageUrl.isNotEmpty
// // //               ? Image.network(shops.imageUrl) // Display image if the URL is not empty
// // //               : const Text("no image"),
// // //    //Text('Address: ${shop.imageUrl}'),
// // //    //Text('Number of Hair Care Shops: ${shop.distance*1000}'),
// // //    ]
// // // );
// // //Text('Number of Hair Care Shops: ${shops.imageUrl}',
// //                     // return ListView.builder(
// //                     //   itemCount: haircareShops.length,
                      
// //                     //   itemBuilder: (context, index) {
// //                     //     // final haircareShop = haircareShops[index];
// //                     //     // Display information about the haircare shop
// //                     //     // return ListTile(
// //                     //     //   title: Text(haircareShop['name']),
// //                     //     //   subtitle: Text(haircareShop['vicinity']),
// //                     //     final haircareShop = haircareShops[0];
// //                     //     // Display information about the haircare shop
// //                     //     return ListTile(
// //                     //       title: Text(haircareShop['name']),
// //                     //       subtitle: Text(haircareShop['vicinity']),
// //                     //     );
// //                     //   },
// //                     // );
// //                   }
// //                 },
// //               ),
// //             ],
// //           );
//         }
//       },
//     ),
//   );
// }
// }









//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My App'),
//       ),
//       body: FutureBuilder(
//         future: getCurrentLocation(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final position = snapshot.data as Position;
//              // Display the current location
//       Widget locationWidget = Container(
//         padding: EdgeInsets.all(16.0),
//         child: Text(
//           'Current Location: ${position.latitude}, ${position.longitude}',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       );

//        return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           locationWidget,


//             FutureBuilder(
//               future: getNearbyHaircareShops(position.latitude, position.longitude),
              
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   final List<dynamic> haircareShops = snapshot.data as List<dynamic>;
//                       if (haircareShops.isEmpty) {
//               return Center(
//                 child: Text('No hair care shops nearby.'),
//               );
//             }

//                   return ListView.builder(
//                     itemCount: haircareShops.length,
//                     itemBuilder: (context, index) {
//                       final haircareShop = haircareShops[index];
//                       // Display information about the haircare shop
//                       return ListTile(
//                         title: Text(haircareShop['name']),
//                         subtitle: Text(haircareShop['vicinity']),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//         ]);
//           }
//         },
//       ),
//     );
//   }
// }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:http/http.dart' as http;

// // class HairCareShopsList extends StatefulWidget {
// //   @override
// //   _HairCareShopsListState createState() => _HairCareShopsListState();
// // }

// // class _HairCareShopsListState extends State<HairCareShopsList> {
// //   List<Shop> shops = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadShops();
// //   }

// //   Future<void> _loadShops() async {
// //     try {
// //       Position position = await _getCurrentLocation();
// //       shops = await _fetchShopsFromAPI(position);
// //     } catch (e) {
// //       // Handle errors here, e.g., show a message to the user
// //       print("Error: $e");
// //     } finally {
// //       // Perform cleanup or additional actions if needed
// //       setState(() {});
// //     }
// //   }

// //   Future<Position> _getCurrentLocation() async {
// //     try {
// //       return await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.high);
// //     } catch (e) {
// //       // Handle location access errors
// //       throw Exception("Error getting location: $e");
// //     }
// //   }

// //   Future<List<Shop>> _fetchShopsFromAPI(Position userPosition) async {
// //      final apiKey = 'AIzaSyCG7X1mJLHGGKxsKNK5GEGgucog2skBsn4';
// //   final radius = 5000; // 5000 meters (adjust as needed)

// //   final url = Uri.parse(
// //     'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
// //     // '?location=$lat,$lon'
// //     '&radius=$radius'
// //     '&type=hair_care'
// //     '&key=$apiKey',
// //   );
// //   final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       // If the server returns a 200 OK response, parse the JSON data
// //       final List<dynamic> rawData = json.decode(response.body);
// //       return rawData
// //           .map((shopData) => Shop(
// //                 name: shopData['name'],
// //                 imageUrl: shopData['image_url'],
// //                 distance: _calculateDistance(
// //                   userPosition.latitude,
// //                   userPosition.longitude,
// //                   shopData['latitude'],
// //                   shopData['longitude'],
// //                 ),
// //               ))
// //           .toList();
// //     } else {
// //       // If the server did not return a 200 OK response, throw an exception
// //       throw Exception("Failed to load shops. Status code: ${response.statusCode}");
// //     }
// //   }

// //   double _calculateDistance(
// //       double userLat, double userLong, double shopLat, double shopLong) {
// //     // Implement distance calculation logic using Haversine formula or other methods
// //     // Replace this with actual distance calculation
// //     return 0.0;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       itemCount: shops.length,
// //       itemBuilder: (context, index) {
// //         Shop shop = shops[index];
// //         return ListTile(
// //           leading: Image.network(shop.imageUrl),
// //           title: Text(shop.name),
// //           subtitle: Text('${shop.distance} km away'),
// //           onTap: () {
// //             // Handle shop selection if needed
// //           },
// //         );
// //       },
// //     );
// //   }
// // }

// class HaircareShop {
//   final String name;
//   final String vicinity;
//   final String imageUrl;
//   final double distance;

//   HaircareShop({required this.name, required this.vicinity, required this.imageUrl, required this.distance});
// }

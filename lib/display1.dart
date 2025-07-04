// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HairCareShopsList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Shop>>(
//       future: _fetchShops(), // Make the API call in this method
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Show loading indicator while fetching data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Text('No shops found.');
//         } else {
//           List<Shop> shops = snapshot.data!;
//           return _buildShopList(shops);
//         }
//       },
//     );
//   }

//   Future<List<Shop>> _fetchShops() async {
//     final apiUrl = 'https://your-api-endpoint.com/shops'; // Replace with your API endpoint
//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         // Parse the JSON response and return a list of shops
//         List<dynamic> data = json.decode(response.body);
//         return data.map((shopData) => Shop.fromJson(shopData)).toList();
//       } else {
//         throw Exception('Failed to load shops, status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching shops: $e');
//     }
//   }

//   Widget _buildShopList(List<Shop> shops) {
//     return ListView.builder(
//       itemCount: shops.length,
//       itemBuilder: (context, index) {
//         Shop shop = shops[index];
//         return ListTile(
//           leading: Image.network(shop.imageUrl),
//           title: Text(shop.name),
//           subtitle: Text('${shop.distance} km away'),
//           onTap: () {
//             // Handle shop selection if needed
//           },
//         );
//       },
//     );
//   }
// }

// class Shop {
//   final String name;
//   final String imageUrl;
//   final double distance;

//   Shop({required this.name, required this.imageUrl, required this.distance});

//   // Factory method to create a Shop instance from JSON data
//   factory Shop.fromJson(Map<String, dynamic> json) {
//     return Shop(
//       name: json['name'],
//       imageUrl: json['imageUrl'],
//       distance: json['distance'].toDouble(),
//     );
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as Math;

class HaircareShop {
  final String name;
  final String vicinity;
  final String imageUrl;
  final double distance;

  HaircareShop({required this.name, required this.vicinity, required this.imageUrl, required this.distance});
}

Future<List<HaircareShop>> getNearbyHaircareShops(double lat, double lon) async {
  //api key for the project
   // Replace with your API key
  final radius = 2000; // 5000 meters (adjust as needed)
  
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
    '?location=$lat,$lon'
    '&radius=$radius'
    '&type=hair_care'
    '&key=$apiKey',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'OK') {
      List<HaircareShop> haircareShops = [];

      for (var result in data['results']) {
        String name = result['name'];
        String vicinity = result['vicinity'];
        String imageUrl = result['photos'] != null && result['photos'].isNotEmpty
            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=$apiKey'
            : ''; // Adjust the photo size as needed
        double distance = result['geometry']['location']['lat'] != null &&
                result['geometry']['location']['lng'] != null
            ? calculateDistance(lat, lon, result['geometry']['location']['lat'], result['geometry']['location']['lng'])
            : 0.0;

        haircareShops.add(HaircareShop(name: name, vicinity: vicinity, imageUrl: imageUrl, distance: distance));
      }

      return haircareShops;
    } else {
      throw Exception('Error: ${data['status']} - ${data['error_message']}');
    }
  } else {
    throw Exception('Failed to load nearby haircare shops');
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0; // Earth radius in kilometers
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);

  double a = Math.pow(Math.sin(dLat / 2), 2) +
      Math.cos(_toRadians(lat1)) * Math.cos(_toRadians(lat2)) * Math.pow(Math.sin(dLon / 2), 2);
  double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return R * c;
}

double _toRadians(double degree) {
  return degree * (Math.pi / 180.0);
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List<dynamic>> getNearbyHaircareShops(double lat, double lon) async {
//   final radius = 500; // 5000 meters (adjust as needed)

//   final url = Uri.parse(
//     'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
//     '?location=$lat,$lon'
//     '&radius=$radius'
//     '&type=hair_care'
//     '&key=$apiKey',
//   );

//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     if (data['status'] == 'OK') {
//       return data['results'];
//     } else {
//       throw Exception('Error: ${data['status']} - ${data['error_message']}');
//     }
//   } else {
//     throw Exception('Failed to load nearby haircare shops');
//   }
// }






// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // Future<List<dynamic>> getNearbyHaircareShops(double lat, double lon) async {
// //   final radius = 500000; // 5000 meters (adjust as needed)

// //   final url = Uri.parse(
// //     'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
// //     '?location=$lat,$lon'
// //     '&radius=$radius'
// //     '&type=hair_care'
// //     '&key=$apiKey',
// //   );




// //   final response = await http.get(url);

// //   if (response.statusCode == 200) {
// //     final Map<String, dynamic> data = json.decode(response.body);
// //     return data['results'];
// //   } else {
// //     throw Exception('Failed to load nearby haircare shops');
// //   }
// // }


//   // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
//   //     latitude.toString() +
//   //     ',' +
//   //     longitude.toString() +
//   //     '&radius=' +
//   //     radius +
//   //     '&key=' +
//   //     apiKey);
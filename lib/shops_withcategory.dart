
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as Math;

class HaircareShop {
  final String name;
  final String vicinity;
  final String imageUrl;
  final double distance;
  final double lat;
  final double lon;

  HaircareShop({required this.name, required this.vicinity, required this.imageUrl, required this.distance,required this.lat,required this.lon});
}

Future<List<HaircareShop>> getNearbyHaircareShopswithcategory(double lat, double lon,int index) async {
  final apiKey = 'AIzaSyBy9kfOVTl3SxLRB_ZRK7R6ww80umGPcVQ'; // Replace with your API key
  final radius = 1500; // 5000 meters (adjust as needed)
  List<String> categoriesNames = [
    'Haircut and Styling',
    'Hair Color',
    'Spa ,Massage',
    'Skin Care ',
    'Eyebrow Services',
    'Manicure and Pedicure',
    'Makeup',
    'Facial',
    'Threading',
  ];
  List<String> type = [
    'hair_care',
    'hair_care',
    'beauty_salon',
    'Skin_Care ',
    'Facial_care',
    'beauty_salon',
    'Makeup',
    'Facial',
    'Threading | spa',
  ];
  
  final String hairtype = categoriesNames[index];
  final String searchtype = type[index];
  final url = Uri.parse(
  'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
  '?location=$lat,$lon'
  '&radius=$radius'
  '&type=$searchtype ' // You can adjust this type according to your requirements
  '&keyword=$hairtype'
   '&rankby=prominence' // Add specific keywords like 'facial'
  '&key=$apiKey',
  
);


  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'OK') {
      List<HaircareShop> haircareShops = [];

      for (var result in data['results']) {
        double shoplat=result['geometry']['location']['lat'] != null ? result['geometry']['location']['lat'] : null;
        double shoplon=result['geometry']['location']['lng'] != null ?  result['geometry']['location']['lng'] : null;
        String name = result['name'];
        String vicinity = result['vicinity'];
        String imageUrl = result['photos'] != null && result['photos'].isNotEmpty
            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=$apiKey'
            : ''; // Adjust the photo size as needed
           

        double distance = result['geometry']['location']['lat'] != null &&
                result['geometry']['location']['lng'] != null
            ? calculateGreatCircleDistance(lat, lon, shoplat, shoplon)
            : 0.0;

        haircareShops.add(HaircareShop(name: name, vicinity: vicinity, imageUrl: imageUrl, distance: distance,lat: shoplat,lon:shoplon));
      }

      return haircareShops;
    } else {
      throw Exception('Error: ${data['status']} - ${data['error_message']}');
    }
  } else {
    throw Exception('Failed to load nearby haircare shops');
  }
}

// double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//   const R = 6371.0; // Earth radius in kilometers
//   double dLat = _toRadians(lat2 - lat1);
//   double dLon = _toRadians(lon2 - lon1);

//   double a = Math.pow(Math.sin(dLat / 2), 2) +
//       Math.cos(_toRadians(lat1)) * Math.cos(_toRadians(lat2)) * Math.pow(Math.sin(dLon / 2), 2);
//   double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

//   return R * c;
// }

// double _toRadians(double degree) {
//   return degree * (Math.pi / 180.0);
// }
double calculateGreatCircleDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371.0; // Earth radius in kilometers

  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);
  double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(_toRadians(lat1)) * Math.cos(_toRadians(lat2)) *
          Math.sin(dLon / 2) * Math.sin(dLon / 2);
  double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  double distance = R * c;

  return distance;
}

double _toRadians(double degree) {
  return degree * (Math.pi / 180.0);
}


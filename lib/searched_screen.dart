import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/listofshops.dart';
import 'package:new_project/shops_withcategory.dart';

class NearbyShopsScreen extends StatelessWidget {
  final String searchedAddress;

  const NearbyShopsScreen({Key? key, required this.searchedAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Shops'),
      ),
      body: FutureBuilder<List<double>>(
        future: _fetchCoordinates(searchedAddress), // Define a function to fetch nearby shops
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 9, 9, 2)),
        backgroundColor: Color.fromARGB(255, 225, 224, 224),
    strokeWidth: 4,
      ),
      SizedBox(height: 10),
      Text(
        'Loading...',
        style: TextStyle(
          color: Color.fromARGB(255, 89, 90, 91),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
);



          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<dynamic> coordinates = snapshot.data as List<dynamic>;
            double x=coordinates[0];
            double y=coordinates[1];

            return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
  children: [
    Icon(
      Icons.search,
      color: Colors.blue,
    ),
    SizedBox(width: 8),
    Text(
      searchedAddress,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        shadows: [
          Shadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(2, 2),
            blurRadius: 3,
          ),
        ],
      ),
    ),
  ],
),

                SizedBox(height: 8), // Add some spacing

                FutureBuilder(
                  future: getNearbyHaircareShopswithcategory(x, y,0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 9, 9, 2)),
        backgroundColor: Color.fromARGB(255, 225, 224, 224),
    strokeWidth: 4,
      ),
      SizedBox(height: 10),
      Text(
        'Loading...',
        style: TextStyle(
          color: Color.fromARGB(255, 89, 90, 91),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
);

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

                        shopWidgets.add(
                          HaircareShopWidget(
                            category:"Haircut" ,
                            distance: shop.distance * 1000,
                            name: shop.name,
                            vicinity: shop.vicinity,
                            imageUrl: shop.imageUrl,
                            lat: shop.lat,
                            lon: shop.lon,
                          ),
                        );
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
  }

 Future<List<double>> _fetchCoordinates(String vicinity) async {
  //api key for the project
    String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
    String url = '$baseUrl?address=$vicinity&key=$apiKey';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          double latitude = data['results'][0]['geometry']['location']['lat'];
          double longitude = data['results'][0]['geometry']['location']['lng'];

          print('=========================================================================================');
          print('Latitude: $latitude, Longitude: $longitude');
          print('=========================================================================================');
          
              
          print('Latitude: $latitude, Longitude: $longitude');
          print('=========================================================================================');
          return [latitude,longitude];
        } else {
          throw Exception('Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to fetch coordinates');
      }
    } catch (e) {

      print('Error: $e');
      print('=========');
      return [1,1];
    }
  }
}

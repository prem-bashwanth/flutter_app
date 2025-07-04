import 'package:flutter/material.dart';
// import 'package:new_project/getnearby_shops.dart';
import 'package:new_project/listofshops.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:new_project/shops_withcategory.dart';
import 'package:new_project/current_location.dart';
import 'package:geolocator/geolocator.dart';

class GetCategoryScreen extends StatefulWidget {
  final int categoryIndex;
  final String userlocation;

  const GetCategoryScreen({Key? key, required this.categoryIndex,required this.userlocation}) : super(key: key);

  @override
  State<GetCategoryScreen> createState() => _GetCategoryScreenState();
}

class _GetCategoryScreenState extends State<GetCategoryScreen> {
  String? selectedService;

  void onServiceSelected(String serviceName) {
    setState(() {
      selectedService = serviceName;
    });
  }

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
  List<String> categoriesNames = [
    'Haircut and Styling',
    'Hair Color services',
    'Spa & Massage services',
    'Skin Care services',
    'Eyelash & Eyebrow Services',
    'Manicure and Pedicure services',
    'Makeup services',
    'Facial services',
    'Threading',
  ];
@override
Widget build(BuildContext context) {
  final String service = categoriesNames[widget.categoryIndex];
  return Scaffold(
    appBar: AppBar(
      title: Text(service),
    ),

    body: FutureBuilder(
      future: getCurrentLocation(),
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
          final position = snapshot.data as Position?;

          if (position == null) {
            return Center(
              child: Text('Location not available.'),
            );
          }

          Widget locationWidget = Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.userlocation,
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
                  future: getNearbyHaircareShopswithcategory(position.latitude, position.longitude,widget.categoryIndex),
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
                         print(shop.lat);
                         print(shop.lon);
                        shopWidgets.add(
                          HaircareShopWidget(
                            category:service ,
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
}

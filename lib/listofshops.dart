import 'package:flutter/material.dart';
import 'service_details_screen.dart'; // Import the details screen

class HaircareShopWidget extends StatelessWidget {
  final String category;
  final String name;
  final String vicinity;
  final double distance;
  final String imageUrl;
  final double? lat; // Nullable type
  final double? lon; // Nullable type

  HaircareShopWidget({
    required this.category,
    required this.name,
    required this.vicinity,
    required this.distance,
    required this.imageUrl,
    this.lat, // Nullable parameter
    this.lon, // Nullable parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(
              serviceCategory: category, // Example category
              name: name,
              vicinity: vicinity,
              distance: distance,
              imageUrl: imageUrl,
              lat: lat,
              lon: lon,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1.2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : AssetImage('assets/icons/default.jpg') as ImageProvider<Object>,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              vicinity,
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 41, 41, 39),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 16.0,
                ),
                SizedBox(width: 4.0),
                Text(
                  '${distance.toStringAsFixed(1)} m',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

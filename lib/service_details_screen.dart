import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_project/booking_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  
  final String serviceCategory;
  final String name;
  final String vicinity;
  final double distance;
  final String imageUrl;
  final double? lat;
  final double? lon;

  ServiceDetailsScreen({
    
    required this.serviceCategory,
    required this.name,
    required this.vicinity,
    required this.distance,
    required this.imageUrl,
    required this.lat,
    required this.lon,
  });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Service Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
          
          
//           Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 1.2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 15.0),
//             Container(
//               height: 150.0,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.0),
//                 image: DecorationImage(
//                   image: imageUrl.isNotEmpty
//                       ? NetworkImage(imageUrl)
//                       : AssetImage('assets/KANE.jpeg') as ImageProvider<Object>,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               vicinity,
//               style: TextStyle(
//                 fontSize: 14.0,
//                 color: Color.fromARGB(255, 41, 41, 39),
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 0.5,
//                 fontStyle: FontStyle.italic,
//                 shadows: [
//                   Shadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 2,
//                     offset: Offset(1, 1),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8.0),
            
//             Text(
//   'Available Services:',
//   style: TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold, // Making the text bold
//     color: Colors.blue, // Changing text color
//   ),
// ),
// Text(
//   '$serviceCategory',
//   style: TextStyle(
//     fontSize: 16.0,
//     color: Colors.black87,
//     letterSpacing: 0.5, // Adjusting letter spacing for clarity
//     shadows: [
//       Shadow(
//         color: Colors.grey.withOpacity(0.5), // Adding shadow for depth
//         blurRadius: 2,
//         offset: Offset(1, 1),
//       ),
//     ],
//   ),
// ),

//             SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 16.0,
//                 ),
//                 SizedBox(width: 4.0),
//                 Text(
//                   '${distance.toStringAsFixed(1)} m',
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//           // Include other details here like name, vicinity, distance, and image
//           // You can use similar UI elements as HaircareShopWidget
//         ],
//       ),
//     );
//   }
// }

// class ServiceDetailsScreen extends StatelessWidget {
//   final String serviceCategory;
//   final String name;
//   final String vicinity;
//   final double distance;
//   final String imageUrl;

//   ServiceDetailsScreen({
//     required this.serviceCategory,
//     required this.name,
//     required this.vicinity,
//     required this.distance,
//     required this.imageUrl,
//   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                // Your existing UI elements
                // ...
                Container(
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
            
            Text(
  'Available Services:',
  style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold, // Making the text bold
    color: Colors.blue, // Changing text color
  ),
),
Text(
  '$serviceCategory',
  style: TextStyle(
    fontSize: 16.0,
    color: Colors.black87,
    letterSpacing: 0.5, // Adjusting letter spacing for clarity
    shadows: [
      Shadow(
        color: Colors.grey.withOpacity(0.5), // Adding shadow for depth
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
            ElevatedButton(
                  
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingScreen(shopName:name,serviceCategory:serviceCategory,shoplat:lat,shoplon:lon)), // Replace BookingScreen() with the appropriate widget
    );
  },
  child: Text('Book Service'),
),

                    // Show popup box when the button is tapped
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: Text('Service Booked Successfully'),
                          
                    //       content: Text('You have successfully booked the $serviceCategory service at $name.'),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             // Close the dialog box
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Text('OK'),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                 
          ],
        ),

      ),

                
              ],
            ),
          ),
        ],
      ),
    );
  }
}


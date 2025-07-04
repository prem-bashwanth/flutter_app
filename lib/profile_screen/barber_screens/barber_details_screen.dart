// import 'package:flutter/material.dart';

// class BarberDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> barberData;

//   const BarberDetailsScreen({Key? key, required this.barberData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> services = barberData['services'] ?? [];
//     List<dynamic> prices = barberData['prices'] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(barberData['name'] ?? 'Barber Details'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Description: ${barberData['description'] ?? 'N/A'}'),
//             Text('Offers: ${barberData['offers'] ?? 'None'}'),
//             Text('Offer Duration: ${barberData['offerDuration'] ?? 'N/A'}'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: services.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(services[index] ?? ''),
//                   subtitle: Text('Price: \$${prices.length > index ? prices[index].toString() : 'N/A'}'),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle booking logic
//               },
//               child: Text('Book Now'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_project/profile_screen/barber_screens/barber_booking.dart';

class BarberDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> barberData;
  final String barberId;

  BarberDetailsScreen({required this.barberData, required this.barberId});

  @override
  State<BarberDetailsScreen> createState() => _BarberDetailsScreenState();
}

class _BarberDetailsScreenState extends State<BarberDetailsScreen> {
    late String selectedBarber;
  late String selectedService;
  late double selectedcost;
  late Future<String> _imageFuture;
  bool showDetails = true;

  @override
  void initState() {
    super.initState();
    _imageFuture = _getFirstImage(widget.barberId);
  }

  Future<String> _getFirstImage(String barberId) async {
    Reference ref = FirebaseStorage.instance.ref().child('barberImages/$barberId');
    ListResult result = await ref.listAll();
    if (result.items.isNotEmpty) {
      return result.items.last.getDownloadURL(); // Suggesting to use the first image for consistency
    }
    return ''; // Return empty string if no images found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barber Shop Details',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String>(
              future: _imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                String imageUrl = snapshot.data ?? '';
                return AspectRatio(
                  aspectRatio: 14 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Center(child: Text('No Image Available')),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.barberData['name'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      widget.barberData['shopAddress'] ?? 'No Address Provided',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showDetails = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), backgroundColor: !showDetails ? Colors.black : Colors.white,
                    elevation: 3,
                  ),
                  child: Text(
                    'Services',
                    style: TextStyle(color: !showDetails ? Colors.white : Colors.black),
                  ),
                ),


                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showDetails = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), backgroundColor: showDetails ? Colors.black : Colors.white,
                    elevation: 3,
                  ),
                  child: Text(
                    'Details',
                    style: TextStyle(color: showDetails ? Colors.white : Colors.black),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       showDetails = false;
                //     });
                //   },
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     primary: !showDetails ? Colors.black : Colors.white,
                //     elevation: 3,
                //   ),
                //   child: Text(
                //     'Services',
                //     style: TextStyle(color: !showDetails ? Colors.white : Colors.black),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10),
            showDetails
                ? Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description: ${widget.barberData['description']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Offers: ${widget.barberData['offers']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Offer Duration: ${widget.barberData['offerDuration']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.barberData['services'].length; i++)
                            ListTile(
                              title: Text(
                                widget.barberData['services'][i],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                selectedBarber = widget.barberData['name'] ?? '';
                                selectedService = widget.barberData['services'][i] ?? '';
                                selectedcost = (widget.barberData['prices'][widget.barberData['services'].indexOf(widget.barberData['services'][i])] ?? 0).toDouble();

                              });
                              // You can add your logic here for handling the tap event
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                    selectedService: selectedService,
                                    selectedBarber: selectedBarber,
                                    selectedcost: selectedcost,
                                  ),
                                ),
                              );
                                },
                                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), backgroundColor: Colors.black ,
                    elevation: 3,
                  ),
                  child: Text(
                    'Book now',
                    style: TextStyle(color:  Colors.white ),
                  ),
                ),
                            ),
                          SizedBox(height: 20),
//                           Container(
//   width: double.infinity, // Make the button take the full width
//   margin: EdgeInsets.symmetric(horizontal: 20),
//   child: ElevatedButton(
//     onPressed: () {
//       // Book now button tapped
//     },
//     style: ElevatedButton.styleFrom(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
//       ),
//       primary: Colors.black,
//       elevation: 3,
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15), // Adjust the padding as needed
//       child: Text(
//         'Book Now',
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   ),
// ),

                        ],
                      ),
                    ),
                 

                  ),
          ],
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesScreen extends StatelessWidget {
  final String barberId;

  const ServicesScreen({Key? key, required this.barberId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Services'),
        backgroundColor: Colors.deepPurple, // Enhance the color scheme
        elevation: 0, // Remove shadow for a flat design
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('barbers').doc(barberId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple), // Custom loader color
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching data"));
          } else if (snapshot.data == null || snapshot.data!.data() == null) {
            return Center(child: Text("No services found"));
          } else {
            var barberDetails = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> services = barberDetails['services'] ?? [];
            List<dynamic> prices = barberDetails['prices'] ?? [];
            return ListView.separated(
              itemCount: services.length,
              separatorBuilder: (context, index) => Divider(), // Adds a divider between items
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.cut, color: Colors.deepPurple), // Service icon
                  title: Text(services[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("Price: ₹${prices[index].toStringAsFixed(2)}", style: TextStyle(color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple), // Navigation arrow
                  onTap: () {}, // Add functionality if needed for detail page or actions
                );
              },
            );
          }
        },
      ),
    );
  }
}

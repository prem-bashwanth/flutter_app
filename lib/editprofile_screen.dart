import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/custombutton.dart';
import 'package:new_project/profile_screen/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blueGrey, // Enhanced color for the AppBar
      ),
      body: SingleChildScrollView( // Added to handle overflow when keyboard is visible
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(), // Improved border styling
                  prefixIcon: Icon(Icons.person), // Added icon for better visual cue
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home), // Added icon for better visual cue
                ),
              ),
              SizedBox(height: 30),
              CustomMainButton(
                child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor, // Using the primary theme color
                isLoading: false,
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                    'name': _nameController.text,
                    'address': _addressController.text,
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

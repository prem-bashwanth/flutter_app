// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';

// // class BarberHomeScreen extends StatefulWidget {
// //   @override
// //   _BarberHomeScreenState createState() => _BarberHomeScreenState();
// // }

// // class _BarberHomeScreenState extends State<BarberHomeScreen> {
// //   final TextEditingController _shopNameController = TextEditingController();
// //   final TextEditingController _shopAddressController = TextEditingController();
// //   final TextEditingController _serviceController = TextEditingController();
// //   final TextEditingController _priceController = TextEditingController();
// //   final TextEditingController _offerController = TextEditingController();
// //   final TextEditingController _offerDurationController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   List<XFile>? _imageFiles;
// //   XFile? _videoFile;
// //   final ImagePicker _picker = ImagePicker();
// //   final String _userId = FirebaseAuth.instance.currentUser!.uid; // Assuming the user is logged in

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadData();
// //   }

// //   Future<void> loadData() async {
// //     final docSnapshot = await FirebaseFirestore.instance.collection('barbers').doc(_userId).get();
// //     if (docSnapshot.exists) {
// //       Map<String, dynamic> data = docSnapshot.data()!;
// //       _shopNameController.text = data['shopName'] ?? '';
// //       _shopAddressController.text = data['shopAddress'] ?? '';
// //       _serviceController.text = data['services'] ?? '';
// //       _priceController.text = data['prices'] ?? '';
// //       _offerController.text = data['offers'] ?? '';
// //       _offerDurationController.text = data['offerDuration'] ?? '';
// //       _descriptionController.text = data['description'] ?? '';
// //       // For images and videos, you might want to store and retrieve URLs and load them separately
// //     }
// //   }

// //   Future<void> updateBarberDetails() async {
// //     Map<String, dynamic> barberDetails = {
// //       'shopName': _shopNameController.text,
// //       'shopAddress': _shopAddressController.text,
// //       'services': _serviceController.text,
// //       'prices': _priceController.text,
// //       'offers': _offerController.text,
// //       'offerDuration': _offerDurationController.text,
// //       'description': _descriptionController.text,
// //     };

// //     await FirebaseFirestore.instance.collection('barbers').doc(_userId).set(barberDetails, SetOptions(merge: true));
// //     uploadImagesAndVideo();
// //   }

// //   Future<void> uploadImagesAndVideo() async {
// //     if (_imageFiles != null) {
// //       for (var file in _imageFiles!) {
// //         var ref = FirebaseStorage.instance.ref().child('barberImages/$_userId/${file.name}');
// //         await ref.putFile(File(file.path));
// //       }
// //     }

// //     if (_videoFile != null) {
// //       var videoRef = FirebaseStorage.instance.ref().child('barberVideos/$_userId/${_videoFile!.name}');
// //       await videoRef.putFile(File(_videoFile!.path));
// //     }
// //   }

// //   Future<void> pickImages() async {
// //     final List<XFile>? selectedImages = await _picker.pickMultiImage();
// //     if (selectedImages != null && selectedImages.length <= 3) {
// //       setState(() {
// //         _imageFiles = selectedImages;
// //       });
// //     }
// //   }

// //   Future<void> pickVideo() async {
// //     final XFile? selectedVideo = await _picker.pickVideo(source: ImageSource.gallery);
// //     setState(() {
// //       _videoFile = selectedVideo;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Barber Dashboard"),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(20.0),
// //           child: Column(
// //             children: <Widget>[
// //               TextField(
// //                 controller: _shopNameController,
// //                 decoration: InputDecoration(labelText: 'Shop Name'),
// //               ),
// //               TextField(
// //                 controller: _shopAddressController,
// //                 decoration: InputDecoration(labelText: 'Shop Address'),
// //               ),
// //               TextField(
// //                 controller: _serviceController,
// //                 decoration: InputDecoration(labelText: 'Service and Price (e.g., Hair Cut - \$20)'),
// //               ),
// //               TextField(
// //                 controller: _offerController,
// //                 decoration: InputDecoration(labelText: 'Offers (e.g., 10% off)'),
// //               ),
// //               TextField(
// //                 controller: _offerDurationController,
// //                 decoration: InputDecoration(labelText: 'Offer Duration (e.g., 30 days)'),
// //               ),
// //               TextField(
// //                 controller: _descriptionController,
// //                 decoration: InputDecoration(labelText: 'Shop Description'),
// //               ),
// //               SizedBox(height: 10),
// //               ElevatedButton(onPressed: pickImages, child: Text('Upload Images')),
// //               SizedBox(height: 10),
// //               ElevatedButton(onPressed: pickVideo, child: Text('Upload Video')),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: updateBarberDetails,
// //                 child: Text('Save Details'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class BarberHomeScreen extends StatefulWidget {
//   @override
//   _BarberHomeScreenState createState() => _BarberHomeScreenState();
// }

// class _BarberHomeScreenState extends State<BarberHomeScreen> {
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _shopAddressController = TextEditingController();
//   final TextEditingController _serviceController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _offerController = TextEditingController();
//   final TextEditingController _offerDurationController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   List<XFile>? _imageFiles;
//   XFile? _videoFile;
//   final ImagePicker _picker = ImagePicker();
//   final String _userId = FirebaseAuth.instance.currentUser!.uid; // Assuming the user is logged in

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final docSnapshot = await FirebaseFirestore.instance.collection('barbers').doc(_userId).get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic> data = docSnapshot.data()!;
//       _shopNameController.text = data['shopName'] ?? '';
//       _shopAddressController.text = data['shopAddress'] ?? '';
//       _serviceController.text = data['services'] ?? '';
//       _priceController.text = data['prices'] ?? '';
//       _offerController.text = data['offers'] ?? '';
//       _offerDurationController.text = data['offerDuration'] ?? '';
//       _descriptionController.text = data['description'] ?? '';
//     }
//   }

//   Future<void> updateBarberDetails() async {
//     Map<String, dynamic> barberDetails = {
//       'shopName': _shopNameController.text,
//       'shopAddress': _shopAddressController.text,
//       'services': _serviceController.text,
//       'prices': _priceController.text,
//       'offers': _offerController.text,
//       'offerDuration': _offerDurationController.text,
//       'description': _descriptionController.text,
//     };

//     await FirebaseFirestore.instance.collection('barbers').doc(_userId).set(barberDetails, SetOptions(merge: true));
//     uploadImagesAndVideo();
//   }

//   Future<void> uploadImagesAndVideo() async {
//     if (_imageFiles != null) {
//       for (var file in _imageFiles!) {
//         var ref = FirebaseStorage.instance.ref().child('barberImages/$_userId/${file.name}');
//         await ref.putFile(File(file.path));
//       }
//     }

//     if (_videoFile != null) {
//       var videoRef = FirebaseStorage.instance.ref().child('barberVideos/$_userId/${_videoFile!.name}');
//       await videoRef.putFile(File(_videoFile!.path));
//     }
//   }

//   Future<void> pickImages() async {
//     final List<XFile>? selectedImages = await _picker.pickMultiImage();
//     if (selectedImages != null && selectedImages.isNotEmpty && selectedImages.length <= 3) {
//       setState(() {
//         _imageFiles = selectedImages;
//       });
//     }
//   }

//   Future<void> pickVideo() async {
//     final XFile? selectedVideo = await _picker.pickVideo(source: ImageSource.gallery);
//     if (selectedVideo != null) {
//       setState(() {
//         _videoFile = selectedVideo;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Barber Dashboard"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               TextField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Name',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.store),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _shopAddressController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Address',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.location_on),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _serviceController,
//                 decoration: InputDecoration(
//                   labelText: 'Service and Price',
//                   hintText: 'e.g., Hair Cut - \$20',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.content_cut),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _offerController,
//                 decoration: InputDecoration(
//                   labelText: 'Offers',
//                   hintText: 'e.g., 10% off',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.local_offer),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _offerDurationController,
//                 decoration: InputDecoration(
//                   labelText: 'Offer Duration',
//                   hintText: 'e.g., 30 days',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.timer),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Description',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.description),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Wrap(
//                 spacing: 10,
//                 children: [
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.photo_library),
//                     label: Text('Upload Images'),
//                     onPressed: pickImages,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.videocam),
//                     label: Text('Upload Video'),
//                     onPressed: pickVideo,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.save),
//                     label: Text('Save Details'),
//                     onPressed: updateBarberDetails,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class BarberHomeScreen extends StatefulWidget {
//   @override
//   _BarberHomeScreenState createState() => _BarberHomeScreenState();
// }

// class _BarberHomeScreenState extends State<BarberHomeScreen> {
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _shopAddressController = TextEditingController();
//   final List<TextEditingController> _serviceControllers = [];
//   final List<TextEditingController> _priceControllers = [];
//   final TextEditingController _offerController = TextEditingController();
//   final TextEditingController _offerDurationController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   List<XFile>? _imageFiles;
//   XFile? _videoFile;
//   final ImagePicker _picker = ImagePicker();
//   final String _userId = FirebaseAuth.instance.currentUser!.uid; // Assuming the user is logged in

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final docSnapshot = await FirebaseFirestore.instance.collection('barbers').doc(_userId).get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic> data = docSnapshot.data()!;
//       _shopNameController.text = data['shopName'] ?? '';
//       _shopAddressController.text = data['shopAddress'] ?? '';
//       _offerController.text = data['offers'] ?? '';
//       _offerDurationController.text = data['offerDuration'] ?? '';
//       _descriptionController.text = data['description'] ?? '';

//       // Populate service and price controllers
//       List<dynamic> services = data['services'] ?? [];
//       List<dynamic> prices = data['prices'] ?? [];
//       for (int i = 0; i < services.length; i++) {
//         TextEditingController serviceController = TextEditingController(text: services[i]);
//         TextEditingController priceController = TextEditingController(text: prices[i].toString());
//         _serviceControllers.add(serviceController);
//         _priceControllers.add(priceController);
//       }
//     }
//   }

//   void addService() {
//     setState(() {
//       _serviceControllers.add(TextEditingController());
//       _priceControllers.add(TextEditingController());
//     });
//   }

//   void removeService(int index) {
//     setState(() {
//       _serviceControllers.removeAt(index);
//       _priceControllers.removeAt(index);
//     });
//   }

//   Future<void> updateBarberDetails() async {
//     Map<String, dynamic> barberDetails = {
//       'shopName': _shopNameController.text,
//       'shopAddress': _shopAddressController.text,
//       'services': _serviceControllers.map((controller) => controller.text).toList(),
//       'prices': _priceControllers.map((controller) => double.parse(controller.text)).toList(),
//       'offers': _offerController.text,
//       'offerDuration': _offerDurationController.text,
//       'description': _descriptionController.text,
//     };

//     await FirebaseFirestore.instance.collection('barbers').doc(_userId).set(barberDetails, SetOptions(merge: true));
//     uploadImagesAndVideo();

//     print('Filled data added to Firebase successfully.');
//   }

//   Future<void> uploadImagesAndVideo() async {
//     // Upload images
      // if (_imageFiles != null) {
      //   for (var file in _imageFiles!) {
      //     var ref = FirebaseStorage.instance.ref().child('barberImages/$_userId/${file.name}');
      //     await ref.putFile(File(file.path));
      //   }
      // }

//     // Upload video
//     if (_videoFile != null) {
//       var videoRef = FirebaseStorage.instance.ref().child('barberVideos/$_userId/${_videoFile!.name}');
//       await videoRef.putFile(File(_videoFile!.path));
//     }
//   }

//   Future<void> pickImages() async {
//     final List<XFile>? selectedImages = await _picker.pickMultiImage();
//     if (selectedImages != null && selectedImages.isNotEmpty && selectedImages.length <= 3) {
//       setState(() {
//         _imageFiles = selectedImages;
//       });
//     }
//   }

//   Future<void> pickVideo() async {
//     final XFile? selectedVideo = await _picker.pickVideo(source: ImageSource.gallery);
//     if (selectedVideo != null) {
//       setState(() {
//         _videoFile = selectedVideo;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

    
//    return Scaffold(
//       appBar: AppBar(
//         title: Text("My Dashboard"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               TextField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Name',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.store),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _shopAddressController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Address',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.location_on),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 children: [
//                   for (int i = 0; i < _serviceControllers.length; i++)
//   Padding(
//     padding: EdgeInsets.symmetric(vertical: 8.0), // Add padding here
//     child: Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _serviceControllers[i],
//             decoration: InputDecoration(
//               labelText: 'Service ${i + 1}',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: TextField(
//             controller: _priceControllers[i],
//             decoration: InputDecoration(
//               labelText: 'Price',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.numberWithOptions(decimal: true),
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.remove),
//           onPressed: () => removeService(i),
//         ),
//       ],
//     ),
//   ),

//                   ElevatedButton(
//                     onPressed: addService,
//                     child: Text('Add Service'),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _offerController,
//                 decoration: InputDecoration(
//                   labelText: 'Offers',
//                   hintText: 'e.g., 10% off',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.local_offer),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _offerDurationController,
//                 decoration: InputDecoration(
//                   labelText: 'Offer Duration',
//                   hintText: 'e.g., 30 days',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.timer),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(
//                   labelText: 'Shop Description',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.description),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Wrap(
//                 spacing: 10,
//                 children: [
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.photo_library),
//                     label: Text('Upload Images'),
//                     onPressed: pickImages,
//                   ),
                  
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.videocam),
//                     label: Text('Upload Video'),
//                     onPressed: pickVideo,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.save),
//                     label: Text('Save Details'),
//                     onPressed: updateBarberDetails,
//                   ),
//                 ],
//               ),
               
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class BarberHomeScreen extends StatefulWidget {
  @override
  _BarberHomeScreenState createState() => _BarberHomeScreenState();
}

class _BarberHomeScreenState extends State<BarberHomeScreen> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();
  final List<TextEditingController> _serviceControllers = [];
  final List<TextEditingController> _priceControllers = [];
  final TextEditingController _offerController = TextEditingController();
  final TextEditingController _offerDurationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController(); // New controller for UPI ID
  List<XFile>? _imageFiles;
  XFile? _videoFile;
  final ImagePicker _picker = ImagePicker();
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final docSnapshot = await FirebaseFirestore.instance.collection('barbers').doc(_userId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      _shopNameController.text = data['shopName'] ?? '';
      _shopAddressController.text = data['shopAddress'] ?? '';
      _offerController.text = data['offers'] ?? '';
      _offerDurationController.text = data['offerDuration'] ?? '';
      _descriptionController.text = data['description'] ?? '';
      _upiIdController.text = data['upiId'] ?? ''; // Load UPI ID if available

      List<dynamic> services = data['services'] ?? [];
      List<dynamic> prices = data['prices'] ?? [];
      for (int i = 0; i < services.length; i++) {
        TextEditingController serviceController = TextEditingController(text: services[i]);
        TextEditingController priceController = TextEditingController(text: prices[i].toString());
        _serviceControllers.add(serviceController);
        _priceControllers.add(priceController);
      }
    }
  }

  void addService() {
    setState(() {
      _serviceControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController());
    });
  }

  void removeService(int index) {
    setState(() {
      _serviceControllers.removeAt(index);
      _priceControllers.removeAt(index);
    });
  }

  Future<void> updateBarberDetails() async {
  Map<String, dynamic> barberDetails = {
    'shopName': _shopNameController.text,
    'shopAddress': _shopAddressController.text,
    'services': _serviceControllers.map((controller) => controller.text).toList(),
    'prices': _priceControllers.map((controller) => double.parse(controller.text)).toList(),
    'offers': _offerController.text,
    'offerDuration': _offerDurationController.text,
    'description': _descriptionController.text,
    'upiId': _upiIdController.text,
  };

  print('Updating barber details: $barberDetails');

  try {
    await FirebaseFirestore.instance.collection('barbers').doc(_userId).set(barberDetails, SetOptions(merge: true));
    await uploadImagesAndVideo();

    print('Filled data added to Firebase successfully.');
  } catch (e, stackTrace) {
    print('Error updating barber details: $e\n$stackTrace');
  }
}


  Future<void> uploadImagesAndVideo() async {
  try {
    // Upload images
    if (_imageFiles != null) {
      for (var file in _imageFiles!) {
        var ref = FirebaseStorage.instance.ref().child('barberImages/$_userId/${file.name}');
        await ref.putFile(File(file.path));
        print('Uploads HHHHHHHHHHHHHHHHHHcompleted successfully.');
      }
    }

    // Upload video
    if (_videoFile != null) {
      var videoRef = FirebaseStorage.instance.ref().child('barberVideos/$_userId/${_videoFile!.name}');
      await videoRef.putFile(File(_videoFile!.path));
      print('Uploads RRRRRRRRRRRRRRRRRcompleted successfully.');
    }
    
    // Upload UPI QR code image
    if (_upiQrCodeFile != null) {
      var upiQrCodeRef = FirebaseStorage.instance.ref().child('upiQrCodes/$_userId/upi_image.jpg');
      await upiQrCodeRef.putFile(File(_upiQrCodeFile!.path));
      print('Uploads ###############completed successfully.');
    }
    
    print('Uploads completed successfully.');
  } catch (e, stackTrace) {
    print('Error updating fikessssssssssssssss: $e\n$stackTrace');
  }
}

  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty && selectedImages.length <= 3) {
      setState(() {
        _imageFiles = selectedImages;
      });
    }
  }

  Future<void> pickVideo() async {
    final XFile? selectedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo != null) {
      setState(() {
        _videoFile = selectedVideo;
      });
    }
  }

  XFile? _upiQrCodeFile;

  Future<void> pickUpiQrCode() async {
    final XFile? selectedUpiQrCode = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedUpiQrCode != null) {
      setState(() {
        _upiQrCodeFile = selectedUpiQrCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _shopNameController,
                decoration: InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.store),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _shopAddressController,
                decoration: InputDecoration(
                  labelText: 'Shop Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  for (int i = 0; i < _serviceControllers.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _serviceControllers[i],
                              decoration: InputDecoration(
                                labelText: 'Service ${i + 1}',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _priceControllers[i],
                              decoration: InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => removeService(i),
                          ),
                        ],
                      ),
                    ),
                  ElevatedButton(
                    onPressed: addService,
                    child: Text('Add Service'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _offerController,
                decoration: InputDecoration(
                  labelText: 'Offers',
                  hintText: 'e.g., 10% off',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_offer),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _offerDurationController,
                decoration: InputDecoration(
                  labelText: 'Offer Duration',
                  hintText: 'e.g., 30 days',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Shop Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _upiIdController,
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                  hintText: 'Enter UPI ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payment),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.qr_code),
                label: Text('Upload UPI QR Code'),
                onPressed: pickUpiQrCode,
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library),
                    label: Text('Upload Images'),
                    onPressed: pickImages,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.videocam),
                    label: Text('Upload Video'),
                    onPressed: pickVideo,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text('Save Details'),
                    onPressed: updateBarberDetails,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

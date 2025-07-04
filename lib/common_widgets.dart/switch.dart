// import 'package:flutter/material.dart';
// import 'package:new_project/category_screen.dart';

// class SwitchWidget extends StatefulWidget {
//   final String userlocation;

//   SwitchWidget({required this.userlocation}); // Define location as a named parameter

//   @override
//   _SwitchWidgetState createState() => _SwitchWidgetState();
// }

// class _SwitchWidgetState extends State<SwitchWidget> {
//   String? selectedService;
//   bool isMaleSelected = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Gender'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Male',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               SizedBox(width: 8),
//               Switch(
//                 value: isMaleSelected,
//                 onChanged: (value) {
//                   setState(() {
//                     isMaleSelected = value;
//                   });
//                 },
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'Female',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text(
//             isMaleSelected ? 'Male Hair Care Categories' : 'Female Hair Care Categories',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: categoriesNames.length,
//               itemBuilder: (context, index) {
//                 String categoryName = categoriesNames[index];
//                 String imagePath = isMaleSelected ? maleCategories[index] : femaleCategories[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => GetCategoryScreen(categoryIndex: index, userlocation: widget.userlocation)),
//                     );
//                   },
//                   child: Card(
//                     child: ListTile(
//                       leading: Image.asset(
//                         imagePath,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//                       title: Text(categoryName),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<String> categoriesNames = [
//     'Haircut and Styling',
//     'Hair Color',
//     'Spa & Massage',
//     'Skin Care',
//     'Eyebrow Eyelash Services',
//     'Manicure and Pedicure',
//     'Makeup',
//     'Facial',
//     'Threading',
//   ];

//   List<String> maleCategories = [
//     'assets/icons/men0.jpeg',
//     'assets/icons/men1.jpeg',
//     'assets/icons/men2.jpeg',
//     'assets/icons/men3.jpeg',
//     'assets/icons/men4.jpeg',
//     'assets/icons/men5.jpg',
//     'assets/icons/men6.jpg',
//     'assets/icons/men7.jpeg',
//     'assets/icons/men8.jpeg',
//   ];

//   List<String> femaleCategories = [
//     'assets/icons/female0.jpeg',
//     'assets/icons/female1.jpg',
//     'assets/icons/female2.jpg',
//     'assets/icons/female3.jpg',
//     'assets/icons/female4.jpeg',
//     'assets/icons/female5.jpeg',
//     'assets/icons/female6.jpeg',
//     'assets/icons/women7.jpg',
//     'assets/icons/female7.jpg',
//   ];
// }




import 'package:flutter/material.dart';
import 'package:new_project/category_screen.dart';
class SwitchWidget extends StatefulWidget {
  final String userlocation;

  SwitchWidget({required this.userlocation}); // Define location as a named parameter

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}


class _SwitchWidgetState extends State<SwitchWidget> {
  String? selectedService;
  bool isMaleSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: AppBar(
    //     title: const Padding(
    // padding:  EdgeInsets.only(top: 10.0), // Adjust the top padding as needed
    
    // ),
    //     toolbarHeight: 3.5,
        
    //   ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Center(
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text(
                'Male',
               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
               ),
               const SizedBox(width: 8), // Adjust spacing as needed
               Switch(
                 value: !isMaleSelected, // Invert the value for the female side
                 onChanged: (value) {
                   setState(() {
                        isMaleSelected = !value; // Invert the value when switching
                   });
                 },
               ),
               const SizedBox(width: 8), // Adjust spacing as needed
               const Text(
                'Female',
               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
             ],
           ),
         ),
          SizedBox(height: 5.0),
          Text(
            isMaleSelected ? 'Male Hair Care Categories' : 'Female Hair Care Categories',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Expanded(
         child: GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 12.0,
    mainAxisSpacing: 12.0,
  ),
  itemCount: 18,
  itemBuilder: (context, index) {
    bool isImageRow = index % 6 <3;
    double itemSize = isImageRow ? 100.0 : 50.0;
    int categoryIndex = 0;
if (index < 6) {
  categoryIndex = (index % 6) ;
} else if (index < 12) {
  categoryIndex = (index % 6) +3;
} else if (index < 18) {
  categoryIndex = (index % 6) + 6;
}
    
    if (isImageRow) {
      // Image Row
      String imagepath= (isMaleSelected ? maleCategories[categoryIndex] : femaleCategories[categoryIndex]) ;
      return GestureDetector(
        onTap: () {
           

  void onServiceSelected(String serviceName) {
    setState(() {
      selectedService = serviceName;
    });
  }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GetCategoryScreen(categoryIndex: categoryIndex,userlocation: widget.userlocation,)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            width: double.infinity-5,
            height: itemSize,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              color: Color.fromARGB(255, 246, 245, 245),
              image: DecorationImage(
                image: AssetImage(imagepath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      // Name Row
      int nameIndex = 0;
if (index < 6) {
  nameIndex = (index % 6) - 3;
} else if (index < 12) {
  nameIndex = (index % 6) ;
} else if (index < 18) {
  nameIndex = (index % 6) + 3;
}

      
      String categoryName = categoriesNames[nameIndex];

       return Container(
         
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust padding as needed
             child: Text(
               categoryName,
               style: TextStyle(
          color: const Color.fromARGB(255, 7, 0, 0),
          fontWeight: FontWeight.bold,
               ),
             ),
           ),
         
       );

    }
  },
),
),
        ],
      ),
    );
  }
  List<String> categoriesNames = [
    'Haircut and Styling',
    'Hair Color',
    'Spa & Massage',
    'Skin Care ',
    'Eyebrow Eyelash Services',
    'Manicure and Pedicure',
    'Makeup',
    'Facial',
    'Threading',
  ];

  List<String> maleCategories = [
    'assets/icons/men0.jpeg',
    'assets/icons/men1.jpeg',
    'assets/icons/men2.jpeg',
    'assets/icons/men3.jpeg',
    'assets/icons/men4.jpeg',
    'assets/icons/men5.jpg',
    'assets/icons/men6.jpg',
    'assets/icons/men7.jpeg',
    'assets/icons/men8.jpeg',
    
  ];

  List<String> femaleCategories = [
    'assets/icons/female0.jpeg',
    'assets/icons/female1.jpg',
    'assets/icons/female2.jpg',
    'assets/icons/female3.jpg',
    'assets/icons/female4.jpeg',
    'assets/icons/female5.jpeg',
    'assets/icons/female6.jpeg',
    'assets/icons/women7.jpg',
    'assets/icons/female7.jpg',
  ];
}


// import 'package:flutter/material.dart';
// import 'package:new_project/category_screen.dart';

// class SwitchWidget extends StatefulWidget {
//   final String userlocation;

//   const SwitchWidget({Key? key, required this.userlocation}) : super(key: key);

//   @override
//   _SwitchWidgetState createState() => _SwitchWidgetState();
// }

// class _SwitchWidgetState extends State<SwitchWidget> {
//   String? selectedService;
//   bool isMaleSelected = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Male',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               SizedBox(width: 8),
//               Switch(
//                 value: isMaleSelected,
//                 onChanged: (value) {
//                   setState(() {
//                     isMaleSelected = value;
//                   });
//                 },
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'Female',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 5.0),
//         Text(
//           isMaleSelected ? 'Male Hair Care Categories' : 'Female Hair Care Categories',
//           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5.0),
//         Expanded(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 12.0,
//               mainAxisSpacing: 12.0,
//             ),
//             itemCount: 18,
//             itemBuilder: (context, index) {
//               bool isImageRow = index % 6 < 3;
//               int categoryIndex = isImageRow ? index % 6 : (index % 6) - 3;

//               String imagePath = isMaleSelected ? maleCategories[categoryIndex] : femaleCategories[categoryIndex];

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => GetCategoryScreen(categoryIndex: categoryIndex, userlocation: widget.userlocation)),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.0),
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: isImageRow
//                       ? Image.asset(
//                           imagePath,
//                           fit: BoxFit.cover,
//                         )
//                       : Center(
//                           child: Text(
//                             categoriesNames[categoryIndex],
//                             style: TextStyle(color: const Color.fromARGB(255, 7, 0, 0), fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   List<String> categoriesNames = [
//     'Haircut and Styling',
//     'Hair Color',
//     'Spa & Massage',
//     'Skin Care ',
//     'Eyebrow Eyelash Services',
//     'Manicure and Pedicure',
//     'Makeup',
//     'Facial',
//     'Threading',
//   ];

//   List<String> maleCategories = [
//     'assets/icons/men0.jpeg',
//     'assets/icons/men1.jpeg',
//     'assets/icons/men2.jpeg',
//     'assets/icons/men3.jpeg',
//     'assets/icons/men4.jpeg',
//     'assets/icons/men5.jpg',
//     'assets/icons/men6.jpg',
//     'assets/icons/men7.jpeg',
//     'assets/icons/men8.jpeg',
//   ];

//   List<String> femaleCategories = [
//     'assets/icons/female0.jpeg',
//     'assets/icons/female1.jpg',
//     'assets/icons/female2.jpg',
//     'assets/icons/female3.jpg',
//     'assets/icons/female4.jpeg',
//     'assets/icons/female5.jpeg',
//     'assets/icons/female6.jpeg',
//     'assets/icons/women7.jpg',
//     'assets/icons/female7.jpg',
//   ];
// }

// import 'package:flutter/material.dart';
// import 'package:new_project/category_screen.dart';

// // class SwitchWidget extends StatelessWidget {
// //   final String userlocation;

// //   SwitchWidget({required this.userlocation});

// //   @override
//   Widget SwitchWidget(String userlocation) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Male',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               const SizedBox(width: 8),
//               Switch(
//                 value: true, // Default value for isMaleSelected
//                 onChanged: (value) {},
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Female',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 5.0),
//         Text(
//           'Male Hair Care Categories',
//           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5.0),
//         Expanded(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 12.0,
//               mainAxisSpacing: 12.0,
//             ),
//             itemCount: 18,
//             itemBuilder: (context, index) {
//               bool isImageRow = index % 6 < 3;
//               double itemSize = isImageRow ? 100.0 : 50.0;
//               int categoryIndex = index < 6
//                   ? index % 6
//                   : index < 12
//                       ? (index % 6) + 3
//                       : (index % 6) + 6;

//               if (isImageRow) {
//                 String imagePath = maleCategories[categoryIndex];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => GetCategoryScreen(categoryIndex: categoryIndex, userlocation: userlocation)),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                       color: Color.fromARGB(255, 255, 255, 255),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Container(
//                       width: double.infinity - 5,
//                       height: itemSize,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(12.0),
//                         color: Color.fromARGB(255, 246, 245, 245),
//                         image: DecorationImage(
//                           image: AssetImage(imagePath),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 int nameIndex = index < 6
//                     ? (index % 6) - 3
//                     : index < 12
//                         ? (index % 6)
//                         : (index % 6) + 3;

//                 String categoryName = categoriesNames[nameIndex];

//                 return Container(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       categoryName,
//                       style: TextStyle(
//                         color: const Color.fromARGB(255, 7, 0, 0),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   List<String> categoriesNames = [
//     'Haircut and Styling',
//     'Hair Color',
//     'Spa & Massage',
//     'Skin Care ',
//     'Eyebrow Eyelash Services',
//     'Manicure and Pedicure',
//     'Makeup',
//     'Facial',
//     'Threading',
//   ];

//   List<String> maleCategories = [
//     'assets/icons/men0.jpeg',
//     'assets/icons/men1.jpeg',
//     'assets/icons/men2.jpeg',
//     'assets/icons/men3.jpeg',
//     'assets/icons/men4.jpeg',
//     'assets/icons/men5.jpg',
//     'assets/icons/men6.jpg',
//     'assets/icons/men7.jpeg',
//     'assets/icons/men8.jpeg',
//   ];

//   List<String> femaleCategories = [
//     'assets/icons/female0.jpeg',
//     'assets/icons/female1.jpg',
//     'assets/icons/female2.jpg',
//     'assets/icons/female3.jpg',
//     'assets/icons/female4.jpeg',
//     'assets/icons/female5.jpeg',
//     'assets/icons/female6.jpeg',
//     'assets/icons/women7.jpg',
//     'assets/icons/female7.jpg',
//   ];
// //}

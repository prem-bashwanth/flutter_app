// // class UserDetailsModel {
// //   final String name;
// //   final String address;
// //   UserDetailsModel({required this.name, required this.address});

// //   Map<String, dynamic> getJson() => {
// //         'name': name,
// //         'address': address,
// //       };

// //   factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
// //     return UserDetailsModel(name: json["name"], address: json["address"]);
// //   }
// // }
// class UserDetailsModel {
//   final String name;
//   final String address;
//   final String userType; // new field
//   UserDetailsModel({required this.name, required this.address, required this.userType});

//   Map<String, dynamic> getJson() => {
//         'name': name,
//         'address': address,
//         'userType': userType, // new field
//       };

//   factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
//     return UserDetailsModel(
//       name: json["name"], 
//       address: json["address"], 
//       userType: json["userType"], // new field
//     );
//   }
// }
class UserDetailsModel {
  final String name;
  final String address;
  final String userType; 
  final String email;// new field
  UserDetailsModel({required this.name, required this.address,required this.email, required this.userType});

  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
        'userType': userType, 
        'email':email,// new field
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      name: json["name"], 
      address: json["address"], 
      userType: json["userType"],
      email:json["email"], // new field
    );
  }
}
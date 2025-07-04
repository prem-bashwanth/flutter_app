import 'package:flutter/material.dart';

import 'package:new_project/controllers/home_controller.dart';
import 'package:new_project/profile_screen/barber_screens/barbers_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:new_project/bookings_screen/bookings_screen.dart';
import 'package:new_project/home_screen/home_screen.dart';
import 'package:new_project/categories_screen/categories_screen.dart';
import 'package:new_project/profile_screen/profile_screen.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png" ,width: 26,),label: 'Home'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png" ,width: 26,),label: 'Cart'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/image.png" ,width: 36,),label: 'barbers'),
      BottomNavigationBarItem(icon: Image.asset("assets/icons/profile.png" ,width: 26,),label: 'Profile'),
    ];
    var navBody=[
       HomeScreen(

      ),
       MyCartScreen(),
       MyBookingsScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Column(
        children:[
        Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value),))
        ]
        ), 
      bottomNavigationBar: Obx(
        () =>BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: Colors.red,
          type:BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 240, 238, 238),
          items: navbarItem,
          onTap: (value) {
              controller.currentNavIndex.value =value;
          },
        )
      )
      
    );
  }
}





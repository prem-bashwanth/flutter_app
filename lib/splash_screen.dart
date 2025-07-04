import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/applogo_widget.dart';
import 'package:new_project/controllers/home_controller.dart';
import 'package:new_project/home.dart';
import 'package:new_project/signin_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3),(){
      Get.to(()=>Home());
    }); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft,),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            const Spacer(),
          ],
        )
      )
    );
  }
}
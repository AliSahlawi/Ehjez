import 'dart:async';

import 'package:ehjez/constants.dart';
import 'package:ehjez/screens/onboarding_screen.dart';
import 'package:ehjez/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   static String id = 'splash_screen';
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3) , ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => OnBoardingScreen()))));

  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text('Ehjez\n إحجز' , style: TextStyle(fontSize: 45 , fontFamily: "Sukar" , color: kTextColor  ),),
                  
                  Image.asset("assets/images/splash_screen.png" , height: 450, width: 250,) 



              ],
        ),
      ),
    );
  }
}
import 'package:ehjez/screens/onboarding_screen.dart';
import 'package:ehjez/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: prefer_const_constructors
void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Ehjez());
}


class Ehjez extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        SplashScreen.id :(context) => SplashScreen(),
        OnBoardingScreen.id :(context) => OnBoardingScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id :(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
      },
    );
  }
}


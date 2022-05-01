// ignore_for_file: prefer_const_constructors
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/screens/booking_screen.dart';
import 'package:ehjez/screens/favorite_screen.dart';
import 'package:ehjez/screens/how_it_works_screen.dart';
import 'package:ehjez/screens/map_screen.dart';
import 'package:ehjez/screens/onboarding_screen.dart';
import 'package:ehjez/screens/privacy_screen.dart';

import 'package:ehjez/screens/review_screen.dart';

import 'package:ehjez/screens/payment_screen.dart';
import 'package:ehjez/screens/history_screen.dart';
import 'package:ehjez/screens/settings_screen.dart';
import 'package:ehjez/screens/splash_screen.dart';
import 'package:ehjez/screens/support_screen.dart';

import 'package:ehjez/screens/user_profile_screen.dart';

import 'package:ehjez/screens/terms_of_use_screen.dart';

import 'package:ehjez/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ehjez/screens/login_screen.dart';
import 'package:ehjez/screens/registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:ehjez/services/database.dart';
import 'package:ehjez/models/user.dart' as current_user;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;




// ignore_for_file: prefer_const_constructors
void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51KqjRyAe0UDOMehKeupVi1gt6P4IQPdsbYskuX1zu1flCDiYtrOvj6ioZ63yTLn2sduli6khQpgxCg43eHEFGXqy00rAwmJL0B";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(Ehjez());
}


class Ehjez extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [

        StreamProvider<List<current_user.User>>.value(value: DatabaseService().streamUsers(), initialData:  []),
        StreamProvider<List<ParkingLocation>>.value(value: DatabaseService().streamParkingLocations(), initialData:  []),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserProfileScreen(),
        routes: {
          SplashScreen.id :(context) => SplashScreen(),
          OnBoardingScreen.id :(context) => OnBoardingScreen(),
          WelcomeScreen.id : (context) => WelcomeScreen(),
          LoginScreen.id :(context) => LoginScreen(),
          RegistrationScreen.id:(context) => RegistrationScreen(),
          MapScreen.id:(context) => MapScreen(),
          HistoryScreen.id:(context) => HistoryScreen(),
          FavoriteScreen.id:(context) => FavoriteScreen(),
          SupportScreen.id:(context) => SupportScreen(),
          SettingsScreen.id:(context)=> SettingsScreen(),
          HowItWorks.id:(context) => HowItWorks(),
          TermsOfUse.id:(context) => TermsOfUse(),
          PrivacyScreen.id:(context) => PrivacyScreen(),
          // PaymentScreen.id:(context) => PaymentScreen(),
          // ReviewScreen.id:(context) => ReviewScreen(),
          //BookingScreen.id:(context) => BookingScreen()

        },
      ),
    );
  }
}


import 'package:ehjez/constants.dart';
import 'package:ehjez/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../components/rounded_button.dart';


class OnBoardingScreen extends StatelessWidget {
  static String id = 'onboarding_screen';
  const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.height,
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Find Nearby Parking Spots' , 
            body:  'Do not waste your time finding a parking spot, locate them with just one tap. ',
            image: Center(child: Image.asset("assets/images/locate_park.png" ,height: 450, width: 250,)),
            decoration:  PageDecoration(
              titleTextStyle: TextStyle(color: kTextColor , fontFamily: "Sukar" , fontSize: 35) , 
              bodyTextStyle:TextStyle(color: Colors.black , fontFamily: "Sukar" , fontSize: 20),
              imagePadding: EdgeInsets.all(24),  
             )
          ),
          PageViewModel(
            title: 'Easy Payment' , 
            body:  'Payment has never been so easy.\nNow pay instantly with Benefit pay. ',
            image: Center(child: Image.asset("assets/images/easy_payment.png" ,height: 450, width: 250,)),
            decoration:  PageDecoration(
              titleTextStyle: TextStyle(color: kTextColor , fontFamily: "Sukar" , fontSize: 35) , 
              bodyTextStyle:TextStyle(color: Colors.black , fontFamily: "Sukar" , fontSize: 20),
              imagePadding: EdgeInsets.all(24),  
             ),

             footer:RoundedButton(
                onPress:()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => WelcomeScreen()))),
                text: 'Get Started'), 
          ),
        ],

        done: Text('Done', style: TextStyle(color: kTextColor , fontFamily: "Sukar" , fontSize: 22),),
        onDone:()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => WelcomeScreen()))) ,
        showNextButton: false,   
        showDoneButton: false,

        dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.amberAccent,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)
    )
  ),
      ),
    );
  }
}
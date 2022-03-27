import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ehjez/components/rounded_button.dart';
import 'package:ehjez/constants.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  text: ['Ehjez\n إحجز'],
                  textStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                onPress: () => Navigator.pushNamed(context, LoginScreen.id),
                text: 'Log in'),
            RoundedButton(
                onPress: () =>
                    Navigator.pushNamed(context, RegistrationScreen.id),
                text: 'Register'),
          ],
        ),
      ),
    );
  }
}

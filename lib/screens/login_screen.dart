import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ehjez/constants.dart';
import 'package:ehjez/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'map_screen.dart';
// ignore_for_file: prefer_const_constructors

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";


  // String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: const [
                Text(
                  'Log in ',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: kTextColor
                  ),
                ),
              ],
            )
            ,SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                text: 'Log in ',
                onPress: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {

                      //Navigator.pushNamed(context, AnyScreen.id);
                      print(user.user?.email);
                      print(password);

                      Navigator.pushNamed(context, MapScreen.id);
                      //print(user.user?.email);

                    }
                  } catch (e) {
                    print(e);
                  }
                }),

          ],
        ),
      ),
    );
  }
}

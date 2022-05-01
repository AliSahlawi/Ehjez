

import 'package:ehjez/constants.dart';
import 'package:ehjez/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:ehjez/constants.dart';

class UserProfileScreen extends StatefulWidget {
  static String id = 'user_profile_screen';


  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  final auth = FirebaseAuth.instance;

  final List<Map<String, dynamic>> _types = [
  {
  'value': 'SUV',
  'label': 'SUV',
  },
  {
  'value': 'Hatchback',
  'label': 'Hatchback',
  },
  {
  'value': 'Sedan',
  'label': 'Sedan',
  },
  {
  'value': 'MPV',
  'label': 'MPV',
  },
  {
  'value': 'Crossover',
  'label': 'Crossover',
  },
  {
  'value': 'Coupe',
  'label': 'Coupe',
  },
  {
  'value': 'Convertible',
  'label': 'Convertible',
  },
  ];
  String email = "";
  String password = "";
  String name = "";
  String carNumber = "";
  String phoneNumber = "";
  String type = "";
  String vehicle = "";
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(
              color: kTextColor,
              fontSize: 25,
              fontFamily: "Sukar",

          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding:  EdgeInsets.only(left: size.width*0.08,right:size.width*0.08 ),
          child: Column(

            children: [
              Padding(
                padding:  EdgeInsets.only(top: size.height*0.05,bottom: size.height*0.05),
                child:CircleAvatar(),
        ),


      TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration:
            kTextFieldDecoration.copyWith(
                prefixIcon: Padding(
                  padding:  EdgeInsets.only(left: 15,top: 13),
                  child: Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                      fontFamily: "Sukar"
                    ),

            ),
                ),

            ),
            onSubmitted:  (value){
              if(!value.isEmail())
              {
                print('not valid');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please a valid Email'),
                  ),
                );
                setState(() {
                  email = "";
                });
              }
            }
      ),
      SizedBox(
          height: 15,
      ),
      TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration: kTextFieldDecoration.copyWith(
              prefixIcon: Padding(
                  padding:  EdgeInsets.only(left: 15,top: 14),
                  child: Text(
                    "Password: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        fontFamily: "Sukar"
                    )
                  )
              )
            ),
            onSubmitted:  (value){
              if(!value.isPasswordEasy())
              {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please a valid Password'),
                  ),
                );
                setState(() {
                  password = "";
                });
              }
            }

      ),
      SizedBox(
          height: 8.0,
      ),
      TextField(
          textAlign: TextAlign.center,
          onChanged: (value) {
            name = value;
          },
          decoration:
          kTextFieldDecoration.copyWith(  prefixIcon: Padding(
              padding:  EdgeInsets.only(left: 15,top: 14),
              child: Text(
                  "Name: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                      fontFamily: "Sukar"
                  )
              )
          )),
          onSubmitted:  (value){
            if(!value.isUsername())
            {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please Enter a valid Name'),
                ),
              );
              setState(() {
                name = "";
              });
            }
          } ,
      ),
      SizedBox(
          height: 15.0,
      ),
      TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              carNumber = value;
            },
            decoration:
            kTextFieldDecoration.copyWith(  prefixIcon: Padding(
                padding:  EdgeInsets.only(left: 15,top: 13),
                child: Text(
                    "Car Number: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        fontFamily: "Sukar"
                    )
                )
            )),
            onSubmitted:  (value){
              if(!value.isNumeric())
              {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please Enter a valid Car Number'),
                  ),
                );
                setState(() {
                  carNumber = "";
                });
              }
            }
      ),
      SizedBox(
          height: 15.0,
      ),
      TextField(
          textAlign: TextAlign.center,
          onChanged: (value) {
            phoneNumber = value;
          },
          onSubmitted:  (value){
            if(!value.isPhone())
            {
              print('not valid');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please a valid Phone Number'),
                ),
              );
              setState(() {
                phoneNumber = "";
              });
            }
          } ,
          decoration:
          kTextFieldDecoration.copyWith(
              prefixIcon: Padding(
                  padding:  EdgeInsets.only(left: 15,top: 13),
                  child: Text(
                      "Phone Num: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                          fontFamily: "Sukar"
                      )
                  )
              )),
      ),

      SizedBox(
          height: 60.0,
      ),
              ElevatedButton(
                onPressed: ()  async{
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(300, 20),
                    primary: Colors.amber,
                    textStyle: TextStyle(fontSize: 26,fontFamily: "Sukar"),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                child: Text("Save"),)

          ],



    ),
        ),
      )
    );
  }
}

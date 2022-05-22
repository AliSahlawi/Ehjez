

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/constants.dart';
import 'package:ehjez/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';



import 'package:ehjez/models/user.dart' as current_user;

class UserProfileScreen extends StatefulWidget {
  static String id = 'user_profile_screen';


  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  final auth = FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User');


  late String email ;
  late String name ;
  late String   carNumber ;
  late String phoneNumber ;
  late String dbEmail ;
  late String dbName ;
  late String dbCarNumber ;
  late String dbPhoneNumber ;
  TextEditingController emailCtrl =TextEditingController();
  TextEditingController nameCtrl =TextEditingController();
  TextEditingController carNumberCtrl =TextEditingController();
  TextEditingController phoneNumCtrl =TextEditingController();

  late final StreamSubscription myStream;


  @override
  void initState() {
    super.initState();

    myStream = userCollection
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((snapshot)  {
          emailCtrl.text= current_user.User.fromJson(snapshot).email;
          nameCtrl.text = current_user.User.fromJson(snapshot).name;
          carNumberCtrl.text = current_user.User.fromJson(snapshot).plateNum;
          phoneNumCtrl.text = current_user.User.fromJson(snapshot).phoneNum;
          email = emailCtrl.text;
          name= nameCtrl.text;
          carNumber = carNumberCtrl.text;
          phoneNumber= phoneNumCtrl.text;

          dbEmail= current_user.User.fromJson(snapshot).email;
          dbName = current_user.User.fromJson(snapshot).name;
          dbCarNumber= current_user.User.fromJson(snapshot).plateNum;
          dbPhoneNumber = current_user.User.fromJson(snapshot).phoneNum;
        });



  }





  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(

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

      body: SingleChildScrollView(
       physics:  ClampingScrollPhysics(),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.only(left: size.width*0.08,right:size.width*0.08 ),
            child:
         FutureBuilder<current_user.User>(
           future: DatabaseService().getUser(auth.currentUser!.uid),
           builder: (context,snapshot) {
             if(snapshot.hasData){

             return Column(

                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.05, bottom: size.height * 0.05),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: kTextColor,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/user.png"),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),

                       TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            email = value;

                          },

                           controller: emailCtrl,

                          decoration:
                          kTextFieldDecoration.copyWith(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15, top: 13),
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
                          onSubmitted: (value) {
                            if (!value.isEmail()) {
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

                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      name = value;
                    },
                    controller: nameCtrl,
                    decoration:
                    kTextFieldDecoration.copyWith(prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 15, top: 14),
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
                    onSubmitted: (value) {
                      if (!value.isUsername()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please Enter a valid Name'),
                          ),
                        );
                        setState(() {
                          name = "";
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        carNumber = value;
                      },
                      controller: carNumberCtrl,
                      decoration:
                      kTextFieldDecoration.copyWith(prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15, top: 13),
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
                      onSubmitted: (value) {
                        if (!value.isNumeric()) {
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
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                        phoneNumber=value;
                    },
                    onSubmitted: (value) {
                      if (!value.isPhone()) {
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
                    },
                    controller: phoneNumCtrl,

                    decoration:
                    kTextFieldDecoration.copyWith(
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 15, top: 13),
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
                    onPressed: () async {

                if(!(email.isEmpty && name.isEmpty&& carNumber.isEmpty&& phoneNumber.isEmpty)) {
                  DatabaseService().updateUser(
                          name: name,
                          email: email,
                          plateNum: carNumber,
                          phoneNum: phoneNumber,
                          uid: auth.currentUser!.uid);


                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                          'Your information was updated successfully ',
                          style: TextStyle(color: Colors.black),
                        ),
                          backgroundColor: Colors.amber,

                        ),

                      );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(
                      'You miss something ',
                      style: TextStyle(color: Colors.black),
                    ),
                      backgroundColor: Colors.amber,

                    ),

                  );

                }

                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(300, 20),
                        primary: Colors.amber,
                        textStyle: TextStyle(fontSize: 26, fontFamily: "Sukar"),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    ),
                    child: Text("Save"),)

                ],


              );
             }
             return Text("Not found");
           })
          )

    ),
      ),
        );


  }
}

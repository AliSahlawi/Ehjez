

import 'package:flutter/material.dart';
import 'package:ehjez/constants.dart';
import 'package:ehjez/components/rounded_button.dart';
import 'package:ehjez/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:regexpattern/regexpattern.dart';




class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String name = "";
  String carNumber = "";
  String phoneNumber = "";
  String type = "";

  TextEditingController emailCtrl =TextEditingController();
  TextEditingController passwordCtrl =TextEditingController();
  TextEditingController nameCtrl =TextEditingController();
  TextEditingController carNumberCtrl =TextEditingController();
  TextEditingController phoneNumCtrl =TextEditingController();


  late FocusNode focusNodeEmail;
  late FocusNode focusNodePassword;
  late FocusNode focusNodeName;
  late FocusNode focusNodeCarNumber;
  late FocusNode focusNodePhoneNumber;




  @override
  void initState(){
    super.initState();
    focusNodeEmail = FocusNode();
    focusNodePassword=FocusNode();
    focusNodeName = FocusNode();
    focusNodeCarNumber = FocusNode();
    focusNodePhoneNumber= FocusNode();

    focusNodeEmail.addListener(() {
      if(!focusNodeEmail.hasFocus){
        if(!email.isEmail())
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Enter a valid Email'),
                backgroundColor: Colors.redAccent
            ),
          );

            emailCtrl.clear();

        }
      }
    });

    focusNodePassword.addListener(() {
      if(!focusNodePassword.hasFocus){
        if(!password.isPasswordEasy())
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Enter a valid Password'),
              backgroundColor: Colors.redAccent,
            ),
          );

         passwordCtrl.clear();

        }
      }
    });

    focusNodeName.addListener(() {
      if(!focusNodeName.hasFocus){
        if(name.length<3 && name.length<12)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Your Name is to short'),
                backgroundColor: Colors.redAccent
            ),
          );

         nameCtrl.clear();

        }
      }
    });

    focusNodeCarNumber.addListener(() {
      if(!focusNodeCarNumber.hasFocus){
        if(!carNumber.isNumeric())
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Enter a valid Car Number'),
                backgroundColor: Colors.redAccent
            ),
          );

            carNumberCtrl.clear();


        }
      }
    });

    focusNodePhoneNumber.addListener(() {
      if(!focusNodePhoneNumber.hasFocus){
        if(!phoneNumber.isNumeric())
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Enter a valid Phone Number'),
                backgroundColor: Colors.redAccent
            ),
          );

          phoneNumCtrl.clear();

        }
      }
    });



  }
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


  late DateTime DOB = DateTime(1980, 1, 1);

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Register ',
                      style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: kTextColor,

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  focusNode: focusNodeEmail,
                  controller: emailCtrl,
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
                    // onSubmitted:  (value){
                    //   if(!value.isEmail())
                    //   {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text('Please Enter a valid Email'),
                    //       ),
                    //     );
                    //     setState(() {
                    //       email = "";
                    //     });
                    //   }
                    // }
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
                  focusNode: focusNodePassword,
                  controller: passwordCtrl,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                    // onSubmitted:  (value){
                    //   if(!value.isPasswordEasy())
                    //   {
                    //
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text('Please Enter a valid Password'),
                    //       ),
                    //     );
                    //     setState(() {
                    //       password = "";
                    //     });
                    //   }
                    // }

                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  focusNode: focusNodeName,
                  controller: nameCtrl,
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your Name'),
                  // onSubmitted:  (value){
                  //   if(value.length < 3)
                  //   {
                  //
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text('Please Enter a valid Name'),
                  //       ),
                  //     );
                  //     setState(() {
                  //       name = "";
                  //     });
                  //   }
                  // } ,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    carNumber = value;
                  },
                  focusNode: focusNodeCarNumber,
                  controller: carNumberCtrl,
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your Car Number'),
                    // onSubmitted:  (value){
                    //   if(!value.isNumeric())
                    //   {
                    //
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text('Please Enter a valid Car Number'),
                    //       ),
                    //     );
                    //     setState(() {
                    //       carNumber = "";
                    //     });
                    //   }
                    // }
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  focusNode: focusNodePhoneNumber,
                  controller: phoneNumCtrl,
                  // onSubmitted:  (value){
                  //   if(!value.isNumeric())
                  //     {
                  //       print('not valid');
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Please a valid Phone Number'),
                  //         ),
                  //       );
                  //       setState(() {
                  //         phoneNumber = "";
                  //       });
                  //     }
                  // } ,
                  decoration:
                  kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Phone Number'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: kTextColor,
                      width: 1.0
                    ) ,
                    borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  child: SelectFormField(
                    items: _types,
                    initialValue: '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kTextColor),
                    hintText: 'Chose your Car Type',
                    onChanged: (val)=> setState(() {
                      type = val;
                    }),

                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    text: 'Register',
                    onPress: () async {
                      if(name.isNotEmpty && email.isNotEmpty&& phoneNumber.isNotEmpty && carNumber.isNotEmpty && password.isNotEmpty && type.isNotEmpty) {
                        try {
                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          _firestore.collection('User')
                              .doc(newUser.user?.uid)
                              .set({
                            'Name': name,
                            'Email': email,
                            'PhoneNum': phoneNumber,
                            'PlateNum': carNumber,
                            'Favorites': [],
                            'Type': type,
                          });
                         // Navigator.pushNamed(context, MapScreen.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Your are Registered Successfully'),
                              backgroundColor: Colors.lightGreenAccent[700],
                            ),
                          );
                          Navigator.pushNamed(context, MapScreen.id);
                        } catch (e) {
                          print(e);
                        }
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('One of the fields is missing !'),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

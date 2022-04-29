

import 'package:ehjez/constants.dart';
import 'package:ehjez/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:ehjez/constants.dart';

class ReviewScreen extends StatefulWidget {
  static String id = 'review_screen';
  final String parkingLocationId;
  ReviewScreen({required this.parkingLocationId});
  @override
  State<StatefulWidget> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  final auth = FirebaseAuth.instance;
  var rate = 0.0 ;
  DateTime postTime = DateTime.now();
  String review = "";
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Review",
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
              fontFamily: "Sukar"
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: size.height*0.05, left: size.width*0.05 ),
            child: Text("Rate this location",
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                  fontFamily: "Sukar"
              ) ,),
          ),
          Padding(
            padding:  EdgeInsets.only(top: size.height*0.01, left: size.width*0.05 ),
            child: Text("Tell others what you think ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontFamily: "Sukar"
              ) ,),
          ),
          Padding(
            padding:  EdgeInsets.only(top: size.height*0.10 ),
            child: Center(
              child: SmoothStarRating(

                  allowHalfRating: false,
                  onRatingChanged: (v) {

                    setState(() { rate= v;});
                  },
                  starCount: 5,
                  size: 50.0,
                  filledIconData: Icons.star,
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  spacing:10,
                  rating: rate,

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: size.height*0.05),
            child: Center(
              child: SizedBox(
                width: 300 ,

                child: TextField(
                  onChanged: (value)=>setState(() {
                    review = value;
                  }),
                  minLines: 5 ,
                  maxLines: 20,
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    hintText: "Describe your experience"
                  ),


                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:size.height*0.08),
            child: Center(
              child: ElevatedButton(
                onPressed: ()  async{
                  await DatabaseService().addFeedback(rate: rate.toInt(), string: review, time: postTime, uid: auth.currentUser!.uid, parkingLocationId: widget.parkingLocationId);
                  Navigator.pop(context);
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
                child: Text("Post"),),
            ),
          )
        ],
      ),
    );
  }
}

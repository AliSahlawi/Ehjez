import 'package:ehjez/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:ehjez/constants.dart';

class ReviewScreen extends StatefulWidget {
  static String id = 'review_screen';
  @override
  State<StatefulWidget> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
var rate = 0.0 ;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review",
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                fontWeight: FontWeight.bold
              ) ,),
          ),
          Padding(
            padding:  EdgeInsets.only(top: size.height*0.01, left: size.width*0.05 ),
            child: Text("Tell others what you think ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20
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
          TextField(
            minLines: 1 ,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),

          )
        ],
      ),
    );
  }
}

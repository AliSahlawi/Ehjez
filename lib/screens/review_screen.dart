import 'package:ehjez/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ReviewScreen extends StatefulWidget {
  static String id = 'review_screen';
  @override
  State<StatefulWidget> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
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
        children: [

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ehjez/constants.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({required this.onPress,required this.text});


  final void Function()? onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed:  onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
                color: kTextColor
            ),
          ),
        ),
      ),
    );
  }
}

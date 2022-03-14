import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
void main() => runApp(Ehjez());


class Ehjez extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1D2136),
        scaffoldBackgroundColor: Color(0xFF1D2136),
      ),
      home: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}


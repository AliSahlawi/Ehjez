
import 'dart:ui';

import 'package:ehjez/constants.dart';
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/user.dart' as currentUser;
import 'package:ehjez/screens/booking_screen.dart';
import 'package:ehjez/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavoriteScreen extends StatefulWidget {
  static String id = 'favorite_screen';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final userAuth = FirebaseAuth.instance.currentUser;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locations = Provider.of<List<ParkingLocation>>(context);
    getLocation(String id){
      for(var location in locations) {
        if (location.id == id) {
          return location;
        }

      }
    }

    return Scaffold(
      body: FutureBuilder<currentUser.User>(
          future: DatabaseService().getUser(userAuth!.uid),
          builder: (context, snapshot) {
            if(snapshot.hasData)
              return Container(
                width: size.width,
                height: size.height,

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 15, 25),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                          Text(
                            'Favorites',
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.08,),

                      for(var location in snapshot.data!.favorites)

                        Container(

                          height: size.height * 0.15,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 5,
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image(image: AssetImage("assets/images/locate_park.png"),
                                            height: 60,
                                            width: 60),
                                        SizedBox(width: size.width * 0.025,),
                                        Text(
                                          getLocation(location)!.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Sukar"),
                                        ),




                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>  BookingScreen(
                                            parkingLocationId: location,
                                          ),
                                        ),);
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: kTextColor,
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
              );

            return Container(
              width: size.width,
              height: size.height,

              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 25, 15, 25),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: kTextColor,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.18,
                        ),
                        Text(
                          'Favorites',
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.08,),



                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

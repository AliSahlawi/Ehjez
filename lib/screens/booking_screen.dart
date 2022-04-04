import 'package:badges/badges.dart';
import 'package:ehjez/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:ehjez/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookingScreen extends StatefulWidget {
  static String id = 'booking_screen';
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking ',
            style: TextStyle(fontSize: 25.0, color: kTextColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () { },
            icon: Icon(
              Icons.arrow_back,
              color: kTextColor,
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () { DatabaseService().getUsers();},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 30.0,
                ))
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
        children:[ Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 230, 0),
                child: Text("Destination",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 26.0,

                    )
                ),
              )
            ]
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                        image: AssetImage("assets/images/locate_park.png"),
                        height: 150,
                        width: 150),
                    SizedBox(width: 20),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                      children:  [
                        Container(
                         // margin: EdgeInsets.fromLTRB(0, 0, 46, 10),

                          child: Text(
                              "City Center",
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          "Bulding 2758, Road 4650 Shaikh Khalifa Bin Salman Hwy, Jidhafs",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ))
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children:  [
                      Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "Arriving",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Time",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  Badge(
                      badgeContent: Text("2h 5m"),
                      badgeColor: Colors.amber,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(20)),
                  Column(
                    children:  [
                      Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "Leaving",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Time",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 60, 10),
                      child: Text(
                        "Vehicle",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "vehicle",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                       margin: EdgeInsets.fromLTRB(0, 10, 90, 10),
                      child: Text(
                        "Type",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),

                    Text(
                      "sedan",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Plate Number",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Text(
                      "00000",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                  ],

                ),
                Divider(

                  color: Colors.grey,
                  thickness: 1,
                )
              ],
            ),
            Container(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Image(
                      image: AssetImage("assets/images/locate_park.png"),
                      height: 240,
                      width: 240
                  ),
                 SizedBox(width: 40),
                  Image(
                      image: AssetImage("assets/images/locate_park.png"),
                      height: 240,
                      width: 240
                  ),
                  SizedBox(width: 40),
                  Image(
                      image: AssetImage("assets/images/locate_park.png"),
                      height: 240,
                      width: 240
                  ),
                  SizedBox(width: 40),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 210,0),
                child: Text("Description",
                style: TextStyle(
                  fontSize: 26,
                  color: kTextColor,
                ),
                )
            ),
            Container(

                margin: EdgeInsets.fromLTRB(0, 20, 210,0),
                child: Text(
                  "text text text",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
            ),
            SizedBox(height: 20,),
            Divider(

              color: Colors.grey,
              thickness: 1,
            )
          ],

        )
    ])
    );
  }
}



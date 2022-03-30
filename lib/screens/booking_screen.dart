import 'package:badges/badges.dart';
import 'package:ehjez/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class booking_screen extends StatelessWidget {
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
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: kTextColor,
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 30.0,
                ))
          ],
        ),
        body: Column(
          children: <Widget>[
            Column(children: const [
              Text("Destination",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 24.0,
                  ))
            ]),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                        image: AssetImage("assets/images/locate_park.png"),
                        height: 150,
                        width: 150),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "City Center Mall",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 25,
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
                    children: const [
                      Text(
                        "Arriving",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  Badge(
                      badgeContent: Text("2h 5m"),
                      badgeColor: Colors.amber,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(20)),
                  Column(
                    children: const [
                      Text(
                        "Leaving",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
                    Text(
                      "Vehicle",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 50, 0),
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
                      margin: EdgeInsets.fromLTRB(0, 10, 85, 20),
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
                  children: const [
                    Text(
                      "Plate Number",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      "00000",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
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
            )
          ],
        ));
  }
}

import 'package:badges/badges.dart';
import 'package:ehjez/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:ehjez/Services/database.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  static String id = 'booking_screen';

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var Reservations = [];
  var Users = [];
  String formattedTime = DateFormat('hh:mm').format(DateTime.now());
  TimeOfDay time0 = TimeOfDay.now();
  TimeOfDay time1 = TimeOfDay.now();
  var Arriving;
  var leaving;
  final auth = FirebaseAuth.instance;
  var uid;
  User? _User;
  static const rowSpacer=TableRow(
      children:  [
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 15,
        )
      ]);

  _BookingScreenState() {
    _User = auth.currentUser;
    uid = _User?.uid;
    _getUser();
  }

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
                onPressed: () {

                },
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 30.0,
                ))
          ],
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 30, right: 200),
                      child: Text("Destination",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 26.0,
                          )),
                    ),
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
                      SizedBox(width: 20),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "City Center",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                decoration:
                BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Arriving",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            Arriving = await showTimePicker(
                                context: context, initialTime: time0);

                            if (Arriving != null) {
                              setState(() {
                                time0 = Arriving;
                              });
                            }
                          },
                          child: Text(
                            time0.format(context).toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 78,
                          child: VerticalDivider(
                            width: 60,
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          left: 1,
                          child: Badge(
                              badgeContent: Text(Duration()),
                              badgeColor: Colors.amber,
                              shape: BadgeShape.square,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Leaving",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            leaving = await showTimePicker(
                                context: context, initialTime: time1);

                            if (leaving != null) {
                              setState(() {
                                time1 = leaving;
                              });
                            }
                          },
                          child: Text(
                            time1.format(context).toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Table(columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(0.1),
                }, children: [
                  rowSpacer,
                  TableRow(

                    children:  [
                      Text(
                        "Vehicle",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        Users[0]['Vehicle'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),

                    ],
                  ),
                  rowSpacer,
                  TableRow(
                    children:  [
                      Text(
                        "Type",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        Users[0]['Type'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  rowSpacer,
                  TableRow(
                    children: [
                      Text(
                        "Plate Number",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        Users[0]['PlateNum'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  rowSpacer
                ]),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Image(
                        image: AssetImage("assets/images/locate_park.png"),
                        height: 240,
                        width: 240),
                    SizedBox(width: 40),
                    Image(
                        image: AssetImage("assets/images/locate_park.png"),
                        height: 240,
                        width: 240),
                    SizedBox(width: 40),
                    Image(
                        image: AssetImage("assets/images/locate_park.png"),
                        height: 240,
                        width: 240),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 210, 0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 26,
                      color: kTextColor,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 210, 0),
                  child: Text(
                    "text text text",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              )
            ],
          )
        ]));
  }

  void _getUser() async {
    Users = (await DatabaseService().getUser(uid)) as List;
  }

  String Duration() {
    var HoursDifferenece = (time1.hour - time0.hour).abs();
    var MinutesDifference = (time1.minute - time0.minute).abs();

    return "$HoursDifferenece : $MinutesDifference h";
  }
}

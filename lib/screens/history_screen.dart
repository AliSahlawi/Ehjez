

import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/reservation.dart';
import 'package:ehjez/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ehjez/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class HistoryScreen extends StatefulWidget {
  static String id = 'history_screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      body: StreamBuilder<List<Reservation>>(
        stream: DatabaseService().streamReservation(userAuth!.uid),
        builder: (context, snapshot) {
          if(snapshot.hasData){
          return StreamBuilder<List<Reservation>>(
            stream: DatabaseService().streamCurrentReservation(userAuth!.uid),
            builder: (context, snapshot2) {
              if(snapshot2.hasData)
              return Container(
                width: size.width,
                height: size.height,

                child: Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.03, size.width * 0.03, size.width * 0.025, size.width * 0.025),
                  child: ListView(
                    children: [
                      Column(

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
                                width: size.width * 0.15,
                              ),
                              Text(
                                'My bookings',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Sukar", fontSize: size.height * 0.047),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.05,),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                            child: Row(
                              children: [
                                Text('Active Reservation',style:TextStyle(
                                    color: kTextColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Sukar") ,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),
                          for(var reservation in snapshot2.data!)
                            if(DateTime.now().isBefore(reservation.finishDate))
                            Container(
                              margin: EdgeInsets.only(bottom: size.height * 0.012),
                              height: size.height * 0.2,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 5,
                                  )
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(size.height * 0.019),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getLocation(reservation.location)!.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Sukar"),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Arrival time',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,

                                              fontFamily: "Sukar"),
                                        ),
                                        Text(
                                          DateFormat.yMd().add_jm() .format(reservation.startDate).toString(),
                                          style: TextStyle(color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Leaving time',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,

                                              fontFamily: "Sukar"),
                                        ),
                                        Text(
                                          DateFormat.yMd().add_jm() .format(reservation.finishDate).toString(),
                                          style: TextStyle(color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          SizedBox(height: size.height * 0.05,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                            child: Row(
                              children: [
                                Text('History',style:TextStyle(
                                    color: kTextColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Sukar") ,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),


                          for(var reservation in snapshot.data!)
                          if(DateTime.now().isAfter(reservation.finishDate))
                            Container(
                              margin: EdgeInsets.only(bottom: size.height * 0.012),
                              height: size.height * 0.2,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 5,
                                  )
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(size.height * 0.019),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getLocation(reservation.location)!.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Sukar"),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Arrival time',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,

                                              fontFamily: "Sukar"),
                                        ),
                                        Text(
                                          DateFormat.yMd().add_jm() .format(reservation.startDate).toString(),
                                          style: TextStyle(color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Leaving time',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,

                                              fontFamily: "Sukar"),
                                        ),
                                        Text(
                                          DateFormat.yMd().add_jm() .format(reservation.finishDate).toString(),
                                          style: TextStyle(color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),


                        ],
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
                            width: size.width * 0.15,
                          ),
                          Text(
                            'My bookings',
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.08,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                        child: Row(
                          children: [
                            Text('History',style:TextStyle(
                                color: kTextColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Sukar") ,)
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
          );
          }

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
                        width: size.width * 0.15,
                      ),
                      Text(
                        'My bookings',
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.08,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                    child: Row(
                      children: [
                        Text('History',style:TextStyle(
                            color: kTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sukar") ,)
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),


                ],
              ),
            ),
          );
        }
      ),
    );
  }



}

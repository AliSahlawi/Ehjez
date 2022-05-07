import 'package:badges/badges.dart';

import 'package:ehjez/components/CustomerReview.dart';
import 'package:ehjez/constants.dart';
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/reservation.dart';
import 'package:ehjez/screens/review_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ehjez/models/user.dart' as current_user;

import 'package:ehjez/services/database.dart';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:ehjez/screens/payment_screen.dart';

class BookingScreen extends StatefulWidget {
  static String id = 'booking_screen';

  final parkingLocationId;

  BookingScreen({required this.parkingLocationId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  double amount = 0;
  String parkingLocationName = "";

  DateTime date0 = DateTime.now();
  DateTime date1 = DateTime.now();
  TimeOfDay time0 = TimeOfDay.now();
  TimeOfDay time1 = TimeOfDay.now().replacing(hour: DateTime.now().hour+1 , minute: DateTime.now().minute );
  var myDuration = 0;

  DateTime? Arriving;
  DateTime? leaving;
  final auth = FirebaseAuth.instance;
  var uid;

  static const rowSpacer = TableRow(children: [
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    )
  ]);

  bool isFav = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // var users = Provider.of<List<current_user.User>>(context);
 //   var locations = Provider.of<List<ParkingLocation>>(context);

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking ',
            style: TextStyle(
                fontSize: 25.0, color: kTextColor, fontFamily: "Sukar"),
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
          actions: <Widget>[
            FutureBuilder<current_user.User>(
                future: DatabaseService().getUser(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    isFav = snapshot.data!.favorites
                        .contains(widget.parkingLocationId);
                    return IconButton(
                      onPressed: () {
                        if (!isFav) {
                          DatabaseService().addToFavorite(
                              auth.currentUser!.uid, widget.parkingLocationId);
                          setState(() {
                            isFav = !isFav;
                          });
                        } else {
                          DatabaseService().removeFromFavorite(
                              auth.currentUser!.uid, widget.parkingLocationId);
                          setState(() {
                            isFav = !isFav;
                          });
                        }
                      },
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.amber : Colors.grey,
                        size: 30.0,
                      ),
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      // if(!isFavorite)

                      DatabaseService().addToFavorite(
                          auth.currentUser!.uid, widget.parkingLocationId);
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 30.0,
                    ),
                  );
                })
          ],
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.04, left: size.width * 0.05),
                      child: Text("Destination",
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 26.0,
                              fontFamily: "Sukar")),
                    ),
                  ]),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<ParkingLocation>(
                        future:DatabaseService()
                            .getParkingLocation(widget.parkingLocationId) ,
                        builder: (context, snapshot){
                          if(snapshot.hasData) {
                            return Padding(
                            padding:  EdgeInsets.only (left: size.width*0.05),
                            child: Image(
                              image: NetworkImage(snapshot.data!.mainImage),
                              height: 150,
                              width: 180),
                          );
                          }

                          return CircularProgressIndicator();

                        }
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FutureBuilder<ParkingLocation>(
                          future: DatabaseService()
                              .getParkingLocation(widget.parkingLocationId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              parkingLocationName = snapshot.data!.name;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 46, 10),

                                    child: Text(
                                      snapshot.data!.name,
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 30,
                                          fontFamily: "Sukar"),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.description,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: "Sukar"),
                                  )
                                ],
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      )
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Sukar"),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: "Sukar"),
                          ),
                          onPressed: () async {
                            date0 = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022, 3, 1),
                                lastDate: DateTime(2050)))!;

                            if ((date0.difference(DateTime.now()).inDays) >= 0) {
                              print("The first Date is $date0");
                              time0 = (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()))!;

                              if (date0.day == DateTime.now().day) //current day
                              {
                                if (_toDouble(time0) <
                                    _toDouble(TimeOfDay.now())) {
                                  _showMyDialog("Wrong Time",
                                      "Please, Select Current Time or Time in Future");
                                  setState(() {
                                    time0 = TimeOfDay.now();
                                    myDuration = 0;
                                  });
                                }
                              }
                            } else {
                              _showMyDialog("Wrong Date",
                                  "Please, Select Today's Date or Date in Future");
                              setState(() {
                                time0 = TimeOfDay.now();
                                date0 = DateTime.now();
                                myDuration = 0;
                              });
                            }

                            Arriving = DateTime(date0.year, date0.month,
                                date0.day, time0.hour, time0.minute);

                            if (Arriving != null) {
                              setState(() {
                                time0 = TimeOfDay.fromDateTime(Arriving!);
                              });
                            }
                          },
                          child: Text(
                            // DateFormat('h:mm a').format(Arriving),
                            time0.format(context),
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
                          child: FittedBox(
                            child: Badge(
                                badgeContent: Text(
                                  durationToString(myDuration),
                                  style: TextStyle(fontFamily: "Sukar"),
                                ),
                                badgeColor: Colors.amber,
                                shape: BadgeShape.square,
                                borderRadius: BorderRadius.circular(20)),
                          ),
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Sukar"),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: "Sukar"),
                          ),
                          onPressed: () async {
                            date1 = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022, 3, 1),
                                lastDate: DateTime(2050)))!;
                            if ((date1.difference(date0).inDays) >= 0) {
                              time1 = (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()))!;

                              if (date0.day == date1.day) //current day
                              {
                                if (_toDouble(time0) > _toDouble(time1)) {
                                  _showMyDialog("Wrong Time",
                                      "You Can't Leave Before Arrive");

                                  setState(() {
                                    time1 = TimeOfDay.now();
                                    myDuration = 0;
                                  });
                                } else {
                                  leaving = DateTime(date1.year, date1.month,
                                      date1.day, time1.hour, time1.minute);

                                  setState(() {
                                    time1 = TimeOfDay.fromDateTime(leaving!);
                                    print(duration());
                                    myDuration = duration();
                                  });
                                }
                              } else //if it is tomorrow
                              {
                                leaving = DateTime(date1.year, date1.month,
                                    date1.day, time1.hour, time1.minute);

                                setState(() {
                                  time1 = TimeOfDay.fromDateTime(leaving!);
                                  print(duration());
                                  myDuration = duration();
                                });
                              }
                            } else {
                              _showMyDialog("Wrong Date",
                                  "Please, Select Today's Date or Date in Future");
                              date1 = DateTime.now();
                              myDuration = 0;
                              setState(() {
                                date1 = DateTime.now();
                                time1 = TimeOfDay.now();
                                myDuration = 0;
                              });
                            }
                          },
                          child: Text(
                            // DateFormat('h:mm a').format(leaving),
                            time1.format(context),
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
                child: FutureBuilder<current_user.User>(
                    future: DatabaseService().getUser(auth.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(0.2),
                            1: FlexColumnWidth(0.1),
                          },
                          children: [
                            rowSpacer,
                            TableRow(
                              children: [
                                Text(
                                  "Vehicle",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontFamily: "Sukar"),
                                ),
                              ],
                            ),
                            rowSpacer,
                            TableRow(
                              children: [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.type,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontFamily: "Sukar"),
                                ),
                              ],
                            ),
                            rowSpacer,
                            TableRow(
                              children: [
                                Text(
                                  "Plate Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.plateNum,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontFamily: "Sukar"),
                                ),
                              ],
                            ),
                            rowSpacer
                          ],
                        );
                      }
                      return Text(
                        "8888",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: "Sukar"),
                      );
                    }),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                height: 240,
                child: FutureBuilder<ParkingLocation>(
                  future: DatabaseService()
                      .getParkingLocation(widget.parkingLocationId),
                  builder:(context,snapshot){
                    if(snapshot.hasData) {
                      return ListView(
                    scrollDirection: Axis.horizontal,
                    children: getImages(snapshot.data!.images,
                      size.width*0.025,
                      size.height*0.05,
                      size.height*0.05,
                      size.width*0.025
                    )
                  );
                    }

                    return CircularProgressIndicator();
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 26, color: kTextColor, fontFamily: "Sukar"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.08, top: size.height * 0.02),
                child: Text(
                  "text text text",
                  style: TextStyle(
                      fontSize: 20, color: Colors.black, fontFamily: "Sukar"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 0),
                child: Text(
                  "Customer Reviews",
                  style: TextStyle(
                      color: kTextColor, fontSize: 20, fontFamily: "Sukar"),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewScreen(
                                parkingLocationId: widget.parkingLocationId)));
                  },
                  child: Text(
                    "Write Review",
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        fontFamily: "Sukar"),
                  ),
                ),
              )
            ],
          ),
          StreamBuilder<ParkingLocation>(
              stream: DatabaseService()
                  .streamParkingLocation(widget.parkingLocationId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                double total = 0;
                for (var feedback in snapshot.data!.feedback) {
                  total += feedback['Rate'];
                }
                double average = total / snapshot.data!.feedback.length;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                average.toStringAsPrecision(2),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: "Sukar"),
                              ),
                              Text(
                                "${snapshot.data?.feedback.length} Reviews",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontFamily: "Sukar"),
                              )
                            ],
                          ),
                          for (int i = 1; i <= 5; i++)
                            if (i <=
                                average
                                    .floor()) // we should replace "4.1" by an average variable to calculate the average rate
                              Icon(
                                Icons.star,
                                size: 35,
                                color: Colors.amber,
                              )
                            else
                              Icon(
                                Icons.star_border,
                                size: 35,
                                color: Colors.amber,
                              )
                        ],
                      ),
                    ),
                    for (var feedback in snapshot.data!.feedback)
                         customer_review(
                          customerName: feedback['User']['name'],
                          feedback: feedback['String'],
                          rate: feedback['Rate'],
                          time: feedback['Time'],
                        ),

                  ],
                );
              }),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          color: kTextColor, fontSize: 25, fontFamily: "Sukar"),
                    ),
                    FutureBuilder<ParkingLocation>(
                      future: DatabaseService()
                          .getParkingLocation(widget.parkingLocationId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        amount = snapshot.data!.pricePerHour * duration() / 60;

                        return Text(
                          "${amount.toStringAsPrecision(2)} BD",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Sukar"),
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await initPaymentSheet(context,
                        email: auth.currentUser!.email,
                        price: (amount * 2.65) * 100);

                    // Reservation reservation = Reservation(amount: amount, startDate: Arriving, finishDate: leaving, location: widget.parkingLocationId, user: auth.currentUser!.uid);
                    // DatabaseService().addReservation(reservation);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      minimumSize: Size(150, 20),
                      primary: Colors.amber,
                      textStyle: TextStyle(fontSize: 26, fontFamily: "Sukar"),
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text("Book"),
                )
              ],
            ),
          )
        ]));
  }

  int duration() {
    int daysDifference = date1.difference(date0).inMinutes;
    int hoursDifference = (time1.hour - time0.hour);
    int minutesDifference = (time1.minute - time0.minute);
    int totalMin = (hoursDifference * 60 + minutesDifference);
    //int minutes = totalMin % 60;
    // int hours = totalMin - minutes;

    return (totalMin + daysDifference); // return duration in minutes ;
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} h';
  }

  Future<void> initPaymentSheet(context,
      {required String? email, required double price}) async {
    try {
      // 1. create payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-ehjez-76528.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': price.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Ehjez',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
            style: ThemeMode.light,
            testEnv: true,
            merchantCountryCode: 'US',
            currencyCode: 'USD'),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed!')),
      );
      Reservation reservation = Reservation(
          amount: amount,
          startDate: Arriving!,
          finishDate: leaving!,
          location: widget.parkingLocationId,
          user: auth.currentUser!.uid);

       await DatabaseService().addReservation(reservation);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentScreen(reservation: reservation,ParkingLocationName: parkingLocationName,)),
      );
    } catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showMyDialog(String alertTitle, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                myDuration = 0;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> getImages(List images,double leftPad , double topPad , double bottomPad,double rightPad){
      List<Widget> wid = [];
    for(var image in images){
      var newImage = Padding(
          padding: EdgeInsets.only(left: leftPad, bottom: bottomPad,top: topPad,right: rightPad),
      child: Image(
        fit: BoxFit.fill,
          image: NetworkImage(image),
          height: 150,
          width: 250)
      );

      wid.add(newImage);

      var sizeBox = SizedBox(width: 40,);
      wid.add(sizeBox);

    }
    return wid;

  }

  double _toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}

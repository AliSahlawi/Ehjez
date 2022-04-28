import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/components/CustomerReview.dart';
import 'package:ehjez/constants.dart';
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/reservation.dart';
import 'package:ehjez/screens/review_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ehjez/models/user.dart' as current_user;
import 'package:flutter/cupertino.dart';
import 'package:ehjez/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TimeOfDay time1 = TimeOfDay.now();

  DateTime? Arriving;
  DateTime? leaving;
  final auth = FirebaseAuth.instance;
  var uid;
  User? _User;
  static const rowSpacer = TableRow(children: [
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    )
  ]);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    var users = Provider.of<List<current_user.User>>(context);
    var locations = Provider.of<List<ParkingLocation>>(context);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking ',
            style: TextStyle(fontSize: 25.0, color: kTextColor,fontFamily: "Sukar"),
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
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 30.0,
                ))
          ],
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.04, left: size.width*0.05),
                      child: Text("Destination",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 26.0,
                              fontFamily: "Sukar"
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
                                          fontFamily: "Sukar"
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.description,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16,fontFamily: "Sukar"),
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
                            textStyle: const TextStyle(fontSize: 20,fontFamily: "Sukar"),
                          ),
                          onPressed: () async {
                            date0 = (await showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022, 3, 1),
                                lastDate: DateTime(2050)
                            ))!;

                            time0 = (await showTimePicker(context: context,
                                initialTime: TimeOfDay.now()))!;


                            Arriving = DateTime(
                                date0.year,
                                date0.month,
                                date0.day,
                                time0.hour,
                                time0.minute
                            );

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
                                    durationToString(duration())
                                        ,style: TextStyle(fontFamily: "Sukar"),
                                ),
                                badgeColor: Colors.amber,
                                shape: BadgeShape.square,
                                borderRadius: BorderRadius.circular(20)
                            ),
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
                            style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Sukar"),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20,fontFamily: "Sukar"),
                          ),
                          onPressed: () async {
                            date1 = (await showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022, 3, 1),
                                lastDate: DateTime(2050)
                            ))!;

                            time1 = (await showTimePicker(context: context,
                                initialTime: TimeOfDay.now()))!;


                            leaving = DateTime(
                                date1.year,
                                date1.month,
                                date1.day,
                                time1.hour,
                                time1.minute
                            );

                            if (leaving != null) {
                              setState(() {
                                time1 = TimeOfDay.fromDateTime(leaving!);
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
                    future: DatabaseService()
                        .getUser(auth.currentUser!.uid),
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
                                      color: Colors.black, fontSize: 20,fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.name,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14,fontFamily: "Sukar"),
                                ),
                              ],
                            ),
                            rowSpacer,
                            TableRow(
                              children: [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20,fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.phoneNum,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14,fontFamily: "Sukar"),
                                ),
                              ],
                            ),
                            rowSpacer,
                            TableRow(
                              children: [
                                Text(
                                  "Plate Number",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20,fontFamily: "Sukar"),
                                ),
                                Text(
                                  snapshot.data!.plateNum,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14,fontFamily: "Sukar"),
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
                            fontSize: 13,fontFamily: "Sukar"),
                      );
                    }),
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
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.05),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 26,
                    color: kTextColor,
                      fontFamily: "Sukar"
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.08 , top: size.height*0.02),
                child: Text(
                  "text text text",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                      fontFamily: "Sukar"
                  ),
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
                      color: kTextColor,
                      fontSize: 20,
                      fontFamily: "Sukar"
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ReviewScreen.id);
                  },
                  child: Text(
                    "Write Review",
                    style: TextStyle(color: Colors.grey,
                        decoration: TextDecoration.underline,fontFamily: "Sukar"),
                  ),
                ),
              )
            ],
          ),
          StreamBuilder<ParkingLocation>(

              stream: DatabaseService().streamParkingLocation(
                  widget.parkingLocationId),
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
                                average.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,fontFamily: "Sukar"
                                )
                                ,),
                              Text(
                                "${snapshot.data?.feedback.length} Reviews",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                    fontFamily: "Sukar"
                                ),
                              )
                            ],
                          ),
                          for(int i = 1; i <= 5; i++)
                            if(i <= average
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

                    for(var feedback in snapshot.data!.feedback)

                      customer_review(customerName: feedback['User']['name'],
                          feedback: feedback['String'],
                          rate: feedback['Rate'],
                        time: feedback['Time'],
                      ),


                  ],
                );
              }
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,

          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15, left: 30, right: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Price",
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 25,fontFamily: "Sukar"
                      ),
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
                              fontSize: 20,fontFamily: "Sukar"
                          ),
                        );
                      },

                    ),


                  ],
                ),
                ElevatedButton(onPressed: () async {

                  await initPaymentSheet(context, email: auth.currentUser!.email, price: (amount * 2.65) * 100 );

                  // Reservation reservation = Reservation(amount: amount, startDate: Arriving, finishDate: leaving, location: widget.parkingLocationId, user: auth.currentUser!.uid);
                  // DatabaseService().addReservation(reservation);
                }, style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(150, 20),
                    primary: Colors.amber,
                    textStyle: TextStyle(fontSize: 26,fontFamily: "Sukar"),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                  child: Text("Book"),)
              ],
            ),
          )
        ]
        )
    );
  }


  int duration() {
    int daysDifference = date1.difference(date0).inMinutes;
    int hoursDifference = (time1.hour - time0.hour).abs();
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
            currencyCode: 'USD'
        ),

      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed!')),
      );
      Reservation reservation  = Reservation(amount: amount, startDate: Arriving!, finishDate: leaving!, location: parkingLocationName, user: auth.currentUser!.uid);


      Navigator.push(context,MaterialPageRoute(
          builder: (context) =>  PaymentScreen(reservation: reservation)
      ),);
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

  createReservation(amount,startDate,finishDate,location,user){

  }




}

// ignore_for_file: prefer_const_constructors

import 'package:ehjez/constants.dart';
import 'package:intl/intl.dart';
import 'package:ehjez/models/reservation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentScreen extends StatelessWidget {
  static String id = 'payment_screen';
  Reservation reservation;
  final String ParkingLocationName;
  PaymentScreen({required this.reservation,required this.ParkingLocationName});



  final userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String arriving = DateFormat.jm().format(reservation.startDate).toString();
    String leaving = DateFormat.jm().format(reservation.finishDate).toString();


    String data = reservation.toString();

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.amber[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: const [
                // IconButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   icon: Icon(
                //     Icons.arrow_back,
                //     color: kTextColor,
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * 0.15,
                // ),
                Text(
                  'Payment success',
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                ),
              ],
            ),
            Container(
              height: size.height * 0.3,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sukar"),
                        ),
                        Text(
                          ParkingLocationName,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sukar"),
                        ),
                        Text(
                          arriving,
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sukar"),
                        ),
                        Text(
                          leaving,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sukar"),
                        ),
                        Badge(
                            badgeContent: Text(
                                '${reservation.amount.toStringAsPrecision(2)} BD'),
                            badgeColor: Colors.amber.shade300,
                            shape: BadgeShape.square,
                            borderRadius: BorderRadius.circular(20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            QrImage(
              data: data,
              size: 220,
            ),
            Text(
              'Scan barcode here',
              style: TextStyle(
                  color: Colors.black, fontFamily: "Sukar", fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}

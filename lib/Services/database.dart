import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/Model/userModel.dart';
import 'package:flutter/material.dart';

class DatabaseService {



  // collection reference
  final CollectionReference reservationCollection = FirebaseFirestore .instance.collection('User');

  // Get Reservation stream



  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await reservationCollection.get();

    // Get data from docs and convert map to
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

}






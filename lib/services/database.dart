

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/user.dart';
import 'package:ehjez/models/reservation.dart';

class DatabaseService {
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference parkingLocationCollection =
      FirebaseFirestore.instance.collection('ParkingLocation');
  final CollectionReference reservationCollection =
      FirebaseFirestore.instance.collection('Reservation');

  Future<List<User>> getUsers() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to
    final users = querySnapshot.docs.map((e) {
      // Now here is where the magic happens.
      // We transform the data in to Parking Location  object.
      final model = User.fromJson(e.data() as DocumentSnapshot);
      // Setting the id value of the Parking Location object.

      return model;
    }).toList();

    return users;
  }

  Future<List<ParkingLocation>> getParkingLocations() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await parkingLocationCollection.get();

    // Get data from docs and convert map to

    // final parkingLocations = querySnapshot.docs.map((doc) => doc.data()).toList();

    final parkingLocations = querySnapshot.docs.map((e) {
      // Now here is where the magic happens.
      // We transform the data in to Parking Location  object.
      final model = ParkingLocation.fromJson(e.data());
      // Setting the id value of the Parking Location object.
      model.id = e.id;
      return model;
    }).toList();

    return parkingLocations;
  }

  Future<List<Reservation>> getReservations() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await reservationCollection.get();
    // Get data from docs and convert map to
    final reservations = querySnapshot.docs.map((e) {
      // Now here is where the magic happens.
      // We transform the data in to Parking Location  object.
      final model = Reservation.fromJson(e.data());
      // Setting the id value of the Parking Location object.
      model.id = e.id;
      return model;
    }).toList();

    return reservations;
  }

  Future<ParkingLocation> getParkingLocation(String parkingLocationId) async {
    DocumentSnapshot documentSnapshot =
        await parkingLocationCollection.doc(parkingLocationId).get();
    ParkingLocation parkingLocation =
        ParkingLocation.fromJson(documentSnapshot.data());
    return parkingLocation;
  }

  Future<User> getUser(String userId) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(userId).get();
    User user = User.fromJson(documentSnapshot);
    return user;
  }

  Future<Reservation> getReservation(String reservationId) async {
    DocumentSnapshot documentSnapshot =
        await reservationCollection.doc(reservationId).get();
    Reservation reservation = Reservation.fromJson(documentSnapshot.data());
    return reservation;
  }

  Stream<ParkingLocation> streamParkingLocation(String id) {
    return parkingLocationCollection
        .doc(id)
        .snapshots()
        .map((snapshot) => ParkingLocation.fromJson(snapshot.data()));
  }

  Stream<List<ParkingLocation>> streamParkingLocations() {
    return parkingLocationCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => ParkingLocation.fromJson(doc)).toList());

  }
  Stream<List<User>> streamUsers() {
    return userCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => User.fromJson(doc)).toList());

  }

  addReservation(Reservation reservation){
    return reservationCollection.add({
      'Amount': reservation.amount,
      'Location':reservation.location,
      'StartDate':reservation.startDate,
      'FinishDate':reservation.finishDate,
      'User':reservation.user
    }).then((value) => print('Reservation added')).catchError((onError)=> print(onError));
  }


}

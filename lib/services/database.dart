import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/models/parking_location.dart';

class DatabaseService {
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference parkingLocationCollection =
      FirebaseFirestore.instance.collection('ParkingLocation');
  final CollectionReference reservationCollection =
      FirebaseFirestore.instance.collection('Reservation');

  Future<dynamic> getUsers() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to
    final users = querySnapshot.docs.map((doc) => doc.data()).toList();

    return users;
  }

  Future<dynamic> getParkingLocations() async {
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



  Future<dynamic> getReservations() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await reservationCollection.get();

    // Get data from docs and convert map to
    final reservations = querySnapshot.docs.map((doc) => doc.data()).toList();

    return reservations;
  }
}

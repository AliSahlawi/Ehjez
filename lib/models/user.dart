import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // late final String _id;
  //
  // String get id => _id;
  //
  // set id(String value) {
  //   _id = value;
  // }

  final String id;

  final String name;
  final String email;
  final String phoneNum;
  final String plateNum;
  final List favorites;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.plateNum,
    required this.favorites
  });

  factory User.fromJson(DocumentSnapshot documentSnapshot) {
    Map jsonObject = documentSnapshot.data() as Map;
    return User(
      id: documentSnapshot.id,
      name: jsonObject['Name'],
      email: jsonObject['Email'],
      phoneNum: jsonObject['PhoneNum'],
      plateNum: jsonObject['PlateNum'],
      favorites: jsonObject['Favorites'],
    );
  }
}

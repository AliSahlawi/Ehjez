class User {
  late final String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  final String name;
  final String email;
  final String phoneNum;
  final String plateNum;

  User({
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.plateNum,
  });

  factory User.fromJson(jsonObject) {
    return User(
      name: jsonObject['Name'],
      email: jsonObject['Email'],
      phoneNum: jsonObject['PhoneNum'],
      plateNum: jsonObject['PlateNum'],
    );
  }
}

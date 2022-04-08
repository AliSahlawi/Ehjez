class Reservation {
  late final String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  final double amount;
  final DateTime  startDate;
  final DateTime finishDate;
  final String location;
  final String user;

  Reservation(
      {required this.amount,
        required this.startDate,
        required this.finishDate,
        required this.location,
        required this.user,
      });

  factory Reservation.fromJson(jsonObject) {
    return Reservation(
      amount: jsonObject['Amount'].toDouble(),
      startDate: jsonObject['StartDate'].toDate(),
      finishDate:jsonObject['FinishDate'].toDate()   ,
      location: jsonObject['Location'] ,
      user: jsonObject['User']
    );
  }
}

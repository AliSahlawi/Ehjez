class ParkingLocation {
  late final String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  final String name;
  final String description;
  final bool available;
  final int capacity;
  final double latitude;
  final double longitude;
  final List feedback;
  final double pricePerHour;
  final int rate;
  final String mainImage;
  final List images;

  ParkingLocation(
      {required this.name,
        required this.description,
        required this.available,
        required this.capacity,
        required this.latitude,
        required this.longitude,
        required this.feedback,
        required this.pricePerHour,
        required this.rate,
        required this.images,
        required this.mainImage});

  factory ParkingLocation.fromJson(jsonObject) {
    return ParkingLocation(
      name: jsonObject['Name'] ,
      description: jsonObject['Description'] ,
      available: jsonObject['Available'] ,
      capacity: jsonObject['Capacity'] ,
      latitude: jsonObject['Latitude'] ,
      longitude: jsonObject['Longitude'],
      feedback: jsonObject['Feedback'],
      pricePerHour: jsonObject['PricePerHour'] ,
      rate: jsonObject['Rate'] ,
      mainImage: jsonObject['MainImage'],
      images: jsonObject['images'],
    );
  }
}
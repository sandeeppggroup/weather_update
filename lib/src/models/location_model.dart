class LocationModel {
  final String city;
  final String country;
  final String district;
  final String state;

  LocationModel({
    required this.city,
    required this.country,
    required this.district,
    required this.state,
  });

  // You might also have a factory method to create a Location from a Map
  // if you're fetching this data from Firebase
  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      district: map['district'] ?? '',
      state: map['state'] ?? '',
    );
  }
}

import '../../imports.dart';

class WeatherModel {
  final String place;
  final String latitude;
  final String longitude;
  WeatherDataModel? weatherData;

  WeatherModel({
    required this.place,
    required this.latitude,
    required this.longitude,
    this.weatherData,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      place: json['place'] as String,
      latitude: json['latitude']?.toString() ?? '0.0',
      longitude: json['longitude']?.toString() ?? '0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

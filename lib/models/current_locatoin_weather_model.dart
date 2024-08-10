class WeatherModel {
  final String place;
  final String latitude;
  final String longitude;
  WeatherData? weatherData;

  WeatherModel({
    required this.place,
    required this.latitude,
    required this.longitude,
    this.weatherData,
  });
}

class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final double feelsLike;
  final int pressure;
  final double visibility;
  final String icon;
  final double uvi;
  final int clouds;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.feelsLike,
    required this.pressure,
    required this.visibility,
    required this.icon,
    required this.uvi,
    required this.clouds,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
      feelsLike: json['main']['feels_like'].toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'].toDouble(),
      icon: json['weather'][0]['icon'],
      uvi: json['current']['uvi'].toDouble(),
      clouds: json['clouds']['all'],
      sunrise:
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
    );
  }
}

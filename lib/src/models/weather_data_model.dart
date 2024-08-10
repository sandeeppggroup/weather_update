class WeatherDataModel {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;

  WeatherDataModel({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

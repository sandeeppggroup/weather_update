import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:newtok_technologies_mt/models/weather_data_model.dart';

class WeatherService {
  static const _apiKey = '0aafdd384ae092133f6e05f46b49e1aa';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherDataModel> getWeatherData(String lat, String lon) async {
    try {
      final url = '$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';

      Dio dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return WeatherDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Error fetching weather data: $e');
    }
  }

  // Future<location> getWeatherDataForLocation(String lat, String lon) async {
  //   final response = await http.get(Uri.parse(
  //       '$baseUrl?lat=$lat&lon=$lon&exclude=minutely,hourly,daily,alerts&units=metric&appid=$apiKey'));

  //   if (response.statusCode == 200) {
  //     return WeatherData.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load weather data');
  //   }
  // }
}

import '../../imports.dart';

class WeatherProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final WeatherService _weatherService = WeatherService();
  List<WeatherModel> _weatherReports = [];
  WeatherModel? _currentLocationWeather;

  List<WeatherModel> get weatherReports => _weatherReports;
  WeatherModel? get currentLocationWeather => _currentLocationWeather;

  Future<void> fetchWeatherReports(List<WeatherModel> locations) async {
    _weatherReports = [];
    for (var location in locations) {
      final weatherData = await _weatherService.getWeatherData(
          location.latitude, location.longitude);
      location.weatherData = weatherData;
      _weatherReports.add(location);
    }
    notifyListeners();
  }

  Future<void> fetchCurrentLocationWeather() async {
    _isLoading = true;
    notifyListeners();
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String? placeName = placemarks.first.locality ?? 'Unknown location';

      final weatherData = await _weatherService.getWeatherData(
        position.latitude.toString(),
        position.longitude.toString(),
      );

      _currentLocationWeather = WeatherModel(
        place: placeName,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        weatherData: weatherData,
      );
      _isLoading = false;
      notifyListeners();

      notifyListeners();
    } catch (e) {
      // print('Error fetching current location weather: $e');
    }
  }
}

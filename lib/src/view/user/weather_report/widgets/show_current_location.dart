import '../../../../../imports.dart';

void showCurrentLocationWeather(BuildContext context) {
  final weatherProvider = context.read<WeatherProvider>();
  final currentLocationWeather = weatherProvider.currentLocationWeather;

  if (currentLocationWeather != null) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.3,
        maxChildSize: 0.35,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Text(
                'Current Location Weather',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 16),
              _buildWeatherDetailRow('Location', currentLocationWeather.place),
              _buildWeatherDetailRow('Temperature',
                  '${currentLocationWeather.weatherData?.temperature.toStringAsFixed(1)}°C'),
              _buildWeatherDetailRow('Humidity',
                  '${currentLocationWeather.weatherData?.humidity}%'),
              _buildWeatherDetailRow('Wind Speed',
                  '${currentLocationWeather.weatherData?.windSpeed.toStringAsFixed(1)} m/s'),
              _buildWeatherDetailRow('Weather',
                  currentLocationWeather.weatherData?.description ?? 'N/A'),
              // Add more weather details as needed
            ],
          ),
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to fetch current location weather')),
    );
  }
}

Widget _buildWeatherDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

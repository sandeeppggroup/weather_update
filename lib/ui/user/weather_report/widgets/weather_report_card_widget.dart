import 'package:flutter/material.dart';
import 'package:newtok_technologies_mt/models/weather_model.dart';

class WeatherReportCardWidget extends StatelessWidget {
  final WeatherModel report;

  const WeatherReportCardWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.place,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            _buildWeatherInfo(
                Icons.thermostat,
                '${report.weatherData?.temperature.toStringAsFixed(1) ?? 'N/A'}°C',
                'Temperature'),
            _buildWeatherInfo(
                Icons.water_drop,
                '${report.weatherData?.humidity.toString() ?? 'N/A'}%',
                'Humidity'),
            _buildWeatherInfo(
                Icons.air,
                '${report.weatherData?.windSpeed.toStringAsFixed(1) ?? 'N/A'} m/s',
                'Wind Speed'),
            _buildWeatherInfo(Icons.cloud,
                report.weatherData?.description ?? 'N/A', 'Weather'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade300),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

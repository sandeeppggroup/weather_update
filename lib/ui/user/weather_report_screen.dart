import 'package:flutter/material.dart';
import 'package:newtok_technologies_mt/models/weather_model.dart';
import 'package:newtok_technologies_mt/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherReportScreen extends StatelessWidget {
  const WeatherReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          'Weather Reports',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: weatherProvider.weatherReports.isEmpty
          ? _buildEmptyState()
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.blue.shade200],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    _buildSummaryCard(weatherProvider),
                    Expanded(
                      child: weatherProvider.weatherReports.isEmpty
                          ? _buildEmptyState()
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: weatherProvider.weatherReports.length,
                              itemBuilder: (context, index) {
                                final report =
                                    weatherProvider.weatherReports[index];
                                return WeatherReportCard(report: report);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<WeatherProvider>().fetchCurrentLocationWeather();
          if (context.mounted) {
            _showCurrentLocationWeather(context);
          }
        },
        child: weatherProvider.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(Icons.my_location),
      ),
    );
  }

  Widget _buildSummaryCard(WeatherProvider weatherProvider) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Weather Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${weatherProvider.weatherReports.length} locations analyzed',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, size: 80, color: Colors.white.withOpacity(0.7)),
          const SizedBox(height: 16),
          const Text(
            'No weather reports available',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Try uploading an Excel file with location data',
            style:
                TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

class WeatherReportCard extends StatelessWidget {
  final WeatherModel report;

  const WeatherReportCard({super.key, required this.report});

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

class DetailedWeatherScreen extends StatelessWidget {
  final WeatherModel report;

  const DetailedWeatherScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.place)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Temperature: ${report.weatherData?.temperature.toStringAsFixed(1)}°C'),
            Text('Humidity: ${report.weatherData?.humidity}%'),
            Text(
                'Wind Speed: ${report.weatherData?.windSpeed.toStringAsFixed(1)} m/s'),
            Text('Weather: ${report.weatherData?.description}'),

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

void _showCurrentLocationWeather(BuildContext context) {
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

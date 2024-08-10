import 'package:flutter/material.dart';
import 'package:newtok_technologies_mt/models/weather_model.dart';
import 'package:newtok_technologies_mt/providers/weather_provider.dart';
import 'package:newtok_technologies_mt/services/excel_service.dart';
import 'package:newtok_technologies_mt/ui/user/weather_report/weather_report_screen.dart';
import 'package:provider/provider.dart';

class UploadExcelScreen extends StatefulWidget {
  const UploadExcelScreen({super.key});

  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  final _excelService = ExcelService();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          'Upload Excel',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.blue.shade200],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfoCard(),
                const SizedBox(height: 32),
                _buildUploadButton(),
                const SizedBox(height: 20),
                _buildNavigateButton(),
                if (_isUploading) ...[
                  const SizedBox(height: 24),
                  _buildProgressIndicator(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.upload_file, size: 64, color: Colors.blue.shade700),
            const SizedBox(height: 16),
            Text(
              'Upload Excel File',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload your Excel file containing location data to fetch weather reports.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: _isUploading ? null : _handleUpload,
      icon: const Icon(Icons.cloud_upload, size: 24),
      label: Text(_isUploading ? 'Uploading...' : 'Upload Excel File',
          style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        overlayColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
      ),
    );
  }

  Widget _buildNavigateButton() {
    return ElevatedButton(
      onPressed: () {
        context.read<WeatherProvider>().weatherReports.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WeatherReportScreen(),
            ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        overlayColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
      ),
      child: const Text('Check weather', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildProgressIndicator() {
    return const Column(
      children: [
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        SizedBox(height: 16),
        Text(
          'Processing data...',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Future<void> _handleUpload() async {
    setState(() => _isUploading = true);
    try {
      final locations = await _excelService.uploadAndParseExcel();

      // Convert locations to List<WeatherModel>
      List<WeatherModel> weatherModels = locations
          .map((location) => WeatherModel(
                place: location.place,
                latitude: location.latitude,
                longitude: location.longitude,
              ))
          .toList();

      // Fetch weather reports for all locations at once
      await context.read<WeatherProvider>().fetchWeatherReports(weatherModels);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WeatherReportScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: ${e.toString()}')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }
}

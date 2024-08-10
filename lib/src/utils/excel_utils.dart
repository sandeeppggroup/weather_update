import 'dart:developer';
import 'package:excel/excel.dart';
import '../../imports.dart';

class ExcelUtils {
  static Future<List<WeatherModel>> readExcelFile(File file) async {
    final excel = await _readExcelFile(file);
    return _parseExcelData(excel);
  }

  static Future<Excel> _readExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    return Excel.decodeBytes(bytes);
  }

  static List<WeatherModel> _parseExcelData(Excel excel) {
    final List<WeatherModel> locations = [];
    final sheet =
        excel.tables.values.isNotEmpty ? excel.tables.values.first : null;

    if (sheet == null) {
      return locations;
    }

    for (var i = 0; i < sheet.rows.length; i++) {}

    for (final row in sheet.rows) {
      // Make sure there are at least 3 columns
      if (row.length >= 3) {
        // Extract and format the values
        final place = row[0]?.value?.toString() ?? '';
        final latitude = row[1]?.value?.toString() ?? '';
        final longitude = row[2]?.value?.toString() ?? '';

        // Add the data to the locations list
        locations.add(
          WeatherModel(place: place, latitude: latitude, longitude: longitude),
        );
        for (final location in locations) {
          log('Location: Place: ${location.place}, Latitude: ${location.latitude}, Longitude: ${location.longitude}');
        }
      } else {
        log('Row does not have enough columns: $row');
      }
    }

    return locations;
  }
}

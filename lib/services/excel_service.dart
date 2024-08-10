import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:newtok_technologies_mt/models/weather_model.dart';
import 'package:newtok_technologies_mt/utils/excel_utils.dart';

class ExcelService {
  Future<List<WeatherModel>> uploadAndParseExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      return await ExcelUtils.readExcelFile(file);
    } else {
      throw Exception('No file selected');
    }
  }
}

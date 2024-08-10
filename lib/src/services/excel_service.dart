import '../../imports.dart';

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

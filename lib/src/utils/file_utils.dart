import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileUtils {
  static Future<void> saveJSONToFile(Map data) async {
    // Convert data to JSON string
    String jsonString = jsonEncode(data);

    // Get directory where user wants to save the file
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      String filePath = '$directoryPath/data.json';

      // Save JSON to a file
      File file = File(filePath);
      await file.writeAsString(jsonString);
    }
  }
}

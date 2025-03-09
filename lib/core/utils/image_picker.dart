import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;
      if (path != null) {
        return File(path);
      } else {
        print('No file path found');
        return null;
      }
    } else {
      print('No file selected');
      return null;
    }
  } catch (e) {
    print('Error picking file: $e');
    return null;
  }
}

extension FilePreview on File {
  String getPreview({int length = 10}) {
    if (!existsSync()) {
      throw FileSystemException("File not found", this.path);
    }

    final file = openSync(mode: FileMode.read);

    final bytes = file.readSync(length);
    file.closeSync();

    String firstChars = utf8.decode(bytes, allowMalformed: true);

    String extension = path.split('.').last;

    return '$firstChars.$extension';
  }
}

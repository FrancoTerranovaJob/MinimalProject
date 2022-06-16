import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:minimal/app/data/files_picker/files_picker.dart';
import 'package:minimal/app/data/files_picker/response/read_jpg_response.dart';

class FilesPickerImpl extends FilesPicker {
  @override
  Future<ReadJpgResponse> readJPG() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
      withData: true,
    );

    if (result != null) {
      return ReadJpgResponse(
          jpg: String.fromCharCodes(result.files.single.bytes!));
    }
    return const ReadJpgResponse();
  }
}
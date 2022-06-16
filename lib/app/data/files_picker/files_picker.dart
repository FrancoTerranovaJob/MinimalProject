import 'package:minimal/app/data/files_picker/response/read_jpg_response.dart';

abstract class FilesPicker {
  Future<ReadJpgResponse> readJPG();
}
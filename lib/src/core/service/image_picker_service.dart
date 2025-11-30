import 'dart:io';

import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class FilePickerService {
  Future<Receipt> pickImage(ImageSource source);

  Future<Receipt> pickFile();
}

@Injectable(as: FilePickerService)
class ImagePickerServiceImpl implements FilePickerService {
  final ImagePicker _imagePicker;
  final FilePicker _filePicker;

  ImagePickerServiceImpl(this._imagePicker, this._filePicker);

  @override
  Future<Receipt> pickImage(ImageSource source) async {
    try {
      final picked = await _imagePicker.pickImage(source: source);

      if (picked == null) {
        throw Exception("No image selected");
      }

      final bytes = await picked.readAsBytes();

      return Receipt(
        name: picked.name,
        image: bytes,
      );
    } catch (e) {
      throw Exception("Failed to pick image: $e");
    }
  }

  @override
  Future<Receipt> pickFile() async {
    try {
      final result = await _filePicker.pickFiles();

      if (result == null) {
        throw Exception("No file selected");
      }

      final file = result.files.single;
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();

      return Receipt(
        name: file.name, // اسم الفايل هنا
        image: bytes,
      );
    } catch (e) {
      throw Exception("Failed to pick file: $e");
    }
  }
}

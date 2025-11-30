import 'package:expense_tracker_lite/src/core/service/image_picker_service.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class FilePickerDatasource {
  Future<Receipt> pickImage(ImageSource source);

  Future<Receipt> pickFile();
}

@Injectable(as: FilePickerDatasource)
class FilePickerDatasourceImpl extends FilePickerDatasource {
  final FilePickerService _service;

  FilePickerDatasourceImpl(this._service);

  @override
  Future<Receipt> pickImage(ImageSource source) async {
    return await _service.pickImage(source);
  }

  @override
  Future<Receipt> pickFile() async {
    return await _service.pickFile();
  }
}

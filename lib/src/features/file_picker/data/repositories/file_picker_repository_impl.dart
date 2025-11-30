import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/core/helper/dartz_handler.dart';
import 'package:expense_tracker_lite/src/features/file_picker/data/datasources/file_picker_datasource.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/repositories/file_picker_repository.dart';
import 'package:image_picker/image_picker.dart' show ImageSource;
import 'package:injectable/injectable.dart';

@Injectable(as: FilePickerRepository)
class FilePickerRepositoryImpl extends FilePickerRepository with DartzHandler {
  final FilePickerDatasource _datasource;

  FilePickerRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Receipt>> pickImage(ImageSource source) {
    return eitherHandler(() => _datasource.pickImage(source));
  }

  @override
  Future<Either<Failure, Receipt>> pickFile() {
    return eitherHandler(() => _datasource.pickFile());
  }
}

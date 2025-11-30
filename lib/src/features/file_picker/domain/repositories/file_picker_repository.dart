import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:image_picker/image_picker.dart';

abstract class FilePickerRepository {
  Future<Either<Failure, Receipt>> pickImage(ImageSource source);

  Future<Either<Failure, Receipt>> pickFile();
}

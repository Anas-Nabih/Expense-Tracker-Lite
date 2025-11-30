import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/repositories/file_picker_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class PickImageUsecase {
  final FilePickerRepository _repository;

  PickImageUsecase(this._repository);

  Future<Either<Failure, Receipt>> call(ImageSource source) async {
    return await _repository.pickImage(source);
  }
}

import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/repositories/file_picker_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PickFileUsecase {
  final FilePickerRepository _repository;

  PickFileUsecase(this._repository);

  Future<Either<Failure, Receipt>> call() async {
    return await _repository.pickFile();
  }
}

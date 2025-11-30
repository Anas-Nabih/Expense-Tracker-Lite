import 'package:bloc/bloc.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
 import 'package:expense_tracker_lite/src/features/file_picker/domain/usecases/pick_file_usecase.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/usecases/pick_image_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';


part 'file_picker_state.dart';

@injectable
class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit(this._pickImageUsecase, this._pickFileUsecase)
      : super(FilePickerInitial());
  final PickImageUsecase _pickImageUsecase;
  final PickFileUsecase _pickFileUsecase;

  Future<void> pickImage() async {
    emit(PickImageLoading());
    final result = await _pickImageUsecase(ImageSource.camera);
    result.fold((failure) {
      emit(PickImageFailure(failure));
    }, (receipt) {
      emit(PickImageSuccess(receipt));
    });
  }

  Future<void> pickFile() async {
    emit(PickFileLoading());
    final result = await _pickFileUsecase();
    result.fold((failure) {
      emit(PickFileFailure(failure));
    }, (path) {
      emit(PickFileSuccess(path));
    });
  }
}

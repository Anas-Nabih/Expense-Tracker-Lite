part of 'file_picker_cubit.dart';

abstract class FilePickerState {
  const FilePickerState();
}

class FilePickerInitial extends FilePickerState {}

class PickImageLoading extends FilePickerState {}

class PickImageSuccess extends FilePickerState {
  final Receipt receipt;

  PickImageSuccess(this.receipt);
}

class PickImageFailure extends FilePickerState {
  final Failure failure;

  PickImageFailure(this.failure);
}

class PickFileLoading extends FilePickerState {}

class PickFileSuccess extends FilePickerState {
  final Receipt receipt;

  PickFileSuccess(this.receipt);
}

class PickFileFailure extends FilePickerState {
  final Failure failure;

  PickFileFailure(this.failure);
}

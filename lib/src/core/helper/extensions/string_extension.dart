extension StrExtension on String {
  bool get isNum => double.tryParse(this) != null;
}

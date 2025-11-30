import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String get toFormattedString {
    return DateFormat('dd MMM yyyy').format(this);
  }
  
  String get toTime {
    return DateFormat('hh:mm a').format(this);
  }
}

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

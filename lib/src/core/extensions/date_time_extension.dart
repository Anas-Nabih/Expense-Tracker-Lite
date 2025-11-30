import 'package:intl/intl.dart';

extension SmartDateTime on DateTime {
  String toSmartString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final time = DateFormat.jm().format(this);

    if (year == today.year && month == today.month && day == today.day) {
      return 'Today $time';
    } else if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day) {
      return 'Yesterday $time';
    } else {
      return '${DateFormat('d MMM y').format(this)} - $time';
    }
  }
}
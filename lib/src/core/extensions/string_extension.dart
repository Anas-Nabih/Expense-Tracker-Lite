import 'package:intl/intl.dart';

extension DateTimeString on String {
  DateTime toDateTimeWithTime({DateTime? time}) {
    final datePart = DateFormat('dd/MM/yyyy').parse(this);
    final t = time ?? DateTime.now();
    return DateTime(
      datePart.year,
      datePart.month,
      datePart.day,
      t.hour,
      t.minute,
      t.second,
    );
  }
}

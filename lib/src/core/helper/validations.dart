import 'package:flutter/material.dart'
    show TextEditingValue, TextSelection, TextEditingController;
import 'package:injectable/injectable.dart';

@injectable
class Validations {
  String? validateEmptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return "Required Field";
    } else {
      return null;
    }
  }

  String? validateDropDownFormField(String? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  String? validateAmount(String? value, {double? min, int decimals = 2}) {
    final empty = validateEmptyValidator(value);
    if (empty != null) return empty;

    final parsed = double.tryParse(value!);
    if (parsed == null) return 'Amount must be a valid number';

    final parts = value.split('.');
    if (parts.length > 1 && parts.last.length > decimals) {
      return 'Max $decimals decimal places';
    }

    if (min != null && parsed < min) {
      return 'Amount must be ≥ ${min.toStringAsFixed(decimals)}';
    }

    return null;
  }

  String? validateDate(String? value) {
    final emptyCheck = validateEmptyValidator(value);
    if (emptyCheck != null) return emptyCheck;

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regex.hasMatch(value!)) {
      return "Invalid date format. Use dd/MM/yyyy";
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        return "Invalid date";
      }
    } catch (_) {
      return "Invalid date";
    }

    return null;
  }

  void formatDateInput(TextEditingController? controller) {
    if (controller == null) return;

    String raw = controller.text.replaceAll('/', '');
    String formatted = '';

    if (raw.length >= 2) {
      formatted += '${raw.substring(0, 2)}/';
      if (raw.length >= 4) {
        formatted += '${raw.substring(2, 4)}/';
        if (raw.length > 4) {
          formatted += raw.substring(4, raw.length);
        }
      } else {
        formatted += raw.substring(2);
      }
    } else {
      formatted = raw;
    }

    if (formatted != controller.text) {
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }
}

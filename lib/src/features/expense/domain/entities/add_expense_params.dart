import 'package:equatable/equatable.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';

class AddExpenseParams extends Equatable {
  final String category;
  final String? amount;
  final String? amountInUsd;
  final String? date;
  final String? currency;
  final Receipt? receipt;

  const AddExpenseParams(
      {this.category = "Groceries",
      this.currency,
      this.amount,
      this.amountInUsd,
      this.date,
      this.receipt});

  AddExpenseParams copyWith(
      {String? category,
      String? amount,
      String? amountInUsd,
      String? date,
      Receipt? receipt,
      String? currency}) {
    return AddExpenseParams(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      amountInUsd: amountInUsd ?? this.amountInUsd,
      date: date ?? this.date,
      receipt: receipt ?? this.receipt,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props =>
      [category, amount, amountInUsd, date, currency, receipt];
}

import 'package:equatable/equatable.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String currency;
  final String? convertedCurrency;
  final double amountInUsd;
  final DateTime date;
  final String category;
  final Receipt? receipt;

  const ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.currency,
    required this.convertedCurrency,
    required this.amountInUsd,
    required this.date,
    required this.category,
    this.receipt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        amount,
        currency,
        convertedCurrency,
        amountInUsd,
        date,
        category,
        receipt,
      ];
}

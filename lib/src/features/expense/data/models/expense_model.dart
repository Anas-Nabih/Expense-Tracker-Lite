import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends ExpenseEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String currency;
  @HiveField(4)
  final double amountInUsd;
  @HiveField(5)
  final DateTime date;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final Receipt? receipt;
  @HiveField(8)
  final String? convertedCurrency;

  const ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.currency,
    required this.convertedCurrency,
    required this.amountInUsd,
    required this.date,
    required this.category,
    this.receipt,
  }) : super(
          id: id,
          title: title,
          amount: amount,
          currency: currency,
          convertedCurrency: convertedCurrency,
          amountInUsd: amountInUsd,
          date: date,
          category: category,
          receipt: receipt,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      convertedCurrency: json['converted_currency'],
      amountInUsd: (json['amountInUsd'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      category: json['category'],
      receipt: json['receiptPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'currency': currency,
      'converted_currency': convertedCurrency,
      'amountInUsd': amountInUsd,
      'date': date.toIso8601String(),
      'category': category,
      'receiptPath': receipt,
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      currency: entity.currency,
      convertedCurrency: entity.convertedCurrency,
      amountInUsd: entity.amountInUsd,
      date: entity.date,
      category: entity.category,
      receipt: entity.receipt,
    );
  }
}

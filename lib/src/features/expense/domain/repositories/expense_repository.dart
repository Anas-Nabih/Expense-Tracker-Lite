import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses({
    required int offset,
    required int limit,
  });

  Future<Either<Failure, void>> addExpense(ExpenseEntity expense);

  Future<Either<Failure, double>> getExchangeRate(String fromCurrency);
}

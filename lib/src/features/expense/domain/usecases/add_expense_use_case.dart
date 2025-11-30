import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<Either<Failure, void>> call(ExpenseEntity expense) {
    return repository.addExpense(expense);
  }
}

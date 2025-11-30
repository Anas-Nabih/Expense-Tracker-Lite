import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPaginatedExpenses {
  final ExpenseRepository repository;

  GetPaginatedExpenses(this.repository);

  Future<Either<Failure, List<ExpenseEntity>>> call({
    required int offset,
    required int limit,
  }) {
    return repository.getExpenses(offset: offset, limit: limit);
  }
}

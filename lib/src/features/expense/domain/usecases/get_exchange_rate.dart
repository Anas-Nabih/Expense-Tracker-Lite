import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExchangeRate {
  final ExpenseRepository repository;

  GetExchangeRate(this.repository);

  Future<Either<Failure, double>> call(String fromCurrency) {
    return repository.getExchangeRate(fromCurrency);
  }
}

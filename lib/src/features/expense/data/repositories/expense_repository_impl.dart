import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/data/datasources/local/expense_local_datasource.dart';
import 'package:expense_tracker_lite/src/features/expense/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:expense_tracker_lite/src/features/expense/data/models/expense_model.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExpenseRepository)
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;
  final ExchangeRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses({
    required int offset,
    required int limit,
  }) async {
    try {
      final expenses = await localDataSource.getExpenses(
        offset: offset,
        limit: limit,
      );
      // Convert ExpenseModel to ExpenseEntity for proper layer separation
      final entities = expenses
          .map((model) => ExpenseEntity(
                id: model.id,
                title: model.title,
                amount: model.amount,
                currency: model.currency,
                convertedCurrency: model.convertedCurrency,
                amountInUsd: model.amountInUsd,
                date: model.date,
                category: model.category,
                receipt: model.receipt,
              ))
          .toList();
      return Right(entities);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense) async {
    try {
      await localDataSource.addExpense(ExpenseModel.fromEntity(expense));
      return const Right(null);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getExchangeRate(String fromCurrency) async {
    try {
      final rate = await remoteDataSource.getExchangeRate(fromCurrency);
      return Right(rate);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

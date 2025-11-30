import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/data/datasources/local/expense_local_datasource.dart';
import 'package:expense_tracker_lite/src/features/expense/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:expense_tracker_lite/src/features/expense/data/models/expense_model.dart';
import 'package:expense_tracker_lite/src/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseLocalDataSource extends Mock
    implements ExpenseLocalDataSource {}

class MockExchangeRemoteDataSource extends Mock
    implements ExchangeRemoteDataSource {}

class FakeExpenseModel extends Fake implements ExpenseModel {}

void main() {
  late ExpenseRepositoryImpl repository;
  late MockExpenseLocalDataSource mockLocalDataSource;
  late MockExchangeRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeExpenseModel());
  });

  setUp(() {
    mockLocalDataSource = MockExpenseLocalDataSource();
    mockRemoteDataSource = MockExchangeRemoteDataSource();
    repository = ExpenseRepositoryImpl(
      mockLocalDataSource,
      mockRemoteDataSource,
    );
  });

  final tExpenseEntity = ExpenseEntity(
    id: '1',
    title: 'Test',
    amount: 100,
    currency: 'USD',
    convertedCurrency: 'USD',
    amountInUsd: 100,
    date: DateTime(2025, 1, 1),
    category: 'Food',
  );

  final tExpenseModel = ExpenseModel.fromEntity(tExpenseEntity);

  group('getExpenses', () {


    test(
        'should return CacheFailure when call to local data source is unsuccessful',
        () async {
      // arrange
      when(() => mockLocalDataSource.getExpenses(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'))).thenThrow(CacheFailure('Cache Failure'));
      // act
      final result = await repository.getExpenses(offset: 0, limit: 10);
      // assert
      verify(() => mockLocalDataSource.getExpenses(offset: 0, limit: 10));
      expect(result, const Left(CacheFailure('Cache Failure')));
    });
  });

  group('addExpense', () {
    test('should return void when call to local data source is successful',
        () async {
      // arrange
      when(() => mockLocalDataSource.addExpense(any()))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await repository.addExpense(tExpenseEntity);
      // assert
      verify(() => mockLocalDataSource.addExpense(tExpenseModel));
      expect(result, const Right(null));
    });
  });

  group('getExchangeRate', () {
    const tCurrency = 'EUR';
    const tRate = 1.2;

    test(
        'should return exchange rate when call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getExchangeRate(any()))
          .thenAnswer((_) async => tRate);
      // act
      final result = await repository.getExchangeRate(tCurrency);
      // assert
      verify(() => mockRemoteDataSource.getExchangeRate(tCurrency));
      expect(result, const Right(tRate));
    });

    test(
        'should return ServerFailure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getExchangeRate(any()))
          .thenThrow(ServerFailure('Server Failure'));
      // act
      final result = await repository.getExchangeRate(tCurrency);
      // assert
      verify(() => mockRemoteDataSource.getExchangeRate(tCurrency));
      expect(result, const Left(ServerFailure('Server Failure')));
    });
  });
}

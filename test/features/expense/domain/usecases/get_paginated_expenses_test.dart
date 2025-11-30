import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/get_paginated_expenses.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late GetPaginatedExpenses usecase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    usecase = GetPaginatedExpenses(mockExpenseRepository);
  });

  final tExpenses = [
    ExpenseEntity(
      id: '1',
      title: 'Test',
      amount: 100,
      currency: 'EGP',
      convertedCurrency: 'USD',
      amountInUsd: 100,
      date: DateTime.now(),
      category: 'Food',
    ),
  ];

  test('should get expenses from the repository', () async {
    // arrange
    when(
      () => mockExpenseRepository.getExpenses(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => Right(tExpenses));
    // act
    final result = await usecase(offset: 0, limit: 10);
    // assert
    expect(result, Right(tExpenses));
    verify(() => mockExpenseRepository.getExpenses(offset: 0, limit: 10));
    verifyNoMoreInteractions(mockExpenseRepository);
  });
}

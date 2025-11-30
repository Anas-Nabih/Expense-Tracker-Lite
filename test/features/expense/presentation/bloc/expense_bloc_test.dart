import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/add_expense_use_case.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/get_paginated_expenses.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPaginatedExpenses extends Mock implements GetPaginatedExpenses {}

class MockAddExpense extends Mock implements AddExpenseUseCase {}

void main() {
  late ExpenseBloc bloc;
  late MockGetPaginatedExpenses mockGetPaginatedExpenses;
  late MockAddExpense mockAddExpense;

  setUp(() {
    mockGetPaginatedExpenses = MockGetPaginatedExpenses();
    mockAddExpense = MockAddExpense();
    bloc = ExpenseBloc(
      mockGetPaginatedExpenses, /* mockAddExpense*/
    );
  });

  final tExpense = ExpenseEntity(
    id: '1',
    title: 'Test',
    amount: 100,
    currency: 'EGP',
    convertedCurrency: 'USD',
    amountInUsd: 100,
    date: DateTime.now(),
    category: 'Food',
  );

  test('initial state should be ExpenseState()', () {
    expect(bloc.state, const ExpenseState());
  });

  blocTest<ExpenseBloc, ExpenseState>(
    'emits [loading, success] when data is gotten successfully',
    build: () {
      when(
        () => mockGetPaginatedExpenses(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Right([tExpense]));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadExpenses()),
    expect: () => [
      const ExpenseState(status: ExpenseStatus.loading),
      ExpenseState(
        status: ExpenseStatus.success,
        allExpenses: [tExpense],
        filteredExpenses: [tExpense], // Filtered by "Today" by default
        hasReachedMax: true,
      ),
    ],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'emits [loading, failure] when getting data fails',
    build: () {
      when(
        () => mockGetPaginatedExpenses(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadExpenses()),
    expect: () => [
      const ExpenseState(status: ExpenseStatus.loading),
      const ExpenseState(
        status: ExpenseStatus.failure,
        errorMessage: 'Server Failure',
      ),
    ],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'emits [success] with appended expenses when LoadMoreExpenses is added',
    build: () {
      when(
        () => mockGetPaginatedExpenses(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Right([tExpense]));
      return bloc;
    },
    seed: () => ExpenseState(
      status: ExpenseStatus.success,
      allExpenses: [tExpense],
      filteredExpenses: [tExpense],
      hasReachedMax: false,
    ),
    act: (bloc) => bloc.add(LoadMoreExpenses()),
    expect: () => [
      ExpenseState(
        status: ExpenseStatus.success,
        allExpenses: [tExpense, tExpense],
        filteredExpenses: [tExpense, tExpense],
        hasReachedMax: true, // 1 < 10
      ),
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/add_expense_params.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/add_expense_use_case.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/get_exchange_rate.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/add_expense/add_expense_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddExpenseUseCase extends Mock implements AddExpenseUseCase {}

class MockGetExchangeRate extends Mock implements GetExchangeRate {}

class FakeExpenseEntity extends Fake implements ExpenseEntity {}

void main() {
  late AddExpenseBloc bloc;
  late MockAddExpenseUseCase mockAddExpenseUseCase;
  late MockGetExchangeRate mockGetExchangeRate;

  setUpAll(() {
    registerFallbackValue(FakeExpenseEntity());
  });

  setUp(() {
    mockAddExpenseUseCase = MockAddExpenseUseCase();
    mockGetExchangeRate = MockGetExchangeRate();
    bloc = AddExpenseBloc(mockAddExpenseUseCase, mockGetExchangeRate);
  });

  tearDown(() {
    bloc.close();
  });

  group('AddExpenseBloc', () {
    test('initial state should be AddExpenseState()', () {
      expect(bloc.state, const AddExpenseState());
    });

    group('LoadExchangeRateEvent', () {
      const tCurrency = 'EUR';
      const tRate = 1.2;
      const tAmount = '100';
      const tAmountInUsd = '120.0'; // 100 * 1.2

      blocTest<AddExpenseBloc, AddExpenseState>(
        'emits [loading, rateExchangedLoaded, loading, success] when exchange rate is loaded and expense is submitted',
        build: () {
          when(() => mockGetExchangeRate(any()))
              .thenAnswer((_) async => const Right(tRate));
          when(() => mockAddExpenseUseCase(any()))
              .thenAnswer((_) async => const Right(null));
          return bloc;
        },
        seed: () => const AddExpenseState(
          params: AddExpenseParams(
            amount: tAmount,
            category: 'Food',
            date: '01/01/2023',
            currency: 'EUR - Euro',
          ),
        ),
        act: (bloc) => bloc.add(const LoadExchangeRateEvent(tCurrency)),
        expect: () => [
          const AddExpenseState(
            status: AddExpenseStatus.loading,
            params: AddExpenseParams(
              amount: tAmount,
              category: 'Food',
              date: '01/01/2023',
              currency: 'EUR - Euro',
            ),
          ),
          AddExpenseState(
            status: AddExpenseStatus.rateExchangedLoaded,
            params: AddExpenseParams(
              amount: tAmount,
              amountInUsd: tAmountInUsd,
              category: 'Food',
              date: '01/01/2023',
              currency: 'EUR - Euro',
            ),
          ),
          AddExpenseState(
            status: AddExpenseStatus.loading,
            params: AddExpenseParams(
              amount: tAmount,
              amountInUsd: tAmountInUsd,
              category: 'Food',
              date: '01/01/2023',
              currency: 'EUR - Euro',
            ),
          ),
          AddExpenseState(
            status: AddExpenseStatus.success,
            params: AddExpenseParams(
              amount: tAmount,
              amountInUsd: tAmountInUsd,
              category: 'Food',
              date: '01/01/2023',
              currency: 'EUR - Euro',
            ),
          ),
        ],
        verify: (_) {
          verify(() => mockGetExchangeRate(tCurrency)).called(1);
          verify(() => mockAddExpenseUseCase(any())).called(1);
        },
      );
    });
  });
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker_lite/src/core/extensions/string_extension.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/add_expense_params.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/add_expense_use_case.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/get_exchange_rate.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

@injectable
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc(this._addExpenseUseCase, this._exchangeRate)
      : super(const AddExpenseState()) {
    on<SubmitExpenseEvent>(_onSubmitExpense);
    on<UpdateExpenseParamsEvent>(_onUpdateParams);
    on<LoadExchangeRateEvent>(_onLoadExchangeRate);
  }

  final AddExpenseUseCase _addExpenseUseCase;
  final GetExchangeRate _exchangeRate;

  Future<void> _onSubmitExpense(
    SubmitExpenseEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(state.copyWith(status: AddExpenseStatus.loading));

    final params = state.params;

    final expense = ExpenseEntity(
        id: const Uuid().v4(),
        title: 'Expense',
        amount: double.parse(params.amount!),
        currency: params.currency?.split(" - ").first ?? "",
        convertedCurrency: "USD",
        amountInUsd: double.parse(params.amountInUsd ?? "0"),
        date: params.date!.toDateTimeWithTime(),
        category: params.category,
        receipt: params.receipt);

    final result = await _addExpenseUseCase(expense);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddExpenseStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(status: AddExpenseStatus.success),
      ),
    );
  }

  Future<void> _onLoadExchangeRate(
    LoadExchangeRateEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(state.copyWith(status: AddExpenseStatus.loading));

    final result = await _exchangeRate(event.fromCurrency);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AddExpenseStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (rate) {
        final amountInUsd =
            (double.tryParse(state.params.amount ?? "0") ?? 0) * rate;

        final updatedParams =
            state.params.copyWith(amountInUsd: amountInUsd.toString());

        emit(
          state.copyWith(
            params: updatedParams,
            status: AddExpenseStatus.rateExchangedLoaded,
          ),
        );
        add(const SubmitExpenseEvent());
      },
    );
  }

  void _onUpdateParams(
    UpdateExpenseParamsEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(state.copyWith(params: event.params));
  }
}

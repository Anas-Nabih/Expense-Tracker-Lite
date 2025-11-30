import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker_lite/src/core/helper/constants.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/usecases/get_paginated_expenses.dart';
import 'package:injectable/injectable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@singleton
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetPaginatedExpenses getPaginatedExpenses;

  ExpenseBloc(this.getPaginatedExpenses) : super(const ExpenseState()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadMoreExpenses>(_onLoadMoreExpenses);
    on<FilterExpensesEvent>(_onFilterExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    if (event.isRefresh) {
      emit(state.copyWith(
        status: ExpenseStatus.loading,
        allExpenses: [],
        filteredExpenses: [],
        hasReachedMax: false,
        errorMessage: null,
      ));
    } else {
      emit(state.copyWith(status: ExpenseStatus.loading));
    }

    final result = await getPaginatedExpenses(
      offset: 0,
      limit: AppConstants.pageSize,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ExpenseStatus.failure,
        errorMessage: failure.message,
      )),
      (expenses) {
        final filteredToday = filterExpenses("Today", expenses);
        emit(state.copyWith(
          status: ExpenseStatus.success,
          allExpenses: expenses,
          filteredExpenses: filteredToday,
          hasReachedMax: expenses.length < AppConstants.pageSize,
        ));
      },
    );
  }

  Future<void> _onLoadMoreExpenses(
    LoadMoreExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    if (state.hasReachedMax) return;

    final result = await getPaginatedExpenses(
      offset: state.allExpenses.length,
      limit: AppConstants.pageSize,
    );

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (newExpenses) {
        if (newExpenses.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          final updatedAll = List.of(state.allExpenses)..addAll(newExpenses);
          final updatedFiltered = List.of(state.filteredExpenses)
            ..addAll(newExpenses);
          emit(state.copyWith(
            allExpenses: updatedAll,
            filteredExpenses: updatedFiltered,
            hasReachedMax: newExpenses.length < AppConstants.pageSize,
          ));
        }
      },
    );
  }

  void _onFilterExpenses(
      FilterExpensesEvent event, Emitter<ExpenseState> emit) {
    final filtered = filterExpenses(event.filter, state.allExpenses);
    emit(state.copyWith(filteredExpenses: filtered));
  }

  List<ExpenseEntity> filterExpenses(
      String filter, List<ExpenseEntity> expenses) {
    final now = DateTime.now();

    switch (filter) {
      case "Today":
        return expenses
            .where((e) =>
                e.date.year == now.year &&
                e.date.month == now.month &&
                e.date.day == now.day)
            .toList();
      case "This week":
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 7));
        return expenses
            .where((e) =>
                e.date
                    .isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
                e.date.isBefore(weekEnd))
            .toList();
      case "This month":
        return expenses
            .where((e) => e.date.year == now.year && e.date.month == now.month)
            .toList();
      case "This year":
        return expenses.where((e) => e.date.year == now.year).toList();
      case "All time":
      default:
        return List.of(expenses);
    }
  }
}

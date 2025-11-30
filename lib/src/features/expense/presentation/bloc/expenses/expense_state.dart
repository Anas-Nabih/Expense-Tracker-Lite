part of 'expense_bloc.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState extends Equatable {
  final ExpenseStatus status;
  final List<ExpenseEntity> allExpenses;
  final List<ExpenseEntity> filteredExpenses;
  final bool hasReachedMax;
  final String? errorMessage;

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.allExpenses = const [],
    this.filteredExpenses = const [],
    this.hasReachedMax = false,
    this.errorMessage,
  });

  static const double income = 20000;

  double get totalExpenses =>
      allExpenses.fold(0.0, (sum, item) => sum + item.amount);

  double get totalBalance => income - totalExpenses;

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseEntity>? allExpenses,
    List<ExpenseEntity>? filteredExpenses,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      allExpenses: allExpenses ?? this.allExpenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, allExpenses, filteredExpenses, hasReachedMax, errorMessage];
}


part of 'expense_bloc.dart';


abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenses extends ExpenseEvent {
  final bool isRefresh;

  const LoadExpenses({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class FilterExpensesEvent extends ExpenseEvent {
  final String filter;

  const FilterExpensesEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class LoadMoreExpenses extends ExpenseEvent {}


part of 'add_expense_bloc.dart';

abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();

  @override
  List<Object> get props => [];
}

class UpdateExpenseParamsEvent extends AddExpenseEvent {
  final AddExpenseParams params;

  const UpdateExpenseParamsEvent(this.params);

  @override
  List<Object> get props => [params];
}

class LoadExchangeRateEvent extends AddExpenseEvent {
  final String fromCurrency;

  const LoadExchangeRateEvent(this.fromCurrency);
}

class SubmitExpenseEvent extends AddExpenseEvent {
  const SubmitExpenseEvent();

  @override
  List<Object> get props => [];
}


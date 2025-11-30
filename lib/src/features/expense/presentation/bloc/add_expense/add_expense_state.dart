part of 'add_expense_bloc.dart';

enum AddExpenseStatus { initial, loading, success,rateExchangedLoaded, failure }

class AddExpenseState extends Equatable {
  final AddExpenseStatus status;
  final String? errorMessage;
  final AddExpenseParams params;

  const AddExpenseState({
    this.status = AddExpenseStatus.initial,
    this.errorMessage,
    this.params = const AddExpenseParams(),
  });

  AddExpenseState copyWith({
    AddExpenseStatus? status,
    String? errorMessage,
    AddExpenseParams? params,
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      params: params ?? this.params,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, params];
}


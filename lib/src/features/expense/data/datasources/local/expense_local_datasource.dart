import 'package:expense_tracker_lite/src/core/error/failures.dart';
import 'package:expense_tracker_lite/src/core/helper/constants.dart';
import 'package:expense_tracker_lite/src/features/expense/data/models/expense_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getExpenses({
    required int offset,
    required int limit,
  });

  Future<void> addExpense(ExpenseModel expense);
}

@Injectable(as: ExpenseLocalDataSource)
class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<ExpenseModel> expenseBox;

  ExpenseLocalDataSourceImpl(@Named(AppConstants.expenseBox) this.expenseBox);

  @override
  Future<List<ExpenseModel>> getExpenses({
    required int offset,
    required int limit,
  }) async {
    try {
       final expenses = expenseBox.values.toList();
      expenses.sort((a, b) => b.date.compareTo(a.date));
      if (offset >= expenses.length) {
        return [];
      }

      final end =
          (offset + limit < expenses.length) ? offset + limit : expenses.length;
      return expenses.sublist(offset, end);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await expenseBox.put(expense.id, expense);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }
}

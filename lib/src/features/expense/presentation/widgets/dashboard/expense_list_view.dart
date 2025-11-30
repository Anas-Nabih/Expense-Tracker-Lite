import 'package:expense_tracker_lite/src/core/widgets/skeleton_loader_list.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        buildWhen: (previous, current) => current != previous,
        builder: (context, state) {
          final expenses = state.filteredExpenses;

          if (state.status == ExpenseStatus.loading && expenses.isEmpty) {
            return const SkeletonLoaderList();
          }

          if (state.status == ExpenseStatus.failure && expenses.isEmpty) {
            return Center(
              child: Text(state.errorMessage ?? 'Error loading expenses'),
            );
          }

          if (expenses.isEmpty) {
            return const Center(child: Text('No expenses yet'));
          }

          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount:
                state.hasReachedMax ? expenses.length : expenses.length + 1,
            itemBuilder: (context, index) {
               if (index >= expenses.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return ExpenseCard(expense: expenses[index]);
            },
          );
        },
      ),
    );
  }
}

import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/balance_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBalanceSummery extends StatelessWidget {
  const CardBalanceSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      buildWhen: (previous, current) =>
          previous.allExpenses != current.allExpenses,
      builder: (context, state) {
        const double income = ExpenseState.income;

        final totalBalance = state.totalBalance;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Total Balance',
                    style: AppStyles.styleSemiBold20(context)
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 15.r,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                '\$${totalBalance.toStringAsFixed(2)}',
                style: AppStyles.styleBold26(context)
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalanceSummary(
                    label: 'Income',
                    amount: income.toStringAsFixed(2),
                    icon: Icons.arrow_downward,
                  ),
                  Builder(
                    builder: (context) {
                      final expenses = context.select(
                          (ExpenseBloc bloc) => bloc.state.totalExpenses);
                      return BalanceSummary(
                        label: 'Expenses',
                        amount: expenses.toStringAsFixed(2),
                        icon: Icons.arrow_upward,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

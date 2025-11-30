import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_drop_down_form_field.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/card_balance_summery.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/welcome_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["Today", "This week", "This month", "This year", "All time"];
    return Container(
      height: 320.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          )),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WelcomeUser(
                      name: "Anas Nabih",
                      image: 'https://i.pravatar.cc/150?img=12'),
                  SizedBox(
                    height: 40.h,
                    width: 120.w,
                    child: CustomDropDownFormField(
                      items: items,
                      value: items.first,
                      onSelected: (filter) => context
                          .read<ExpenseBloc>()
                          .add(FilterExpensesEvent(filter!)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
          Positioned(
            bottom: -50.h,
            left: 0,
            right: 0,
            child: const CardBalanceSummery(),
          )
        ],
      ),
    );
  }
}

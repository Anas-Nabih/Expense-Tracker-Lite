import 'package:expense_tracker_lite/src/core/extensions/category_extension.dart';
import 'package:expense_tracker_lite/src/core/extensions/date_time_extension.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_svg.dart';
import 'package:expense_tracker_lite/src/features/categories/domain/enums/expense_category_enum.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseEntity expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final category = ExpenseCategory.values
        .firstWhere(
          (e) => e.data.name == expense.category ||
              e.data.name == "Add ${expense.category}",
        )
        .data;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 25.r,
            backgroundColor: category.iconColor.withValues(alpha: 0.15),
            child: CustomSvg(
              path: category.iconPath,
              color: category.iconColor,
              height: 25.r,
              width: 25.r,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.category,
                    style: AppStyles.styleSemiBold20(context)),
                SizedBox(height: 4.h),
                Text(
                  "Manually",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-\$${expense.amountInUsd.toStringAsFixed(2)}',
                style: AppStyles.styleBold18(context),
              ),
              SizedBox(height: 4.h),
              Text(
                expense.date.toSmartString(),
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black.withValues(alpha: .65)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

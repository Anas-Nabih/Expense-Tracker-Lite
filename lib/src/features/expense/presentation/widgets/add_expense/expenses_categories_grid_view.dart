import 'package:expense_tracker_lite/src/features/categories/domain/entities/category.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/add_expense/category_grid_item.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesCategoriesGridView extends StatelessWidget {
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const ExpensesCategoriesGridView({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.0,
      ),
      itemCount: expensesCategories.length,
      itemBuilder: (context, index) {
        final category = expensesCategories[index];
        final isSelected = category.name == selectedCategory;
        return CategoryGridItem(
            onTapped: () => onCategorySelected(category.name),
            isSelected: isSelected,
            category: expensesCategories[index]);
      },
    );
  }
}

import 'package:expense_tracker_lite/src/core/theme/app_colors.dart' show AppColors;
import 'package:expense_tracker_lite/src/features/categories/domain/entities/category.dart';
import 'package:expense_tracker_lite/src/features/categories/domain/enums/expense_category_enum.dart';
import 'package:expense_tracker_lite/src/gen/assets.gen.dart';
import 'package:flutter/material.dart';

extension ExpenseCategoryX on ExpenseCategory {
  Category get data {
    switch (this) {
      case ExpenseCategory.groceries:
        return Category(name: 'Groceries', iconPath: Assets.images.icCart, iconColor: AppColors.primaryColor);
      case ExpenseCategory.entertainment:
        return Category(name: 'Entertainment', iconPath: Assets.images.icGames, iconColor: Colors.green);
      case ExpenseCategory.gas:
        return Category(name: 'Gas', iconPath: Assets.images.icGas, iconColor: Colors.red);
      case ExpenseCategory.shopping:
        return Category(name: 'Shopping', iconPath: Assets.images.icShopping, iconColor: Colors.amber);
      case ExpenseCategory.news:
        return Category(name: 'News Paper', iconPath: Assets.images.icNews, iconColor: Colors.cyan);
      case ExpenseCategory.transport:
        return Category(name: 'Transport', iconPath: Assets.images.icTransport, iconColor: Colors.purpleAccent);
      case ExpenseCategory.rent:
        return Category(name: 'Rent', iconPath: Assets.images.icRent, iconColor: Colors.indigo);
      case ExpenseCategory.other:
        return Category(name: 'other', iconPath: Assets.images.icCart, iconColor: Colors.deepOrange);
    }

  }
}
import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final String iconPath;
  final Color iconColor;

  Category({required this.iconColor, required this.name, required this.iconPath});
}

final List<Category> expensesCategories = [
  Category(
      name: 'Groceries',
      iconPath: Assets.images.icCart,
      iconColor: AppColors.primaryColor),
  Category(
    name: 'Entertainment',
    iconPath: Assets.images.icGames,
    iconColor: Colors.green
  ),
  Category(name: 'Gas', iconPath: Assets.images.icGas, iconColor: Colors.red),
  Category(
      name: 'Shopping',
      iconPath: Assets.images.icShopping,
      iconColor: Colors.amber),
  Category(
      name: 'News Paper',
      iconPath: Assets.images.icNews,
      iconColor: Colors.cyan),
  Category(
      name: 'Transport',
      iconPath: Assets.images.icTransport,
      iconColor: Colors.purpleAccent),
  Category(
      name: 'Rent', iconPath: Assets.images.icRent,
      iconColor: Colors.indigo),
  Category(name: 'other', iconPath: Assets.images.icCart,
  iconColor: Colors.deepOrange)
];

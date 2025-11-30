import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_svg.dart';
import 'package:expense_tracker_lite/src/features/categories/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key,
      required this.onTapped,
      required this.isSelected,
      required this.category});

  final Function() onTapped;
  final bool isSelected;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryIcon(),
          SizedBox(height: 8.h),
          Text(
            category.name == "other" ? "Add other":category.name ,
            style: AppStyles.styleMedium14(context).copyWith(
              overflow: TextOverflow.ellipsis,
              color: isSelected ? AppColors.primaryColor : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon() {
    if (category.name == "other") {
      return CircleAvatar(
        maxRadius: 23.r,
        backgroundColor: AppColors.primaryColor,
        child: CircleAvatar(
          maxRadius: 22.r,
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          child: Icon(
            Icons.add,
            color: isSelected ? Colors.white : AppColors.primaryColor,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: isSelected
            ? AppColors.primaryColor
            : category.iconColor.withValues(alpha: 0.15),
        child: CustomSvg(
          path: category.iconPath,
          color: isSelected ? Colors.white : category.iconColor,
          height: 20,
          width: 20,
        ),
      );
    }
  }
}

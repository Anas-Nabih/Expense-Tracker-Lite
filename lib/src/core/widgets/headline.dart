import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Headline extends StatelessWidget {
  const Headline({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyles.styleSemiBold24(context),
          ),
          const Spacer(),
          Text(
            "See all",
            style: AppStyles.styleMedium16(context),
          )
        ],
      ),
    );
  }
}

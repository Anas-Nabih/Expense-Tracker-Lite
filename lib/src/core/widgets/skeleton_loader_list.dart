import 'package:expense_tracker_lite/src/core/widgets/skeleton_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoaderList extends StatelessWidget {
  const SkeletonLoaderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: const SkeletonItem(width: double.infinity, height: 80),
          ),
        ),
      ),
    );
  }
}

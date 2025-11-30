import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceSummary extends StatelessWidget {
  const BalanceSummary(
      {super.key,
      required this.label,
      required this.amount,
      required this.icon});

  final String label;
  final String amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              maxRadius: 15.r,
              backgroundColor: Colors.white.withValues(alpha: .2),
              child: Icon(icon, color: Colors.white, size: 16.sp),
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              label,
              style: AppStyles.styleRegular22(context)
                  .copyWith(color: Colors.white ),
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 3.w),
          child: Text(
            "\$$amount",
            style: AppStyles.styleBold22(context).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

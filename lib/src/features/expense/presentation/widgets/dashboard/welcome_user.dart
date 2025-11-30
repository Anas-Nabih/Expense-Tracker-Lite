import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundImage:   NetworkImage(
            image,
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: AppStyles.styleRegular16(context)
                  .copyWith(color: Colors.white),
            ),
            Text(
              name,
              style: AppStyles.styleSemiBold20(context)
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveScale {
  // Design size from Dribbble (iPhone 11 Pro / X usually 375x812)
  static const Size designSize = Size(375, 812);

  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  static double width(double w) => w.w;
  static double height(double h) => h.h;
  static double sp(double s) => s.sp;
  static double radius(double r) => r.r;
}

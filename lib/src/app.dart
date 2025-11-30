import 'package:expense_tracker_lite/src/core/helper/responsive_scale.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ResponsiveScale.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "Expense Tracker Lite",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[50],
            useMaterial3: true,
          ),
          home: const DashboardPage(),
        );
      },
    );
  }
}

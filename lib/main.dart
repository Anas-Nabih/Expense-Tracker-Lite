import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker_lite/src/app.dart';
import 'package:expense_tracker_lite/src/core/helper/app_bloc_observer.dart';
import 'package:expense_tracker_lite/src/core/service_locator/dependency_injection.dart';
import 'package:expense_tracker_lite/src/features/expense/data/models/expense_model.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
  import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(ReceiptAdapter());

  await configureDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

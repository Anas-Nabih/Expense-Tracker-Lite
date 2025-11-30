import 'package:dio/dio.dart';
import 'package:expense_tracker_lite/src/core/networking/header_interceptor.dart';
import 'package:expense_tracker_lite/src/core/helper/constants.dart';
import 'package:expense_tracker_lite/src/features/expense/data/models/expense_model.dart';
 import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../networking/response_validation_interceptor.dart'
    show ResponseValidationInterceptor;
import 'dependency_injection.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<GetIt> configureDependencies() async => await sl.init();

@module
abstract class DioModule {
  Dio get dio => Dio()
    ..interceptors
        .addAll([HeaderInterceptor(), ResponseValidationInterceptor()]);
}

@module
abstract class RegisterModule {
  @preResolve
  @Named(AppConstants.expenseBox)
  Future<Box<ExpenseModel>> get expenseBox async {
    return await Hive.openBox<ExpenseModel>(AppConstants.expenseBox);
  }
}

@module
abstract class ImagePickerModule {
  ImagePicker get imagePickerService => ImagePicker();
}

@module
abstract class FilePickerModule {
  FilePicker get filePicker => FilePicker.platform;
}

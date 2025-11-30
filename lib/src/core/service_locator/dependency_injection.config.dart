// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:file_picker/file_picker.dart' as _i388;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/expense/data/datasources/local/expense_local_datasource.dart'
    as _i104;
import '../../features/expense/data/datasources/remote/exchange_remote_datasource.dart'
    as _i346;
import '../../features/expense/data/models/expense_model.dart' as _i164;
import '../../features/expense/data/repositories/expense_repository_impl.dart'
    as _i587;
import '../../features/expense/domain/repositories/expense_repository.dart'
    as _i31;
import '../../features/expense/domain/usecases/add_expense_use_case.dart'
    as _i367;
import '../../features/expense/domain/usecases/get_exchange_rate.dart' as _i468;
import '../../features/expense/domain/usecases/get_paginated_expenses.dart'
    as _i252;
import '../../features/expense/presentation/bloc/add_expense/add_expense_bloc.dart'
    as _i72;
import '../../features/expense/presentation/bloc/expenses/expense_bloc.dart'
    as _i1067;
import '../../features/file_picker/data/datasources/file_picker_datasource.dart'
    as _i674;
import '../../features/file_picker/data/repositories/file_picker_repository_impl.dart'
    as _i31;
import '../../features/file_picker/domain/repositories/file_picker_repository.dart'
    as _i169;
import '../../features/file_picker/domain/usecases/pick_file_usecase.dart'
    as _i2;
import '../../features/file_picker/domain/usecases/pick_image_usecase.dart'
    as _i972;
import '../../features/file_picker/presentation/cubit/file_picker_cubit.dart'
    as _i190;
import '../helper/validations.dart' as _i589;
import '../service/image_picker_service.dart' as _i353;
import '../service/network_service.dart' as _i724;
import 'dependency_injection.dart' as _i9;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final imagePickerModule = _$ImagePickerModule();
    final filePickerModule = _$FilePickerModule();
    final registerModule = _$RegisterModule();
    gh.factory<_i589.Validations>(() => _i589.Validations());
    gh.factory<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i183.ImagePicker>(() => imagePickerModule.imagePickerService);
    gh.factory<_i388.FilePicker>(() => filePickerModule.filePicker);
    gh.factory<_i724.NetworkService>(() => _i724.DioService(gh<_i361.Dio>()));
    await gh.factoryAsync<_i979.Box<_i164.ExpenseModel>>(
      () => registerModule.expenseBox,
      instanceName: 'expenses_box',
      preResolve: true,
    );
    gh.factory<_i104.ExpenseLocalDataSource>(() =>
        _i104.ExpenseLocalDataSourceImpl(
            gh<_i979.Box<_i164.ExpenseModel>>(instanceName: 'expenses_box')));
    gh.factory<_i346.ExchangeRemoteDataSource>(
        () => _i346.ExchangeRemoteDataSourceImpl(gh<_i724.NetworkService>()));
    gh.factory<_i353.FilePickerService>(() => _i353.ImagePickerServiceImpl(
          gh<_i183.ImagePicker>(),
          gh<_i388.FilePicker>(),
        ));
    gh.factory<_i674.FilePickerDatasource>(
        () => _i674.FilePickerDatasourceImpl(gh<_i353.FilePickerService>()));
    gh.factory<_i169.FilePickerRepository>(
        () => _i31.FilePickerRepositoryImpl(gh<_i674.FilePickerDatasource>()));
    gh.factory<_i31.ExpenseRepository>(() => _i587.ExpenseRepositoryImpl(
          gh<_i104.ExpenseLocalDataSource>(),
          gh<_i346.ExchangeRemoteDataSource>(),
        ));
    gh.factory<_i367.AddExpenseUseCase>(
        () => _i367.AddExpenseUseCase(gh<_i31.ExpenseRepository>()));
    gh.factory<_i468.GetExchangeRate>(
        () => _i468.GetExchangeRate(gh<_i31.ExpenseRepository>()));
    gh.factory<_i252.GetPaginatedExpenses>(
        () => _i252.GetPaginatedExpenses(gh<_i31.ExpenseRepository>()));
    gh.singleton<_i1067.ExpenseBloc>(
        () => _i1067.ExpenseBloc(gh<_i252.GetPaginatedExpenses>()));
    gh.factory<_i2.PickFileUsecase>(
        () => _i2.PickFileUsecase(gh<_i169.FilePickerRepository>()));
    gh.factory<_i972.PickImageUsecase>(
        () => _i972.PickImageUsecase(gh<_i169.FilePickerRepository>()));
    gh.factory<_i190.FilePickerCubit>(() => _i190.FilePickerCubit(
          gh<_i972.PickImageUsecase>(),
          gh<_i2.PickFileUsecase>(),
        ));
    gh.factory<_i72.AddExpenseBloc>(() => _i72.AddExpenseBloc(
          gh<_i367.AddExpenseUseCase>(),
          gh<_i468.GetExchangeRate>(),
        ));
    return this;
  }
}

class _$DioModule extends _i9.DioModule {}

class _$ImagePickerModule extends _i9.ImagePickerModule {}

class _$FilePickerModule extends _i9.FilePickerModule {}

class _$RegisterModule extends _i9.RegisterModule {}

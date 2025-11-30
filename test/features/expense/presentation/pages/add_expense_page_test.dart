import 'package:expense_tracker_lite/src/core/helper/validations.dart';
import 'package:expense_tracker_lite/src/features/expense/domain/entities/add_expense_params.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/add_expense/add_expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker_lite/src/features/file_picker/presentation/cubit/file_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAddExpenseBloc extends Mock implements AddExpenseBloc {}

class MockExpenseBloc extends Mock implements ExpenseBloc {}

class MockFilePickerCubit extends Mock implements FilePickerCubit {}

class MockValidations extends Mock implements Validations {}

void main() {
  late MockAddExpenseBloc mockAddExpenseBloc;
  late MockExpenseBloc mockExpenseBloc;
  late MockFilePickerCubit mockFilePickerCubit;
  late MockValidations mockValidations;

  setUp(() {
    mockAddExpenseBloc = MockAddExpenseBloc();
    mockExpenseBloc = MockExpenseBloc();
    mockFilePickerCubit = MockFilePickerCubit();
    mockValidations = MockValidations();

    final getIt = GetIt.instance;
    getIt.reset();
    getIt.registerSingleton<AddExpenseBloc>(mockAddExpenseBloc);
    getIt.registerSingleton<ExpenseBloc>(mockExpenseBloc);
    getIt.registerSingleton<FilePickerCubit>(mockFilePickerCubit);
    getIt.registerSingleton<Validations>(mockValidations);

    when(() => mockAddExpenseBloc.state).thenReturn(const AddExpenseState());
    when(() => mockAddExpenseBloc.stream)
        .thenAnswer((_) => Stream.value(const AddExpenseState()));
    when(() => mockAddExpenseBloc.close()).thenAnswer((_) async {});

    when(() => mockFilePickerCubit.state).thenReturn(FilePickerInitial());
    when(() => mockFilePickerCubit.stream)
        .thenAnswer((_) => Stream.value(FilePickerInitial()));
    when(() => mockFilePickerCubit.close()).thenAnswer((_) async {});

    // Mock validation methods
    when(() => mockValidations.validateEmptyValidator(any())).thenReturn(null);
    when(() => mockValidations.validateAmount(any())).thenReturn(null);
    when(() => mockValidations.validateDate(any())).thenReturn(null);
  });

  testWidgets('AddExpensePage renders correctly', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: AddExpensePage(),
        ),
      ),
    );

    expect(find.text('Add Expense'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}

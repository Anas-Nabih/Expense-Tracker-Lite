import 'package:expense_tracker_lite/src/core/service_locator/dependency_injection.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:expense_tracker_lite/src/core/ui_utils/toast.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_app_bar.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_button.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/add_expense/add_expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/add_expense/add_expense_form.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/add_expense/expenses_categories_grid_view.dart';
import 'package:expense_tracker_lite/src/features/file_picker/presentation/cubit/file_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bloc = sl<AddExpenseBloc>();
  final filePickerCubit = sl<FilePickerCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Add Expense',
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<AddExpenseBloc, AddExpenseState>(
          listener: (context, state) {
            if (state.status == AddExpenseStatus.success) {
              sl<ExpenseBloc>().add(const LoadExpenses(isRefresh: true));
              Navigator.pop(context);
              showSuccess("Expense Added Successfully");
            }

            if (state.status == AddExpenseStatus.failure) {
              if (state.errorMessage != null) {
                showToast(state.errorMessage!);
              }
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddExpenseForm(formKey: _formKey),
                SizedBox(height: 30.h),
                Text(
                  'Categories',
                  style: AppStyles.styleSemiBold24(context),
                ),
                SizedBox(height: 10.h),
                BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
                  selector: (st) => st.params.category,
                  builder: (_, category) => ExpensesCategoriesGridView(
                    selectedCategory: category,
                    onCategorySelected: (cat) => bloc.add(
                      UpdateExpenseParamsEvent(
                        bloc.state.params.copyWith(category: cat),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 20.h, left: 20.h, bottom: 10.h),
        child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) => CustomButton(
            label: "Save",
            isLoading: state.status == AddExpenseStatus.loading,
            onTapped: state.status != AddExpenseStatus.loading
                ? () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    bloc.add(
                        LoadExchangeRateEvent(bloc.state.params.currency!));
                    // bloc.add(const SubmitExpenseEvent());
                  }
                : null,
          ),
        ),
      ),
    );
  }
}

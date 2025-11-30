import 'package:expense_tracker_lite/src/core/service_locator/dependency_injection.dart';
import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/widgets/headline.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/expenses/expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/dashboard_header.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/widgets/dashboard/expense_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scrollController = ScrollController();
  final bloc = sl<ExpenseBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    bloc.add(const LoadExpenses());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      bloc.add(LoadMoreExpenses());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocProvider.value(
        value: bloc,
        child: Column(
          children: [
            const DashboardHeader(),
            SizedBox(
              height: 80.h,
            ),
            const Headline(label: "Recent Expense"),
            SizedBox(
              height: 20.h,
            ),
            ExpenseListView(scrollController: _scrollController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddExpensePage())),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

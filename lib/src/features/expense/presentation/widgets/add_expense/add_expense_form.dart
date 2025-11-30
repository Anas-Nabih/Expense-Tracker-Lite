import 'package:expense_tracker_lite/gen/assets.gen.dart';
import 'package:expense_tracker_lite/src/core/helper/validations.dart';
import 'package:expense_tracker_lite/src/core/service_locator/dependency_injection.dart';
import 'package:expense_tracker_lite/src/core/ui_utils/show_custom_date_picker.dart';
import 'package:expense_tracker_lite/src/core/ui_utils/toast.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_drop_down_form_field.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_svg.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_text_form_field.dart';
import 'package:expense_tracker_lite/src/core/widgets/show_image_picker_dialog.dart';
import 'package:expense_tracker_lite/src/features/expense/presentation/bloc/add_expense/add_expense_bloc.dart';
import 'package:expense_tracker_lite/src/features/file_picker/domain/entities/receipt.dart';
import 'package:expense_tracker_lite/src/features/file_picker/presentation/cubit/file_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  late AddExpenseBloc bloc;
  final _dateController = TextEditingController();

   final filePickerCubit = sl<FilePickerCubit>();

  final List<String> currencies = [
    "EGP - Egyptian Pound",
    "SAR - Saudi Riyal",
    "AED - UAE Dirham",
    "KWD - Kuwaiti Dinar",
    "QAR - Qatari Riyal",
    "USD - US Dollar",
    "EUR - Euro",
    "GBP - British Pound",
    "JPY - Japanese Yen",
    "AUD - Australian Dollar",
    "CAD - Canadian Dollar",
    "CHF - Swiss Franc",
  ];

  @override
  void initState() {
    super.initState();
    bloc = context.read<AddExpenseBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
            selector: (st) => st.params.currency,
            builder: (_, currency) => CustomDropDownFormField(
              label: "Currency",
              hintText: 'Select Currency',
              value: currency,
              items: currencies,
              onSelected: (val) => bloc.add(
                UpdateExpenseParamsEvent(
                  bloc.state.params.copyWith(currency: val!),
                ),
              ),
              validator: sl<Validations>().validateDropDownFormField,
            ),
          ),
          BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
            selector: (st) => st.params.amount,
            builder: (_, amount) => CustomTextFormField(
              label: "Amount",
              hintText: "50,000",
              inputType: TextInputType.number,
              initialValue: amount,
              onChanged: (val) => bloc.add(
                UpdateExpenseParamsEvent(
                  bloc.state.params.copyWith(amount: val),
                ),
              ),
              validator: (v) => sl<Validations>().validateAmount(v, min: 1),
            ),
          ),
          BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
            selector: (st) => st.params.date,
            builder: (context, date) => CustomTextFormField(
              label: "Date",
              hintText: "02/01/2026",
              controller: _dateController,
              onChanged: (val) {
                sl<Validations>().formatDateInput(_dateController);
                if (val.length == 8) {
                  final formatted =
                      '${val.substring(0, 2)}/${val.substring(2, 4)}/${val.substring(4, 8)}';
                  _dateController.text = formatted;
                  bloc.add(
                    UpdateExpenseParamsEvent(
                      bloc.state.params.copyWith(date: formatted),
                    ),
                  );
                }
              },
              validator: sl<Validations>().validateDate,
              inputType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              suffixIcon: CustomSvg(
                path: Assets.images.icCalendar,
                color: Colors.black87,
                width: 15,
                height: 15,
              ),
              onSuffixIconTapped: () async {
                final picked = await showCustomDatePicker(context: context);
                if (picked != null) {
                  _dateController.text =
                      DateFormat("dd/MM/yyyy").format(picked);
                  bloc.add(
                    UpdateExpenseParamsEvent(
                      bloc.state.params.copyWith(date: _dateController.text),
                    ),
                  );
                }
              },
              textInputAction: TextInputAction.done,
            ),
          ),
          BlocListener<FilePickerCubit, FilePickerState>(
            bloc: filePickerCubit,
            listener: (context, state) {
              if (state is PickImageFailure) {
                showToast(state.failure.message);
              }

              if (state is PickImageSuccess) {
                bloc.add(
                  UpdateExpenseParamsEvent(
                    bloc.state.params.copyWith(receipt: state.receipt),
                  ),
                );
              }

              if (state is PickFileSuccess) {
                bloc.add(
                  UpdateExpenseParamsEvent(
                    bloc.state.params.copyWith(receipt: state.receipt),
                  ),
                );
              }
            },
            child:
            BlocSelector<AddExpenseBloc, AddExpenseState, Receipt?>(
              selector: (st) => st.params.receipt,
              builder: (_, receipt) => CustomTextFormField(
                isEnabled: false,
                label: "Attach Receipt",
                hintText: receipt?.name ?? "Upload Image",
                suffixIcon: CustomSvg(
                  path: Assets.images.icCamerScanner,
                  color: Colors.black87,
                  width: 15,
                  height: 15,
                ),
                onSuffixIconTapped: () => showImagePickerDialog(
                  context,
                      () => filePickerCubit.pickImage(),
                      () => filePickerCubit.pickFile(),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
